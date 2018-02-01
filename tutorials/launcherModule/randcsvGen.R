library(readr)

cars <- as.tibble(mtcars)

for (i in 1:100) {
    df <- cars %>% select(sample(names(cars),6))
    write_csv(df,paste("df",i,".csv",sep = ""))
}
