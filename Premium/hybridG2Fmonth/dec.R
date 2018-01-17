setwd("/work/04734/dhbrand/stampede2/Premium/hybrid_g2f_month")
library(PReMiuM)
dat <- read.csv("../hybrid.csv", row.names = NULL, header=TRUE)
dec <- subset(dat, dat$Month==12)

numericVars <- c(grep("min",names(dat)) , grep("max",names(dat)))
dir.create("dec")
setwd(paste(getwd(),"dec", sep = "/"))
system.time({
    
    mod <- profRegr(covNames = c("temp_min","temp_max"), outcome = 'Yield',
                    yModel = 'Normal', xModel = "Mixed",
                    fixedEffectsNames = 'Yield',
                    discreteCovs = c(names(dec["Pedi"])),
                    continuousCovs = c(names(dec[c(9,10,13,14,17,18)])),
                    data = dec,
                    nSweeps = 10,
                    nBurn = 1)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 2)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj<-plotRiskProfile(riskProfileOb,"dec.png")
