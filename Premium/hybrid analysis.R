setwd("~/Stapleton_Lab/Projects/Premium/R work/")

library(dplyr)
library(tidyr)
library(PReMiuM)
library(mice)

pldat <-  read.csv("~/Stapleton_Lab/Projects/Premium/g2f_2015_hybrid_data_no_outliers.csv")
wthdat <- read.csv("~/Stapleton_Lab/Premium/EnviroTyping_USDA/premium/G2F_Weather/monthly_weather_summary.csv/part-00000-8a6a06f9-8194-499f-9c36-42d5ddaeb204.csv")


##need experiment numbers for wthdat
expnstat <- read.csv("~/Stapleton_Lab/Downloads/Carolyn_Lawrence_Dill_G2F_Mar_2017/c._2015_weather_data/g2f_2015_weather_clean.csv")[,2:3]
df <- expnstat[!duplicated(expnstat$Station.ID), ]
colnames(df) <- c("StationID","Exp")

##merge weather data
weather <- merge(df,wthdat)

##split Exp into individual rows
weather <- weather %>% mutate(Exp = strsplit(as.character(Exp), " ")) %>% unnest(Exp)
weather <- weather[,c(1,32,2:31)]

##subset plant data
pldat <- pldat[,c("Field.Location","Pedigree","Grain.yield..bu.acre.")]
colnames(pldat) <- c("Exp","Geno","Yield")

##merge plant and weather data
dat <- merge(pldat,weather)

##check for missing data
md.pattern(dat)

dat <- dat[complete.cases(dat), ]
##setup input for profreg
dat[, c(7:34)] <- sapply(dat[, c(7:34)], as.numeric)

##make csv for batch submission script
write.csv(dat,file="hybrid.csv")


