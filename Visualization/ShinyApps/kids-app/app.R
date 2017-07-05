library(shiny)
library(ggplot2)
library(reshape2)
library(shinythemes)
# Define UI for application that draws a histogram
ui <- fluidPage(
    
    theme = shinytheme("paper"),
  # Application title
  titlePanel("Expectation and Variance"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      #For the radio buttons, color and black/white are offered. color is noted "rb" black/white is"bw"
      radioButtons(inputId="clr",label="Color Choices", selected = "rb",choiceNames = c("Color","Black and White"),choiceValues = c("rb","bw"))
    )
    ,
    # Show a plot of the generated distribution
    mainPanel(
        
        # this is an extra div used ONLY to create positioned ancestor for tooltip
        # we don't change its position
        div(
            style = "position:relative",
            plotOutput("plt", 
                       hover = hoverOpts("plot_hover", delay = 50, delayType = "debounce"),heigh=600,width=600),
            uiOutput("hover_info")
        ),
        width = 7,
        br(),
        br(),
        br(),
        br(),
        div(strong("The ",span("y-axis",style="color:red")," of the graph indicates how tall the plants grew."),style="color:darkblue")
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
    dfaa<<-rbind(as.data.frame(df),as.data.frame(dfa))
    
    #set up for the X axis labels
    breaks.major <- c(-10,50,200,260)
    breaks.minor <- c(0,100,110,140,150,250)
    labels.minor <- c("","Normal", "Stress","")
    lims <-c(-10,260)
    #contructing charts
    #check the radio buttons
    colr<<- ifelse(input$clr=="rb",1,0)
    if(colr==1){
      ggplot(xlab="",ylab="") +
        geom_point(data=dfaa,aes(x=ord,y=GroupA,fill="Group A"),shape=21,color="black",stroke=.2*(2+sqrt(3)),alpha=.8,size=2+sqrt(3))+
        geom_point(data=dfaa,aes(x=ord,y=GroupB,fill="Group B"),shape=22,color="black",stroke=.2*(2+sqrt(3)),alpha=.8,size=2+sqrt(3))+
        scale_fill_manual(name="", values=c("Group A"="darkblue", "Group B"="red"))+
        labs(title="Normal vs. Stress Environments", face= "bold")+guides(fill=FALSE)+
        scale_x_continuous(expand=c(0,0), limit=lims, minor_breaks=breaks.minor, breaks=breaks.major, labels = labels.minor)+
        theme(axis.title.x=element_blank(),axis.line.x=element_blank(),
              axis.text.x=element_text(size=18, face="bold", color="black"),
              axis.ticks=element_blank(),
              axis.title.y=element_blank(),
              panel.background = element_rect(fill = "white"),
              plot.title = element_text(size = rel(2),hjust=.5)
        )
    }
    else{
      #contructing charts
      ggplot(xlab="",ylab="") +
        geom_point(data=dfaa,aes(x=ord,y=GroupA,shape="Group A"),fill="white",color="black",stroke=.2*(2+sqrt(3)),alpha=.8,size=2+sqrt(3))+
        geom_point(data=dfaa,aes(x=ord,y=GroupB,shape="Group B"),fill="white",color="black",stroke=.2*(2+sqrt(3)),alpha=.8,size=2+sqrt(3))+
        labs(title="Normal vs. Stress Environments", face= "bold")+
        scale_shape_manual(name='',values=c("Group A"=21,"Group B"=22))+
        scale_x_continuous(expand=c(0,0), limit=lims, minor_breaks=breaks.minor, breaks=breaks.major, labels = labels.minor)+
        theme(axis.title.x=element_blank(),axis.line=element_blank(),
              axis.text.x=element_text(size=18, face="bold", color="black"),
              axis.ticks=element_blank(),
              axis.title.y=element_blank(),
              panel.background = element_rect(fill = "white"),
              plot.title = element_text(size = rel(2),hjust=.5),legend.title=element_blank()
        )
    }
  })
  
  output$hover_info <- renderUI({
      hover <- input$plot_hover
      point <- nearPoints(dfaa, hover, threshold = 100, maxpoints = 10, addDist = TRUE)
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
      if (colr==1){
      if (left_px<5){
          wellPanel(
              style = style,
              p(HTML(paste0("<b> This axis of</b>", "<br/>",
                            "<b> the graph </b>", "<br/>",
                            "<b> indicates </b>", "<br/>",
                            "<b> how tall the </b>", "<br/>",
                            "<b> plants grew. </b>", "<br/>"
              )))
          )
      }
      else if (left_px>=50&top_px<=150){
          wellPanel(
              style = style,
              p(HTML(paste0("<b> Both the red square and blue</b>", "<br/>",
                            "<b> circle plants grew </b>", "<br/>",
                            "<b> tall in normal conditions. </b>", "<br/>")))
          )
      }
      else if(left_px>=300&top_px<350){
          wellPanel(
              style = style,
              p(HTML(paste0("<b> In a tough environment with stress, </b>", "<br/>",
                            "<b> the blue circle plants grew a bit less, </b>", "<br/>",
                            "<b> but not much less than in the normal </b>", "<br/>",
                            "<b> conditions. </b>", "<br/>")))
          )
      }
      else if(left_px>=300&top_px>425){
          wellPanel(
              style = style,
              p(HTML(paste0("<b> In a tough environment with stress, </b>", "<br/>",
                            "<b> the red square plants grew much </b>", "<br/>",
                            "<b> less than in the normal condtion. </b>", "<br/>",
                            "<b> Only a very small number of </b>", "<br/>",
                            "<b> normal plants were as short as </b>", "<br/>",
                            "<b> the stress red square plants. </b>", "<br/>")))
          )
      }
      }
  })
}

  

# Run the application
shinyApp(ui = ui, server = server)