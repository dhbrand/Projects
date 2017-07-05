tpmax<-function(list){
    tps<-list()
    for (i in 1:length(list)){
        tps[[i]]<-list[[i]]$tp
    }
    y<-unlist(lapply(tps, max))
    return(max(y))
}
ta<-tpmax(myfiles)
#Determines minimum value of all true positives
tpmin<-function(list){
    tps<-list()
    for (i in 1:length(list)){
        tps[[i]]<-list[[i]]$tp
    }
    y<-unlist(lapply(tps, min))
    return(min(y))
}
tb<-tpmin(myfiles)
#Determines median value of all true positives
tpmed<-function(list){
    tps<-list()
    for (i in 1:length(list)){
        tps[[i]]<-list[[i]]$tp
    }
    y<-unlist(lapply(tps, median))
    return(median(y))
}
tc<-tpmed(myfiles)
#Determines maximum value of all false positives
fpmax<-function(list){
    fps<-list()
    for (i in 1:length(list)){
        fps[[i]]<-list[[i]]$fp
    }
    y<-unlist(lapply(fps, max))
    return(max(y))
}
fa<-fpmax(myfiles)
#Determines minimum value of all false positives
fpmin<-function(list){
    fps<-list()
    for (i in 1:length(list)){
        fps[[i]]<-list[[i]]$fp
    }
    y<-unlist(lapply(fps, min))
    return(min(y))
}
fb<-fpmin(myfiles)
#Determines median value of all false positives
fpmed<-function(list){
    fps<-list()
    for (i in 1:length(list)){
        fps[[i]]<-list[[i]]$fp
        y<-unlist(lapply(fps, median))
        return(median(y))
    }
}
fc<-fpmed(myfiles)