setwd("/work/04734/dhbrand/stampede2/Projects/Premium/hybridAnalysis/hybridYieldHPC")

library(PReMiuM)
library(dplyr)
library(readr)

#read in the data as data frame
dat <- read_csv("../hybrid.csv", col_names = TRUE)

# convert all weather variables to numeric type
dat[7:34] <- lapply(dat[7:34],as.numeric)

# grab month for analysis
may <- subset(dat, dat$Month==5)

# check zero variance in continuous covariates
zero <- which(lapply(may[7:34],var)==0,useNames = TRUE)

# remove constant continous variables
drop <- names(zero)
may <- may[ , !(names(may) %in% drop)]

# find min/max variables
numericVars <- c(grep("min",names(may)) , grep("max",names(may)))

# create directory and change to working directory
dir.create("may")
setwd(paste(getwd(),"may", sep = "/"))

# run the profile regression
system.time({
    
    mod <- profRegr(covNames, outcome = 'Yield',
                    yModel = 'Normal', xModel = "Mixed",
                    discreteCovs = c(names(may["Pedi"])),
                    continuousCovs = c(names(may[numericVars])),
                    data = may,
                    nSweeps = 1000,
                    nBurn = 1000)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 10)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj <-plotRiskProfile(riskProfileOb,"may.png")
