
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
                            choices = c("geom_point", "geom_line"),
                            selected = "base"),
                selectInput("var1", 
                            label = "Choose x-axis variable to display",
                            choices = c("tp", "fp", "tpr", "fpr","error","accuracy"),
                            selected = "tp"),
                selectInput("var2", 
                            label = "Choose y-axis variable to display",
                            choices = c("tp", "fp", "tpr", "fpr","error","accuracy"),
                            selected = "fp")
                      )
                  ),
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
                    )
              )    
            )#ends tabsetPanel
          )#ends mainPanel
      )#ends sidebarLayout
  ),#end ui = fluidPage


server = function(input, output) {
  output$plot1 = renderPlot({
    if (input$plot_type == "geom_point") {
      ggplot(dat,aes_string(x=input$var1,y=input$var2))+geom_point(color="firebrick")
    } else if (input$plot_type == "geom_line") {
      ggplot(dat,aes_string(x=input$var1,y=input$var2))+geom_line(size = 1, alpha = 1 )+
        labs(title= "Comparison of Rates")
    }
  })
  
  output$meanresults = renderTable({apply(dat[,1:4],2,mean)},rownames=TRUE,caption=paste("test"))
  
  output$sumresults = renderTable(apply(dat[,5:8],2,sum),rownames=TRUE)
  
  output$meanresults2 = renderTable(apply(dat[,9:17],2,mean),rownames=TRUE)
  
  
  
}


)
