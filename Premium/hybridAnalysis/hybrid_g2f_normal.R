# job script for batch submission

setwd("~/Stapleton_Lab/Projects/Premium/R work/")
library(PReMiuM)

# read in data from analysis script
dat <- read.csv("../hybrid.csv", row.names = NULL, header=TRUE)

# replace 0's with smallest value supported by current machine
# dat[dat==0] <- .Machine$double.eps

# limited to 15 covariates in plotRiskProfile; subsetting to only min and max weather data
numericVars <- c(grep("min",names(dat)) , grep("max",names(dat)))

# created dataframes for each of the months to be run seperately
datmon <- split(dat,dat$Month)
groups <- unique(dat$Month)
list2env(setNames(datmon,month.abb[groups]), .GlobalEnv)

system.time({
    
    mod <- profRegr(covNames = c("temp_min","temp_max"), outcome = 'Yield',
                    yModel = 'Normal', xModel = "Mixed",
                    fixedEffectsNames = 'Yield',
                    discreteCovs = c(names(june["Pedi"])),
                    continuousCovs = c(names(june[numericVars])),
                    data = june,
                    nSweeps = 10,
                    nBurn = 1)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 4)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj<-plotRiskProfile(riskProfileOb,"summary.png")

