
library(shiny)
library(tibble)
library(shinythemes)

#set up UI

ui<- fluidPage(
  theme = shinytheme('slate'),
  titlePanel('Visual angual calculations for your paradigm'),

  br(),
  p('If you are looking to create some stimuli for your experiemnt; If you are looking to replicate
    an existing paradigm but have a different streen; If you want to make your visual paradigm easily replicable,
    you have come to the right place'),
  p("Are you using Presentation/Matlab/PsychoPy? check out the code you need to put in to make your life easier
    when talking about standardised and easy presentaiton of stimuli using visual angles"),

  sidebarLayout(
    sidebarPanel(
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "cal",
                  label = "Choose what do you want to calculate:",
                  choices = c("Size in pix", "Visual Angle"),
                  selected = 'Size in pix'),

      # Input: Selector for choosing dataset ----
      selectInput(inputId = "mes",
                  label = "Choose a measure:",
                  choices = c("centimeters" , "inches"),
                  selected = 'inches'),

      # Input: Numeric entry for length of the screen
      numericInput(inputId = "scrW",
                   label = "Enter the width of your screen:",
                   value = 17),

      # Input: Numeric entry for length of the screen

      numericInput(inputId = "resX",
                   label = "Enter the screen resolution for x:",
                   value = 700),

      # Input: Numeric entry for length of the screen

      numericInput(inputId = "resY",
                   label = "Enter the screen resolution for y:",
                   value = 1200),

      # Input: Numeric entry for size

      numericInput(inputId = "size",
                   label = "Enter the pixels/ visual angle of the image you want to create:",
                   value = 45),

      #Input of viewing distance
      numericInput(inputId = "vd",
                   label = "Enter the viewing distance of your participants:",
                   value = 17),

      # Input: Selector for choosing programming language ----
      selectInput(inputId = "prg",
                  label = "Choose the program you are using:",
                  choices = c("Presentation" , "Matlab" , "PsychoPy" ),
                  selected = 'Matlab')


    ),
    mainPanel(

      h3("Easy as 1..2..3"),

      # Output: HTML table with requested number of observations ----
      tableOutput("view"),

      p(textOutput("prog"))

    )
  )

)


#set up server for backend functionality

server<-function(input,output){



  #do the calclations

  #do metric conversion








  output$view <- renderTable({



    if(input$mes == "centimeters"){
      size_cm <- input$scrW
    }else{
      size_cm <- input$scrW * 2.54
    }

    if(input$mes == "inches"){
      size_in <- input$scrW
    }else{
      size_in <- input$scrW/2.54
    }


    pix_sz <- size_cm / input$resX



    lables <- c('Screen Width in cm', 'Screen Width in inches', 'Visual Distance in cm', 'Size in pix','Visual Angle in deg')


    if( input$cal == "Size in pix"){
      va <- as.numeric(input$size)
      sz <- 2 * input$vd * tan(pi * va/(2*180))
      px <- round(sz / pix_sz)
    } else{
      px <- as.numeric(input$size)
      sz <- input$size * pix_sz
      va <- 2 * 180 * atan(sz / (2 * input$vd)) / pi
    }

    val <- c(size_cm, size_in, input$vd, px, va)
    tibble(lables,val)},
                             rownames = T)




  output$prog <- renderPrint({
    ifelse(input$prg == "Presentation", 'Hey you are using Presentation. Make sure you check your timings if you are interested in precise times!',
           ifelse(input$prg == "Matlab",
                  'Hey you are using Matlab. Put this at the top of your script and you will be good!','Hey you are using Psychopy. Yay Python! PsychoPy is the way of the future!'))


    })

}


#Create Shiny app ----
shinyApp(ui = ui, server = server)
