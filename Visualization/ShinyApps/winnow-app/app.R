
library(ggplot2)
library(Cairo)  
library(DT)





shinyApp(
  
ui = fluidPage(

  titlePanel("Winnow Ouput"),
  
  sidebarLayout(
      sidebarPanel(
            fluidRow(
                selectInput("plot_type", 
                            label = "Choose a plot to display",
                            choices = c("plot1", "ggplot2+geom_line"),
                            selected = "base"),
                selectInput("var1", 
                            label = "Choose first variable to display",
                            choices = c("tp", "fp", "tpr", "fpr","error","accurary"),
                            selected = "tp"),
                selectInput("var2", 
                            label = "Choose second variable to display",
                            choices = c("tp", "fp", "tpr", "fpr","error","accurary"),
                            selected = "fp")
                      )
                  ),
      mainPanel(
              plotOutput("plot1")
                ),
              br(),br(),
              tableOutput("results")
              )
      
            ),


server = function(input, output) {
  output$plot1 = renderPlot({
    if (input$plot_type == "plot1") {
      ggplot(dat,aes_string(x=input$var1,y=input$var2))+geom_point(color="firebrick")
    } else if (input$plot_type == "ggplot2") {
      ggplot(dat,aes_string(x=input$var1,y=input$var2))+geom_line(size = 1, alpha = 1 )+
        labs(title= "Comparison of Rates")
    }
  })
  
  output$results = renderTable({
    sum(dat$tp)
    
  })
  
  
  
}


)
