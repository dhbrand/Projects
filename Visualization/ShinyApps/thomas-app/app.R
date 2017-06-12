library(shiny)
library(ggplot2)
library(reshape2)

# Define UI for application that draws a histogram
ui <- fluidPage(
  # Application title
  titlePanel("Expectation and Variance"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      #For the radio buttons, color and black/white are offered. color is noted "rb" black/white is"bw"
      radioButtons(inputId="clr",label="Color Choices", selected = "bw",choiceNames = c("Black and White","Color"),choiceValues = c("bw","rb"))
    )
    ,
    # Show a plot of the generated distribution
    mainPanel(
      div(
        style = "position:relative",
        plotOutput("plt", 
                   hover = hoverOpts("plot_hover", delay = 50, delayType = "debounce")),
        uiOutput("hover_info")
      ),
      width = 7
    )
  )
)
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  #Render the Plot
  output$plt <- renderPlot({
    #Trying to recreate the Difference between mean and variance shiny plot

    #generating 100 random variables for 1dt data set
    df=data.frame(
      ord=c(1:100),
      GroupA=rnorm(100, mean=3, sd=(3/6)),
      GroupB=rnorm(100, mean=3, sd=(3/6))
    )
    #alternate data frame
    dfa=data.frame(
      ord=c(151:250),
      GroupA=rnorm(100, mean=1.2*.6*3, sd=1.2*.6*(3/6)),
      GroupB=rnorm(100, mean=.8*.6*3, sd=.8*.6*(3/6))
    )
    
    #combine data frames
    data=rbind(as.data.frame(df),as.data.frame(dfa))
    
    #set up for the X axis labels
    breaks.major <- c(-10,50,200,260)
    breaks.minor <- c(0,100,110,140,150,250)
    labels.minor <- c("","Control", "Stress","")
    lims <-c(-10,260)
    #contructing charts
    #check the radio buttons
    colr<- ifelse(input$clr=="rb",1,0)
    if(colr==1){
      ggplot(xlab="",ylab="") +
        geom_point(data=data,aes(x=ord,y=GroupA,fill="Group A"),shape=21,color="black",stroke=.2*(2+sqrt(3)),alpha=.8,size=2+sqrt(3))+
        geom_point(data=data,aes(x=ord,y=GroupB,fill="Group B"),shape=22,color="black",stroke=.2*(2+sqrt(3)),alpha=.8,size=2+sqrt(3))+
        scale_fill_manual(name="", values=c("Group A"="darkblue", "Group B"="red"), guide="legend")+
        geom_segment(aes(x=-10, xend=110, y=3, yend=3))+
        geom_segment(aes(x=135, xend=260, y=.6*3, yend=.6*3))+
        labs(title="Control vs. Stress Environments", face= "bold")+
        guides(fill= guide_legend(override.aes=list(shape=c(21,22))))+
        scale_x_continuous(expand=c(0,0), limit=lims, minor_breaks=breaks.minor, breaks=breaks.major, labels = labels.minor)+
        theme(axis.title.x=element_blank(),
              axis.text.x=element_text(size=18, face="bold", color="black"),
              axis.ticks=element_blank(),
              axis.title.y=element_blank(),
              panel.background = element_rect(fill = "white"),
              plot.title = element_text(size = rel(2),hjust=.5),
              legend.background = element_rect(fill= "white"),
              legend.key = element_blank(),
              legend.text= element_text(size=14)
        )
    }
    else{
      #contructing charts
      ggplot(xlab="",ylab="") +
        geom_point(data=data,aes(x=ord,y=GroupA,shape="Group A"),fill="white",color="black",stroke=.2*(2+sqrt(3)),alpha=.8,size=2+sqrt(3))+
        geom_point(data=data,aes(x=ord,y=GroupB,shape="Group B"),fill="white",color="black",stroke=.2*(2+sqrt(3)),alpha=.8,size=2+sqrt(3))+
        geom_segment(aes(x=-10, xend=110, y=3, yend=3))+
        geom_segment(aes(x=135, xend=260, y=.6*3, yend=.6*3))+
        labs(title="Control vs. Stress Environments", face= "bold")+
        scale_shape_manual(name='',values=c("Group A"=21,"Group B"=22))+
        guides(shape= guide_legend(override.aes=list(shape=c(21,22))))+
        scale_x_continuous(expand=c(0,0), limit=lims, minor_breaks=breaks.minor, breaks=breaks.major, labels = labels.minor)+
        theme(axis.title.x=element_blank(),
              axis.text.x=element_text(size=18, face="bold", color="black"),
              axis.ticks=element_blank(),
              axis.title.y=element_blank(),
              panel.background = element_rect(fill = "white"),
              plot.title = element_text(size = rel(2),hjust=.5),
              legend.background = element_rect(fill= "white"),
              legend.key = element_blank(),
              legend.text= element_text(size=14)
        )
    }
  }
  )
  output$hover_info <- renderUI({
    hover <- input$plot_hover
    point <- nearPoints(data, hover, threshold = 50, maxpoints = 1, addDist = TRUE)
    if (nrow(point) == 0) return(NULL)
    
    # calculate point position INSIDE the image as percent of total dimensions
    # from left (horizontal) and from top (vertical)
    left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
    top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
    
    # calculate distance from left and bottom side of the picture in pixels
    left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
    top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
    
    # create style property fot tooltip
    # background color is set so tooltip is a bit transparent
    # z-index is set so we are sure are tooltip will be on top
    style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                    "left:", left_px + 2, "px; top:", top_px + 2, "px;")
    
    # actual tooltip created as wellPanel
    wellPanel(
      style = style,
      p(HTML(paste0("<b> value: </b>", rownames(point), "<br/>",
                    "<b> Distance from left: </b>", left_px, "<b>, from top: </b>", top_px)))
    )
  })
} 
# Run the application
shinyApp(ui = ui, server = server)