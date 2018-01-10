#spark_path <- strsplit(system("brew info apache-spark",intern=T)[4],' ')[[1]][1] # Get your spark path
#.libPaths(c(file.path(spark_path,"libexec", "R", "lib"), .libPaths())) # Navigate to SparkR folder
library(SparkR) # Load the library
sc <- sparkR.session()

#if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
    #Sys.setenv(SPARK_HOME = "/usr/local/Cellar/apache-spark/2.2.1/libexec")
#}
#library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sparkR.session()
