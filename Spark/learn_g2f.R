setwd("~/Stapleton_Lab/Projects/Spark/")

if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
Sys.setenv(SPARK_HOME = "/usr/local/Cellar/apache-spark/2.2.1/libexec")
}
library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(master = "local[*]", sparkConfig = list(spark.driver.memory = "2g"))

df <- read.csv("~/Stapleton_Lab/Downloads/Carolyn_Lawrence_Dill_G2F_Mar_2017/c._2015_weather_data/g2f_2015_weather_clean.csv")

df2 <- createDataFrame(df)
