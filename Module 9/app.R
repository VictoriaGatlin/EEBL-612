##OSOS Workshop 2024
##Shiny Module
##started: 30 July 2024
##updated: 21 August 2024
##Laurel Childress; childress@iodp.tamu.edu

################################################################################
## packages needed for the Shiny App
library(shiny) # shiny itself
library(ggplot2) # ggplot graph
library(dplyr) # pipes
library(leaflet) # maps
################################################################################

################################################################################
## Today we will only use a base R dataset. However,if I load any of my own data
## I do it right up front.

#example1 <- read.csv("example1.csv")

## this file would be stored in the same folder as the app.R file and the file
## path only consists of the file name.
################################################################################
## Outside of the Shiny UI and server we can also define any other parameters we
## would like to use, such as this color palette for our map.
# pal <- colorNumeric(
#   palette = "Reds",
#   domain = quakes$mag)

################################################################################
## How the app LOOKS
## this is the ui (user interface) for your Shiny App; in this section
## set the visualizations for the user, including elements such as user input
ui <- fluidPage(
  # titlePanel("OSOS Workshop - Shiny Example"), #page title
    # sidebarLayout( ## layout a side bar panel
    #   sidebarPanel(width = 3, # space in Shiny is based on 12, so this is 1/4
    #                h4("This is our sidebar panel.")
                   # sliderInput("mag_Input", "Earthquake Magnitude",
                   #              min = 0, max = 7,
                   #             value = c(0, 7),
                   #             step = 0.5),
                    # br(),
                    # downloadButton("downloadData", "Download Selected Data"),
                    # br()
                    # ), #close the sidebar
      ##############################################################
      ## layout the main panel
      # mainPanel(
      #   h4("This is our main panel. Below is our previous text."),
      #   br(), #this adds space between the lines of text
        # h2("This is going to be a Shiny App!"),
        # h3("But for now we will just show these words."),
        # h6("Adding text is easy! And so is changing the size!")
        ##############################################################
        # fluidRow( #alternate version
        #   column(width = 5,
        #          leafletOutput("mymap")),
        #   column(width = 7, 
        #          plotOutput("coolplot")),
        #   ),
       ##############################################################
        # leafletOutput("mymap"), # a map of the data
        # br(), # a break to put space below the map
        # plotOutput("coolplot"), #a graph of the data
        # br(), br(), # two breaks for better visual
        # tableOutput("results") #a table of the users selection
    #     ) #close the main panel
    # ) #close the side bar layout
  ) #close the ui
################################################################################
## How the app WORKS
## this is the server side of your Shiny app. Here is where user input is
## applied to data to produce the graph and table.
server <- function(input, output, session) {
  ##############################################################################
  ## read the user input and subset the dataset
  # quake_select <- reactive({ # subset will change based on user input
  #   quakes %>% # the quakes dataset
  #   filter(mag >= input$mag_Input[1], # limit the data to user choices
  #          # mag <= input$mag_Input[2]
  #   )
  # })
  ##############################################################################
  #generate a map based on the user selection
  # output$mymap <- renderLeaflet({
  #   leaflet(quake_select()) %>%
  #     addTiles() %>% #related to our background, can allow us to label
  #     addCircles(lng = ~long, lat = ~lat, #add our exp points
  #                popup = paste("Magnitude:", quake_select()$mag, "<br>",
  #                              "Depth (km):", quake_select()$depth), #generate a pop-up on click
  #                weight = 10, radius = ~ sqrt(mag) #size of the circles
  #                ) %>%
  #     addProviderTiles("Esri.WorldImagery") #nice looking background
  # })
  ##############################################################################
  ## generate the graph of the data based on the user selection
  # output$coolplot <- renderPlot({
  #   ggplot() +
  #     geom_point(data = quake_select(), aes(y = depth, x = stations,
  #                   size = mag, fill = mag), shape = 21) +
  #     labs(x = "# of stations detecting the earthquake", y = "Depth below surface (km)") +
  #     scale_fill_continuous(limits=c(4, 6.5), breaks=seq(4, 6.5, by = 0.5)) +
  #     scale_size_continuous(limits=c(4, 6.5), breaks=seq(4, 6.5, by = 0.5)) +
  #     scale_y_reverse(expand = c(0, 0), limits = c(max(quake_select()$depth) + 20,0)) +
  #     theme(axis.text = element_text(size = 15),
  #           axis.title = element_text(size = 20)) +
  #     guides(color = guide_legend(), fill = guide_legend())
  # })
  ##############################################################################
  ## generate the table of the data based on the user selection
  # output$results <- renderTable({
  #   quake_select()
  #   },
  #   hover = TRUE, bordered = TRUE
  # )
  ##############################################################################
  ## generate a downloadable csv based on the user selection
  # output$downloadData <- downloadHandler(
  #   filename = function() { #generate a default filename
  #     paste("Quakes_filtered", ".csv", sep = "")
  #   },
  #   content = function(file) { #generate the data file
  #     write.csv(quake_select(), file, row.names = FALSE)
  #   }
  # )
} #close out the server

shinyApp(ui = ui, server = server) #don't delete this!
