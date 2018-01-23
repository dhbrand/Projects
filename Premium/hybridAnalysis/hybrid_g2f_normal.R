library(PReMiuM)
library(tidyverse)
library(readr)

setwd("~/Stapleton_Lab/Projects/Premium/hybridAnalysis/")

# read in data from analysis script
df <- read_csv("./hybrid.csv")

df %>% 
    select_if(function(x) any(is.na(x))) %>% 
    summarise_all(funs(sum(is.na(.))))


# grab month for analysis
march <- df %>% 
    filter(Month==3)
april <- df %>% 
    filter(Month==4)
may <- df %>% 
    filter(Month==5)
june <- df %>% 
    filter(Month==6)
july <- df %>% 
    filter(Month==7)
aug <- df %>% 
    filter(Month==8)
sept <- df %>% 
    filter(Month==9)
oct <- df %>% 
    filter(Month==10)
nov <- df %>% 
    filter(Month==11)
# check for zero variance in continuous covariates
zero <- which(lapply(may[10:31],var)==0,useNames = TRUE)
slice(df, 1:n())

june %>% 
    
    select(c(grep("Min",names(may)) , grep("Max",names(may)))) %>% 
    
    summarise_all(var) %>% 
    
    filter_if(all, all_vars(. = 0))

filter(noVar, solarMin == 0)
unique(may$solarMin)
    
filter_all(noVar, any_vars(.==0))
filter_if(noVar, ~ all(floor(.) == .), all_vars(. == 0))


# remove constant continous variables
drop <- names(zero)
may <- may[ , !(names(may) %in% drop)]
oct <- oct[ , !(names(oct) %in% drop)]
# replace 0's with smallest value supported by current machine
# dat[dat==0] <- .Machine$double.eps

# limited to 15 covariates in plotRiskProfile; subsetting to only min and max weather data
numericVars <- c(grep("Min",names(may)) , grep("Max",names(may)))
numericVars <- sample(numericVars,14)

# created dataframes for each of the months to be run seperately
# datmon <- split(dat,dat$Month)
# groups <- unique(dat$Month)
# list2env(setNames(datmon,month.abb[groups]), .GlobalEnv)

system.time({
    
    mod <- profRegr(covNames, outcome = 'Yield', output = "./miscOutput",
                    yModel = 'Normal', xModel = "Mixed",
                    discreteCovs = c(names(may["Pedi"])),
                    continuousCovs = c(names(may[numericVars])),
                    data = may,
                    nSweeps = 10,
                    nBurn = 1)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 4)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj<-plotRiskProfile(riskProfileOb,"summary.png")

