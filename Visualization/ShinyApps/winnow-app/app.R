
library(ggplot2)
library(Cairo)  
library(DT)





shinyApp(
  
  ui = fluidPage(
    
    titlePanel("Winnow Ouput"),
    
    sidebarLayout(
      sidebarPanel(
        fluidRow(
          column(width=12,
                 div(class = "option_group",
                     radioButtons("plot_type", "Plot type",
                     c("geom_point", "geom_line"), inline = TRUE),
                     
                     conditionalPanel("input.plot_type === 'geom_point'",
                                      selectInput("pvar1", "x-Var",
                                                  c("tp" = "tp",
                                                    "fp" = "fp"
                                                    ),
                                                  selectize = FALSE
                                      ),
                                      selectInput("pvar2", "y-Var",
                                                  c("tp" = "tp",
                                                    "fp" = "fp"
                                                  ),
                                                  selectize = FALSE
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
        ggplot(dat,aes_string(x=input$pvar1,y=input$pvar2))+geom_point(color="firebrick")
      } else if (input$plot_type == "geom_line") {
        ggplot(dat,aes_string(x=input$lvar1,y=input$lvar2))+geom_line(size = 1, alpha = 1 )+
          labs(title= "Comparison of Rates")
      }
    })
    
    output$meanresults = renderTable({apply(dat[,1:4],2,mean)},rownames=TRUE,caption=paste("test"))
    
    output$sumresults = renderTable(apply(dat[,5:8],2,sum),rownames=TRUE)
    
    output$meanresults2 = renderTable(apply(dat[,9:17],2,mean),rownames=TRUE)
    
    
    
  }#ends server
  
  
  )#ends shinyApp


