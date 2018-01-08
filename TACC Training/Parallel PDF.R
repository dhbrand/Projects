setwd("~/Stapleton_Lab/TACC Training/Data Analysis with R on HPC/")

myProc <- function(size=10000000){
    #Load a large vector
    vec <- rnorm(size)
    
    #Now sleep on it
    Sys.sleep(2)
    
    #Now sum the vec values
    return(sum(vec))
}
ptm <- proc.time()
myProc(100000000)

proc.time() - ptm

Sys.getpid()

#system('top -b -n 1 -U $USER', intern=TRUE)

ptm <- proc.time()
result <- c()
for(i in 1:10){
    result <- c(result,myProc())
}
proc.time() - ptm

ptm <- proc.time()
result <- sapply(1:10, function(i) myProc())
proc.time() - ptm

##install.packages("snow")
require(snow)

hostnames <- rep('localhost', 4)
cluster <- makeSOCKcluster(hostnames)

clusterExport(cluster, list('myProc'))

ptm <- proc.time()
result <- clusterApply(cluster, 1:10, function(i) myProc())
proc.time() - ptm

stopCluster(cluster)
