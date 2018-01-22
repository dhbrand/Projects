setwd("/work/04734/dhbrand/stampede2/Projects/Premium/hybridAnalysis/hybridYieldHPC")

library(PReMiuM)
library(dplyr)
library(readr)

# read in the data as data frame
dat <- read_csv("../hybrid.csv", col_names = TRUE)

# convert all weather variables to numeric type
dat[7:34] <- lapply(dat[7:34],as.numeric)

# grab month for analysis
nov <- subset(dat, dat$Month==11)

# check for zero variance in continuous covariates
zero <- which(lapply(nov[7:34],var)==0,useNames = TRUE)

# remove constant continous variables
drop <- names(zero)
nov <- nov[ , !(names(nov) %in% drop)]

# find min/max variables
numericVars <- c(grep("min",names(nov)) , grep("max",names(nov)))

# create directory and change to working directory
dir.create("nov")
setwd(paste(getwd(),"nov", sep = "/"))

# run the profile regression
system.time({
    
    mod <- profRegr(covNames, outcome = 'Yield',
                    yModel = 'Normal', xModel = "Mixed",
                    discreteCovs = c(names(nov["Pedi"])),
                    continuousCovs = c(names(nov[numericVars])),
                    data = nov,
                    nSweeps = 1000,
                    nBurn = 1000)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 10)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj <-plotRiskProfile(riskProfileOb,"nov.png")
