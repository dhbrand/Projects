library(tidyverse)

setwd("~/Stapleton_Lab/Projects/Premium/weatherAnalysis/")

# import cleaned weather dataset
wth <- read_csv("~/Stapleton_Lab/Downloads/Carolyn_Lawrence_Dill_G2F_Mar_2017/c._2015_weather_data/g2f_2015_weather_clean.csv", col_names = TRUE)

# tidy the data
wth1 <- wth %>% 

    select(Exp = "Experiment(s)", Day, Month, Year, Temp = "Temperature [C]",
            Dew = "Dew Point [C]", Humid = "Relative Humidity [%]", Solar = "Solar Radiation [W/m2]", 
            Rain = "Rainfall [mm]", windSpd = "Wind Speed [m/s]", windDir = "Wind Direction [degrees]", 
            windGust = "Wind Gust [m/s]", soilTemp = "Soil Temperature [C]", soilMoist = "Soil Moisture [%]") %>% 
    
    group_by(Exp, Year, Month, Day) %>% 

    arrange(Exp, Year, Month, Day) %>% 
    
    drop_na()

wth2 <- wth1 %>% 
    summarise(tempMin = min(Temp), tempMax = max(Temp), dewMin = min(Dew), dewMax = max(Dew), 
              humidMin = min(Humid), humidMax = max(Humid), solarMin = min(Solar), solarMax = max(Solar),
              rainMin = min(Rain), rainMax = max(Rain), windSpdMin = min(windSpd), windSpdMax = max(windSpd),
              windDirMin = min(windDir), windDirMax = max(windDir), windGustMin = min(windGust),
              windGustMax = max(windGust), soilTempMin = min(soilTemp), soilTempMax = max(soilTemp),
              soilMoistMin = min(soilMoist), soilMoistMax = max(soilMoist))

