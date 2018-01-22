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
dec <- subset(dat, dat$Month==12)

# check for zero variance in continuous covariates
zero <- which(lapply(dec[7:34],var)==0,useNames = TRUE)

# remove constant continous variables
drop <- names(zero)
dec <- dec[ , !(names(dec) %in% drop)]

# find min/max variables
numericVars <- c(grep("min",names(dec)) , grep("max",names(dec)))

# create directory and change to working directory
dir.create("dec")
setwd(paste(getwd(),"dec", sep = "/"))

# run the profile regression
system.time({
    
    mod <- profRegr(covNames, outcome = 'Yield',
                    yModel = 'Normal', xModel = "Mixed",
                    discreteCovs = c(names(dec["Pedi"])),
                    continuousCovs = c(names(dec[numericVars])),
                    data = dec,
                    nSweeps = 10,
                    nBurn = 1)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 2)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj <-plotRiskProfile(riskProfileOb,"dec.png")
