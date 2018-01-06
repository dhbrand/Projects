
##import cleaned weather dataset
dataset <- read.csv("~/Stapleton_Lab/Downloads/Carolyn_Lawrence_Dill_G2F_Mar_2017/c._2015_weather_data/g2f_2015_weather_clean.csv")

##grabbing all the different experiment IDs
expnum <- unique(dataset$`Experiment(s)`)

##cleaning variable names
temp <- dataset$`Temperature [C]`
dew <- dataset$`Dew Point [C]`
relativehum <- dataset$`Relative Humidity [%]`
solarrad <- dataset$`Solar Radiation [W/m2]`
rain <- dataset$`Rainfall [mm]`
windspeed <- dataset$`Wind Speed [m/s]`
winddir <- dataset$`Wind Direction [degrees]`
windgust <- dataset$`Wind Gust [m/s]`
soiltemp <- dataset$`Soil Temperature [C]`
soilmoist <- dataset$`Soil Moisture [%]`

##weather variables
##need diff method
weather <- data.frame(c(temp, dew, relativehum, solarrad, rain, windspeed, winddir, windgust, soiltemp, soilmoist))

##write function to find min and max of each day for weather variables on each experiment
mindaytemp <- min(dataset$Temperature..C.[dataset$Experiment.s.],rm.na=TRUE)
mindaytemp <- sapply(dataset$temp, FUN = min)
length(dataset$temp)
