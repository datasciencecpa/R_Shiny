library(shiny)

ui <- fluidPage(
  title("Shiny Example 2"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "dataset", label = "Choose a dataset:", 
                  choices = c("rocks", "pressure", "cars"), selected = "rocks"),
      br(), 
      numericInput(inputId = "obs", label = "Number of observations to view:",
                   min = 0, value = 10
      )
    ),
    mainPanel(
      verbatimTextOutput(outputId = "summary"),
      tableOutput(outputId = "view")
    )
  )
)

server <- function(input, output, session) {
  dataset <- reactive({
    switch (input$dataset,
      "rocks" = rock,
      "pressure" = pressure,
      "cars" = cars
    )
  })
  output$summary <- renderPrint(summary(dataset()))
  output$view <- renderTable(head(dataset(), n= input$obs))
}

shinyApp(ui, server)