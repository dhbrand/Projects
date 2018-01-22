#setwd("/work/04734/dhbrand/stampede2/Premium/hybrid_g2f_month")
setwd("~/Stapleton_Lab/Projects/Premium/hybridG2Fmonth/")

library(PReMiuM)
library(dplyr)
library(readr)

# read in the data as data frame
dat <- read_csv("../hybrid.csv", col_names = TRUE)

# convert all weather variables to numeric type
dat[7:34] <- lapply(dat[7:34],as.numeric)

# grab month for analysis
april <- subset(dat, dat$Month==4)

# check for zero variance in continuous covariates
zero <- which(lapply(april[7:34],var)==0,useNames = TRUE)

# remove constant continous variables
drop <- names(zero)
april <- april[ , !(names(april) %in% drop)]

# find min/max variables
numericVars <- c(grep("min",names(april)) , grep("max",names(april)))

# create directory and change to working directory
dir.create("april")
setwd(paste(getwd(),"april", sep = "/"))

# run the profile regression
system.time({
    
    mod <- profRegr(covNames, outcome = 'Yield',
                    yModel = 'Normal', xModel = "Mixed",
                    discreteCovs = c(names(april["Pedi"])),
                    continuousCovs = c(names(april[numericVars])),
                    data = april,
                    nSweeps = 10,
                    nBurn = 1)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 2)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj <-plotRiskProfile(riskProfileOb,"april.png")
