# Example 3 - rewrite the code

library(shiny)

ui <- fluidPage(
  titlePanel("Reactivity"),
  sidebarLayout(
    sidebarPanel(
      textInput("caption", label = "Caption:", value = "Data Summary"),
      selectInput("dataset", label = "Choose a dataset", choices = c("rocks", "pressure", "cars"), selected = "rocks"),
      numericInput("obs",min = 1, label = "Number of observations to view:", value = 10)
    ),
    mainPanel(
      h3(textOutput("caption", container = span)),
      verbatimTextOutput("summary"),
      tableOutput("view")
    )
  )
)

server <- function(input, output, session) {
  datasetInput <- reactive({
    switch (input$dataset,
      "rocks" = rock,
      "pressure" =  pressure,
      "cars" = cars
    )
  })
  output$caption <- renderText(input$caption)
  output$summary <- renderPrint(summary(datasetInput()))
  output$view <-  renderTable(head(datasetInput(), n = input$obs))
}

shinyApp(ui, server)