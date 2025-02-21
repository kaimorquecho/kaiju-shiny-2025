ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this App",
           
           
           # intro text fluidrow ---
             
           fluidRow(
             
             column(1),
             column(10, includeMarkdown("text/about.md")),
             column(1)
             
           ), # END intro text fluidRow
            
          
           hr(),
        
           includeMarkdown("text/footer.md")
           
  ), # END (Page 1) intro tabPanel
  
  # (Page 2) data viz tabPanel ----
  tabPanel(title =  "Explore the Data",
           
            tabsetPanel(
              
              # trout tabPanel
              tabPanel(title = "Trout",
                       
                       # trout sidebayLayout
                       sidebarLayout(
                         
                         # trout sidebarPanel
                         sidebarPanel(
                           
                           # channel type pickerInput ----
                           pickerInput(inputId =   
                                         "channel_type_input", label = "Select channel type(s):",
                                       choices = unique(clean_trout$channel_type), 
                                       # alternatively: choices = c("rapid", "cascade" ...)
                                       selected = c("cascade", "pool"),
                                       multiple = TRUE,
                                       options = pickerOptions(actionsBox = TRUE)),  # END channel type pickerInput
                           # section checkboxgroupbuttons
                           checkboxGroupButtons(inputId = "section_input",
                                                label = "Select a sampling section(s):",
                                                choices = c("Clear Cut" = "clear cut forest",
                                                            "Old Growth" = "old growth forest"),
                                                selected = c("clear cut forest",
                                                             "old growth forest"),
                                                justified = TRUE,
                                                checkIcon = list(
                                                  yes = icon("check", lib = "font-awesome"),
                                                  no = icon("xmark", lib = "font-awesome")
                                                ))
                          
                         ), # END trout sidebarpanel
                         
                         mainPanel(
                           
                           # trout scatterplot output 
                           plotOutput(outputId = "trout_scatterplot_output") %>% # end plotoutput
                             withSpinner(color = "springgreen2", type = 1)
                           
                         ) # END trout mainpanel
                         
                       ) # END trout sidebarlayout
                       ), # END trout tabPanel
              
              # penguin tab panel
              tabPanel( title = "Penguins",
                        
                        # penguin sidebarLayout
                        sidebarLayout(
                          
                          # penguin sidebarPanel
                          sidebarPanel(
                            
                            # island picker input
                            pickerInput(inputId = "penguin_island_input",
                                        label = "Select an island(s):",
                                        choices = c("Torgersen","Dream","Biscoe"),
                                        selected = c("Torgersen","Dream","Biscoe"),
                                        multiple = TRUE, # mutliple selections at once
                                        options = pickerOptions(actionsBox = TRUE)),
                                        
                            sliderInput(inputId = "bin_num_input",
                                         label = "Select number of bins:",
                                         min = 1, max = 100, value = 25)           
                                          
                                          ),
                           #end penguin sidebarPanel
                        
                          # penguin mainPanel
                          mainPanel(
                            
                            plotOutput(outputId = "flipper_length_histogram_output") %>%
                              withSpinner(color = "indianred2", type = 4, size = 2 )
                          ) # end penguin mainpanel
                        ) # end penguin sidebarLayout
              ) # END penguin tabPanel
            ) # END tabsetPanel
           
  ) # END (Page 2) data viz tabPanel
  
) # END navbarPage