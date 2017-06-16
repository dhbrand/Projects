
library(ggplot2)
library(plyr)
library(Cairo)  
library(DT)


##User must specify full path for the directory that contains Winnow Output Test Files
dir="~/Stapleton_Lab/Projects/Visualization/Demonstrate/Winnow Results"

readFiles <- function(dir) {
    setwd(dir)
    files <- Sys.glob("*.txt")
    listOfFiles <- lapply(files, function(x) read.table(x, header=TRUE))
    return(listOfFiles)
}
filenames <- unlist(tools::file_path_sans_ext(Sys.glob("*.txt")))
myfiles<-readFiles(dir)

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

all.data<-do.call("rbind", myfiles)

TPFP <- ddply(all.data, .(tp, fp, file()), summarize, count=length(file))


shinyApp(
  
  ui = fluidPage(
    
    titlePanel("Winnow Ouput"),
    
    sidebarLayout(
      sidebarPanel(
        fluidRow(
          column(width=12,
                 div(class = "option_group",
                     radioButtons("plot_type", "Plot type",
                     c("geom_point", "geom_line", "auc by mae","tp by fp"), inline = TRUE),
                     
                     conditionalPanel("input.plot_type === 'geom_point'",
                                      selectInput("pvar1", "x-Var",
                                                  c("tp" = "tp",
                                                    "fp" = "fp"
                                                    ),
                                                  selectize = TRUE
                                      ),
                                      selectInput("pvar2", "y-Var",
                                                  c("tp" = "tp",
                                                    "fp" = "fp"
                                                  ),
                                                  selectize = TRUE
                                      )
                     ),
                     conditionalPanel("input.plot_type === 'geom_line'",
                                      selectInput("lvar1", "x-Var",
                                                  c("tpr" = "tpr",
                                                    "fpr" = "fpr"
                                                    ),
                                                  selectize = FALSE
                                                  ),
                                      selectInput("lvar2", "y-Var",
                                                  c("tpr" = "tpr",
                                                    "fpr" = "fpr"
                                                    ),
                                                  selectize = FALSE
                                                  )
                                      ),
                     conditionalPanel("input.plot_type === 'auc by mae'",
                                      numericInput("auc.min", "AUC axis minimum:", 0),
                                      numericInput("auc.max", "AUC axis maximum:", 1),
                                      numericInput("mae.min", "MAE axis minimum:", 0),
                                      numericInput("mae.max", "MAE axis maximum:", 2)
                     )
                  )#ends div
                 )#ends column
        )#ends fluidRow
      )#ends sidebarPanel
          ,
      mainPanel(
        tabsetPanel(
          tabPanel("Plot",plotOutput("plot1")),
          tabPanel("Table",
                   
                   fluidRow(
                     column(4,
                            h4("means"),
                            tableOutput("meanresults")
                     ),
                     column(4,
                            h4("sums"),
                            tableOutput("sumresults")
                     ),
                     column(4,
                            h4("means"),
                            tableOutput("meanresults2")
                     )
                   )#end fluidRow
          )#ends tablPale
        )#ends tabsetPanel  
      )#ends mainPanel
     )#ends sidebarLayout
    ),#ends ui = fluidPage

  
  
  server = function(input, output) {
    
    output$plot1 = renderPlot({
      if (input$plot_type == "geom_point") {
        ggplot(all.data,aes_string(x=input$pvar1,y=input$pvar2))+geom_point(color="firebrick")
      } else if (input$plot_type == "geom_line") {
        ggplot(all.data,aes_string(x=input$lvar1,y=input$lvar2))+geom_line(size = 1, alpha = 1 )+
          labs(title= "Comparison of Rates")
      }
        else if (input$plot_type == "auc by mae"){
            plot(myfiles[[1]]$mae, myfiles[[1]]$auc, main="Plot of AUC by MAE", xlab="Mean Absolute Error (MAE)", ylab="Area under R-O Curve (AUC)", 
                 pch=21, bg="black", xlim=c(input$mae.min, input$mae.max), ylim=c(input$auc.min,input$auc.max))
            plotcol<-c("black")
           
             if (length(myfiles) > 1){
                #Create overlapping data plots to compare potentially by GWAS tool
                #assuming that the length of the Winnow files is at least 2
                for (i in 2:length(myfiles)){
                    points(myfiles[[i]]$mae, myfiles[[i]]$auc, main="Plot of AUC by MAE", xlab="Mean Absolute Error (MAE)", ylab="Area under R-O Curve (AUC)",
                           pch=21, bg=rainbow(i+1)[i], xlim=c(input$mae.min, input$mae.max), ylim=c(input$auc.min,input$auc.max))
                    plotcol[i]<-rainbow(i+1)[i]
                    
                }
             }
        }
        else if (input$plot_type == "tp by fp"){
        p <- ggplot(TPFP, aes(x=fp, y=tp), environment=environment())
        
        p2 <- p + 
            geom_rect(data=all.data[1,], aes(xmin=fc, xmax=fa, ymin=tc, ymax=ta), 
                      alpha=0.2, fill="blue", linetype=0) +
            geom_rect(data=all.data[1,], aes(xmin=fb, xmax=fc, ymin=tc, ymax=ta), 
                      alpha=0.2,fill="green", linetype=0) +
            geom_rect(data=all.data[1,], aes(xmin=fb, xmax=fc, ymin=tb, ymax=tc), 
                      alpha=0.2, fill="blue", linetype=0) +
            geom_rect(data=all.data[1,], aes(xmin=fc, xmax=fa, ymin=tb, ymax=tc), 
                      alpha=0.2, fill="gray", linetype=0) +
            theme(panel.background=element_rect(fill='white', colour='black')) +
            theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank()) +
            geom_point(aes(colour=file, size=count)) +
            scale_size_continuous(range=c(2,8)) +
            xlab("False Positives") +
            ylab("True Positives") +
            ggtitle("False Positives by True Positves") +
            xlim(0, fa) + ylim(0, ta)
        print(p2)
        }
        
    })
    
    output$meanresults = renderTable({apply(all.data[,1:4],2,mean)},rownames=TRUE,caption=paste("test"))
    
    output$sumresults = renderTable(apply(all.data[,5:8],2,sum),rownames=TRUE)
    
    output$meanresults2 = renderTable(apply(all.data[,9:17],2,mean),rownames=TRUE)
    
    
    
  }#ends server
  
  
  )#ends shinyApp


