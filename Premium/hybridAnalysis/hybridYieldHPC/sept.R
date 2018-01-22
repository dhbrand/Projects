setwd("/work/04734/dhbrand/stampede2/Projects/Premium/hybridAnalysis/hybridYieldHPC")

library(PReMiuM)
library(dplyr)
library(readr)

# read in the data as data frame
dat <- read_csv("../hybrid.csv", col_names = TRUE)

# convert all weather variables to numeric type
dat[7:34] <- lapply(dat[7:34],as.numeric)

# grab month for analysis
sept <- subset(dat, dat$Month==9)

# check for zero variance in continuous covariates
zero <- which(lapply(sept[7:34],var)==0,useNames = TRUE)

# remove constant continous variables
drop <- names(zero)
sept <- sept[ , !(names(sept) %in% drop)]

# find min/max variables
numericVars <- c(grep("min",names(sept)) , grep("max",names(sept)))

# create directory and change to working directory
dir.create("sept")
setwd(paste(getwd(),"sept", sep = "/"))

# run the profile regression
system.time({
    
    mod <- profRegr(covNames, outcome = 'Yield',
                    yModel = 'Normal', xModel = "Mixed",
                    discreteCovs = c(names(sept["Pedi"])),
                    continuousCovs = c(names(sept[numericVars])),
                    data = sept,
                    nSweeps = 1000,
                    nBurn = 1000)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 10)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj <-plotRiskProfile(riskProfileOb,"sept.png")
