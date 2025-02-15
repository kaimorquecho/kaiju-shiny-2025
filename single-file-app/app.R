# load packages ---
library(shiny)
library(ggplot2)
library(tidyverse)
library(palmerpenguins)

# user interface ---
ui <- fluidPage(
  
  # app title
  tags$h1("My App Title"),
  
  # app subtitle
  h4(strong("Exploring Antartic Penguin Data")),
  
  # body mass slider input
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g)",
              min = 2700, max = 6300, value = c(3000,4000)),
  
  # body mass plot output
  plotOutput(outputId = "body_mass_scatterplot_output"),
  
  checkboxGroupInput(inputId = "year_input",
                     label = "Select year(s):",
                     choices = c(2007,2008,2009),# unique(penguins$year)
                     selected = c(2007, 2008)
                     ),
  # DT output
  DT::dataTableOutput(outputId = "penguin_DT_output")
  
  )

# server ----
server <- function(input, output){
  
  
  # filter my body masses 
  body_mass_df <- reactive({
    
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
    
  })
  
  
  # render penguin scatter plot -
  output$body_mass_scatterplot_output <- renderPlot({
    
    ggplot(na.omit(body_mass_df()), 
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "indianred2", "Chinstrap" = "skyblue3", "Gentoo" = "gold")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
           color = "Penguin species", shape = "Penguin species") +
      guides(color = guide_legend(position = "inside"),
             size = guide_legend(position = "inside")) +
      theme_minimal() +
      theme(text = element_text(family = "courier"),
            legend.position.inside = c(0.85, 0.2), 
            legend.background = element_rect(color = "black"))
    
  })
  
  # filter penguins by year 
  
  select_years_df <- reactive({
    penguins %>% 
    filter(year %in% c(input$year_input[1],input$year_input[2]))
  })
  
  # render a DT data table of penguins data
  output$penguin_DT_output <- renderDataTable({
    DT::datatable(select_years_df())
  })
  
  
}

# combine our UI and server into an app ---
shinyApp(ui = ui, server = server)
