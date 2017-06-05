
library(ggplot2)
library(Cairo)   # For nicer ggplot2 output when deployed on Linux

ui <- fluidPage(
  # Some custom CSS for a smaller font for preformatted text
  titlePanel("Winnow Ouput"),
  
  sidebarLayout(
      sidebarPanel(
            fluidRow(
                selectInput("plot_type", 
                            label = "Choose a plot to display",
                            choices = c("base", "ggplot2"),
                            selected = "base"),
                selectInput("var1", 
                            label = "Choose first variable to display",
                            choices = c("tp", "fp", "tpr", "fpr"),
                            selected = "tp"),
                selectInput("var2", 
                            label = "Choose second variable to display",
                            choices = c("tp", "fp", "tpr", "fpr"),
                            selected = "fp")
                      )
                  ),
      mainPanel(
               plotOutput("plot1")
                )
              )
      
            )


server <- function(input, output) {
  output$plot1 <- renderPlot({
    if (input$plot_type == "base") {
      plot(dat$tp, dat$fp)
    } else if (input$plot_type == "ggplot2") {
      ggplot(dat,aes(input$var1,input$var2,color="red"))+geom_line(size = 1, alpha = 1)+
        labs(title= "ROC curve", 
             x = "False Positive Rate (1-Specificity)", 
             y = "True Positive Rate (Sensitivity)")
    }
  })
  
  
  
}


shinyApp(ui, server)