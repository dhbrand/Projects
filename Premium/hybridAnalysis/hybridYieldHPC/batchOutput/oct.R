setwd("/work/04734/dhbrand/stampede2/Projects/Premium/hybridAnalysis/hybridYieldHPC")

library(PReMiuM)
library(dplyr)
library(readr)

# read in the data as data frame
dat <- read_csv("../hybrid.csv", col_names = TRUE)
as_tibble(dat)

# convert all weather variables to numeric type
dat[7:34] <- lapply(dat[7:34],as.numeric)

# grab month for analysis
oct <- subset(dat, dat$Month==10)

# check for zero variance in continuous covariates
zero <- which(lapply(oct[7:34],var)==0,useNames = TRUE)

# remove constant continous variables
drop <- names(zero)
oct <- oct[ , !(names(oct) %in% drop)]

# find min/max variables
numericVars <- c(grep("min",names(oct)) , grep("max",names(oct)))

# create directory and change to working directory
dir.create("oct")
setwd(paste(getwd(),"oct", sep = "/"))

# run the profile regression
system.time({
    
    mod <- profRegr(covNames, outcome = 'Yield',
                    yModel = 'Normal', xModel = "Mixed",
                    discreteCovs = c(names(oct["Pedi"])),
                    continuousCovs = c(names(oct[numericVars])),
                    data = oct,
                    nSweeps = 1000,
                    nBurn = 1000)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 10)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj <-plotRiskProfile(riskProfileOb,"oct.png")
