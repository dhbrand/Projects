library(dplyr)
library(plyr)

setwd("~/Stapleton_Lab/Projects/Premium/R work/")

##import cleaned weather dataset
df <- read.csv("~/Stapleton_Lab/Downloads/Carolyn_Lawrence_Dill_G2F_Mar_2017/c._2015_weather_data/g2f_2015_weather_clean.csv")

##renaming variables
df1 <- rename(df, c("Record.Number"="recnum", "Station.ID"="station", "Experiment.s."="exp", "Day.of.Year"="daynum",
                "Time..Local."="timelocal", "Datetime..UTC."="timeUTC", "Temperature..C."="temp", 
                "Dew.Point..C."="dew", "Relative.Humidity...."="relhum", "Solar.Radiation..W.m2."="solrad",
                "Rainfall..mm."="rain", "Wind.Speed..m.s."="windspeed", "Wind.Direction..degrees."="winddir",
                "Wind.Gust..m.s."="windgust", "Soil.Temperature..C."="soiltemp", "Soil.Moisture...."="soilmoist"))

##check missing values
#install.packages("mice")
library(mice)
md.pattern(df[,c(10,14)])


library(Hmisc)
impute(df1$temp, mean)  # replace with mean
md.pattern

##replace missing values with Random Forest
miceMod <- mice(df[, !names(df) %in% df[10]], method="rf")
df2 <- complete(miceMod)
##replacing missing weather obs with knnImputation 
##install.packages("DMwR")
library(DMwR)
knnOutput <- knnImputation(df[, !names(df) %in% df[10]])  # perform knn imputation.
anyNA(df[10])

##group by experiment and day and summarize on temperature
grp_cols <- names(df[,c(3,7)])
dots <- lapply(grp_cols, as.symbol)
df1 <- df %>% group_by(.dots=dots) %>% summarise(m = mean(df$Temperature..C.,rm.na=TRUE))

##easier to call variables
attach(dataset)

##weather variables
##need diff method
weather <- data.frame(c(temp, dew, relativehum, solarrad, rain, windspeed, winddir, windgust, soiltemp, soilmoist))

##write function to find min and max of each day for weather variables on each experiment
mindaytemp <- min(dataset$Temperature..C.[dataset$Experiment.s.],rm.na=TRUE)
mindaytemp <- sapply(dataset$temp, FUN = min)
length(dataset$temp)
