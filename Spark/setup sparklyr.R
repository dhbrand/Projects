#install.packages("sparklyr")
#library(sparklyr)
#spark_install(version = "2.1.0")
#install.packages("devtools")
#devtools::install_github("rstudio/sparklyr")
library(sparklyr)
sc <- spark_connect(master = "local")

#install.packages(c("nycflights13","Lahman"))

library(dplyr)

iris_tbl <- copy_to(sc,iris)
flights_tbl <- copy_to(sc,nycflights13::flights, "flights")
batting_tbl <- copy_to(sc, Lahman::Batting, "batting")

src_tbls(sc)

flights_tbl %>% filter(dep_delay == 2)

delay <- flights_tbl %>% 
    group_by(tailnum) %>%
    summarise(count = n(), dist = mean(distance), delay = mean(arr_delay)) %>%
    filter(count > 20, dist < 2000, !is.na(delay)) %>%
    collect

library(ggplot2)

ggplot(delay, aes(dist, delay)) +
    geom_point(aes(size = count), alpha = 1/2) +
    geom_smooth() +
    scale_size_area(max_size = 2)

library(DBI)
iris_preview <- dbGetQuery(sc, "SELECT * FROM iris LIMIT 10")
iris_preview
