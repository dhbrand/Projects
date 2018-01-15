###job script for batch submission

#setwd("~/Stapleton_Lab/Projects/Premium/R work/")
library(PReMiuM)

dat <- read.csv("../hybrid.csv", row.names = 1,header=TRUE)

##changed Geno to Pedi and need update csv on stampede2
dat$Pedi<-as.character(dat$Pedi)
##subsetting for only min max cov's
numericVars <- c(grep("min",names(dat)) , grep("max",names(dat)))
#numericVars <- which(sapply(dat, class)=='numeric' & names(dat) != 'Yield')
categoricalVars <- which(sapply(dat, class)=='character' & names(dat) != 'Yield')

system.time({
    
    mod <- profRegr(covName, outcome = 'Yield', nSweeps = 10, nBurn = 1,
                    yModel = 'Normal', xModel = "Mixed",
                    #nCovariates = 2,
                    #fixedEffectsNames = 'yield',
                    discreteCovs = c(names(dat[categoricalVars])),
                    continuousCovs = c(names(dat[numericVars])),
                    data = dat)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 4)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj<-plotRiskProfile(riskProfileOb,"summary.png")
