setwd("/work/04734/dhbrand/stampede2/Projects/Premium/hybridAnalysis/hybridYieldHPC")


library(PReMiuM)
library(dplyr)
library(readr)

# read in the data as data frame
dat <- read_csv("../hybrid.csv", col_names = TRUE)

# convert all weather variables to numeric type
dat[7:34] <- lapply(dat[7:34],as.numeric)

# grab month for analysis
july <- subset(dat, dat$Month==7)

# check for zero variance in continuous covariates
zero <- which(lapply(july[7:34],var)==0,useNames = TRUE)

# remove constant continous variables
drop <- names(zero)
july <- july[ , !(names(july) %in% drop)]

# find min/max variables
numericVars <- c(grep("min",names(july)) , grep("max",names(july)))

# create directory and change to working directory
dir.create("july")
setwd(paste(getwd(),"july", sep = "/"))

# run the profile regression
system.time({
    
    mod <- profRegr(covNames, outcome = 'Yield',
                    yModel = 'Normal', xModel = "Mixed",
                    discreteCovs = c(names(july["Pedi"])),
                    continuousCovs = c(names(july[numericVars])),
                    data = july,
                    nSweeps = 1000,
                    nBurn = 1000)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 10)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj <-plotRiskProfile(riskProfileOb,"july.png")
