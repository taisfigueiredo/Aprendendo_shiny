
usethis::use_git()
usethis::use_github()
usethis::use_readme_md()

#----------------------------------------------------------------------------------------------------------------------------------------#
#                                               Building web applications with shiny in R                                                #
#----------------------------------------------------------------------------------------------------------------------------------------#


usethis::use_git("Capítulo 2 - mais exemplo")
usethis::pr_init(branch = "teste")
usethis::pr_push()
usethis::pr_merge_main()


library(shiny)
library(babynames)
library(ggplot2)
library(tidyverse)


#-----------------------------------------------------------  CAPÍTULO 1  -------------------------------------------------------------#


ui = fluidPage()

#Servidor é criado em R definindo uma função personalizada
#Para construir um servidor: crie um obj chamado servidor e, em seguida, atribuído a ele deve ser uma função 
#com, no mínimo, o argumentos de entrada e saída, embora existam argumentos opcionais que ajudam a criar aplicativos mais avançados.

server = function(input, output, session){}

#Executar o aplicativo:

shinyApp(ui = ui, server = server)


#Exemplo simples de App :

library(shiny)

ui = fluidPage(
  "Hello, world!!"
)

server = function(input, output, session){}

shinyApp(ui = ui, server = server)


#Ask a question
#textInput : permite que os usuários insiram texto e leva três argumentos: um id único que será usado para se 
#referir a este entrada, um rótulo que é exibido para o usuário e um valor padrão opcional, que não usamos neste app.
ui = fluidPage(textInput("name", "Enter a name:"),
               textOutput("q")) #Para exibir a saída q

#A função renderText é atribuída a um objeto de saida, output$q. Se você adicionar input$name, poderá acessar o nome adicionado
#usando textInput
server = function(input, output){
  output$q = renderText({
    paste("Do u prefer dogs or cats,", input$name, "?")
  })
}

shinyApp(ui = ui, server = server)


#

ui = fluidPage(titlePanel("Baby Name Explorer"),
               
               sidebarLayout(
               sidebarPanel(
               textInput("name", "Enter name", "David") #permitir que o usuario insira o nome
               ),
               
               mainPanel(
               plotOutput("trend")
               )
               )
)

server = function(input, output, session){
  output$trend = renderPlot({
    data_name = subset(babynames, name== input$name
                       )
    ggplot(data_name)+
      geom_line(
        aes(x = year, y = prop, color = sex)
      )
    
    })
}

shinyApp(ui = ui, server = server)


ui <- fluidPage(
  textInput('name', 'Enter Name', 'David'),
  # CODE BELOW: Display the plot output named 'trend'
  plotOutput('trend')
)
server <- function(input, output, session) {
  # CODE BELOW: Render an empty plot and assign to output named 'trend'
  output$trend <- renderPlot({
    ggplot()
  })
}
shinyApp(ui = ui, server = server)

#------------

ui <- fluidPage(
  titlePanel("Baby Name Explorer"),
  # CODE BELOW: Add a sidebarLayout, sidebarPanel, and mainPanel
  sidebarLayout(
    sidebarPanel(
      textInput('name', 'Enter Name', 'David')),
    mainPanel(
      plotOutput('trend'))
  )
  
)

server <- function(input, output, session) {
  output$trend <- renderPlot({
    ggplot()
  })
}
shinyApp(ui = ui, server = server)

#------------------


ui <- fluidPage(
  titlePanel("Baby Name Explorer"),
  sidebarLayout(
    sidebarPanel(textInput('name', 'Enter Name', 'David')),
    mainPanel(plotOutput('trend'))
  )
)
server <- function(input, output, session) {
  output$trend <- renderPlot({
    data_name = subset(babynames, name== input$name
    )
    ggplot(data_name)+
      geom_line(
        aes(x = year, y = prop, color = sex))
    
  })
}
shinyApp(ui = ui, server = server)




#----------------------------------------------------------    CAPÍTULO 2   ----------------------------------------------------------------#

#Input functions
#O inputId precisa ser uma string de caracteres e cada entrada deve ter um ID exclusivo para que você possa consultá-lo no servidor para
#fazer atualizações no aplicativo

#Um selectInput requer uma lista de opções. O usuário verá automaticamente a primeira escolha na lista.

# Um sliderInput requer um valor no qual o controle deslizante será definido por padrão, um mínimo e um máximo dos outros valores que os usuários podem escolher.


selectInput("inputId",
            "label",
            choices = c("A", "B", "C"))


sliderInput("inputId", 
            "label",
            value = 1925,
            min = 1900,
            max = 2000)

ui = fluidPage(
  textInput("name", "Enter a name:"),
  selectInput("animal", "Dogs or cats?", choices = c("dogs", "cats")),
  textOutput("greeting"),
  textOutput("answer")
)

server = function(input, output, session){
  output$greeting = renderText({
    paste("Do u prefer dogs or cats,", input$name, "?")
  })
  output$answer = renderText({
    paste("I prefer", input$animal, "!")
  })
}

# se liga: Os ids precisam ser únicos, caso contrário, você não poderá consultá-los no servidor.

shinyApp(ui = ui, server = server)



#-----------------------------

ui <- fluidPage(
  titlePanel("What's in a Name?"),
  # CODE BELOW: Add select input named "sex" to choose between "M" and "F"
  selectInput('sex', 'Select Sex', choices = c("F", "M")),
  # Add plot output to display top 10 most popular names
  plotOutput('plot_top_10_names')
)

server <- function(input, output, session){
  # Render plot of top 10 most popular names
  output$plot_top_10_names <- renderPlot({
    # Get top 10 names by sex and year
    top_10_names <- babynames %>% 
      # MODIFY CODE BELOW: Filter for the selected sex
      filter(sex == input$sex) %>% 
      filter(year == 1900) %>% 
      top_n(10, prop)
    # Plot top 10 names by sex and year
    ggplot(top_10_names, aes(x = name, y = prop)) +
      geom_col(fill = "#263e63")
  })
}

shinyApp(ui = ui, server = server)

#--------------------


ui <- fluidPage(
  titlePanel("What's in a Name?"),
  # Add select input named "sex" to choose between "M" and "F"
  selectInput('sex', 'Select Sex', choices = c("F", "M")),
  # CODE BELOW: Add slider input named 'year' to select years (1900 - 2010)
  sliderInput('year', 'Select Year', min = 1900, max = 2010, value = 1900),
  # Add plot output to display top 10 most popular names
  plotOutput('plot_top_10_names')
)

server <- function(input, output, session){
  # Render plot of top 10 most popular names
  output$plot_top_10_names <- renderPlot({
    # Get top 10 names by sex and year
    top_10_names <- babynames %>% 
      filter(sex == input$sex) %>% 
      # MODIFY CODE BELOW: Filter for the selected year
      filter(year == input$year) %>% 
      top_n(10, prop)
    # Plot top 10 names by sex and year
    ggplot(top_10_names, aes(x = name, y = prop)) +
      geom_col(fill = "#263e63")
  })
}

shinyApp(ui = ui, server = server)


#-----------------------

# As funções de saída são usadas na UI para exibir as saídas construídas no servidor com funções de renderização.
#Para nosso app de perguntas e respostas, usamos duas funções textOutput para exibir as saídas de perguntas e respostas
#funções de saída: tableOutput() or dataTableOutput(), imageOutput(), plotOutput()

ui = fluidPage(
  textInput("name", "Enter a name:"),
  selectInput("animal", "Dogs or cats?", choices = c("dogs", "cats")),
  textOutput("question"),
  textOutpu("answer")
)

#Existem pacotes fora do shiny que fornecem maneiras de construir saídas com funções de renderização e saída


#Exemplo DT

library(babynames)
library(shiny)
library(tidyverse)
library(shinythemes)


ui = fluidPage(
  DT::DTOutput("babynames_table")
)

server = function(input, output){
  output$babynames_table = DT::renderDT({
    babynames %>% 
      dplyr::sample_frac(.1)
  })
}


shinyApp(ui = ui, server = server)

#---------------------------- Tabela 

ui <- fluidPage(
  titlePanel("What's in a Name?"),
  # Add select input named "sex" to choose between "M" and "F"
  selectInput('sex', 'Select Sex', choices = c("F", "M")),
  # Add slider input named "year" to select year between 1900 and 2010
  sliderInput('year', 'Select Year', min = 1900, max = 2010, value = 1900),
  # CODE BELOW: Add table output named "table_top_10_names"
  tableOutput('table_top_10_names')
)
server <- function(input, output, session){
  # Function to create a data frame of top 10 names by sex and year 
  top_10_names <- function(){
    babynames %>% 
      filter(sex == input$sex) %>% 
      filter(year == input$year) %>% 
      top_n(10, prop)
  }
  # CODE BELOW: Render a table output named "table_top_10_names"
  output$table_top_10_names <- renderTable({
    top_10_names()
  })
}
shinyApp(ui = ui, server = server)


#---------------------------- Tabela com DT

ui <- fluidPage(
  titlePanel("What's in a Name?"),
  # Add select input named "sex" to choose between "M" and "F"
  selectInput('sex', 'Select Sex', choices = c("M", "F")),
  # Add slider input named "year" to select year between 1900 and 2010
  sliderInput('year', 'Select Year', min = 1900, max = 2010, value = 1900),
  # MODIFY CODE BELOW: Add a DT output named "table_top_10_names"
  DT::DTOutput('table_top_10_names')
)
server <- function(input, output, session){
  top_10_names <- function(){
    babynames %>% 
      filter(sex == input$sex) %>% 
      filter(year == input$year) %>% 
      top_n(10, prop)
  }
  # MODIFY CODE BELOW: Render a DT output named "table_top_10_names"
  output$table_top_10_names <- DT::renderDT({
    top_10_names()
  })
}
shinyApp(ui = ui, server = server)


#-------------------------  Interactive plot output
library(plotly)

top_trendy_names = babynames %>% top_n(30, prop)

ui <- fluidPage(
  selectInput('name', 'Select Name', top_trendy_names$name),
  # CODE BELOW: Add a plotly output named 'plot_trendy_names'
  plotly::plotlyOutput('plot_trendy_names')
)
server <- function(input, output, session){
  # Function to plot trends in a name
  plot_trends <- function(){
    babynames %>% 
      filter(name == input$name) %>% 
      ggplot(aes(x = year, y = n)) +
      geom_col()
  }
  # CODE BELOW: Render a plotly output named 'plot_trendy_names'
  output$plot_trendy_names <- plotly::renderPlotly({
    plot_trends()
  })
}
shinyApp(ui = ui, server = server)


#-------------------------- Layouts and themes 


ui = fluidPage(
  titlePanel("histogram"),
  sliderInput("nb_bins", "# Bins", 5, 10, 5),
  plotOutput("hist")
)

server = function(input, output, session){
  output$hist = renderPlot({
    hist(faithful$waiting,
         breaks = input$nb_bins,
         col = "steelblue")
  })
}

shinyApp(ui = ui, server = server)

#--

ui = fluidPage(
  titlePanel("histogram"),
  sidebarLayout(
 sidebarPanel( sliderInput("nb_bins", 
                           "# Bins", 5, 10, 5)),
  mainPanel(plotOutput("hist"))
)
)

server = function(input, output, session){
  output$hist = renderPlot({
    hist(faithful$waiting,
         breaks = input$nb_bins,
         col = "steelblue")
  })
}

shinyApp(ui = ui, server = server)


#tabsetPanel dentro do painel principal para adicionar uma aba
#Cada guia individual deve ser criada com tabPanel e você deve dar a cada uma delas um rótulo
#Para escolher temas - Exemplo:   shinythemes::themeSelector() -> Para escolher um tema para o app

ui = fluidPage(
  titlePanel("histogram"),
  theme = shinytheme("superhero"), #Tema pré selecionado
  sidebarLayout(
    sidebarPanel( sliderInput("nb_bins", 
                              "# Bins", 5, 10, 1)),
    mainPanel(
      tabsetPanel(
        tabPanel("waiting",
                 plotOutput("hist_waiting")),
        tabPanel("Eruptions",
                 plotOutput("hist_eruptions"))
      )
      
    )
  )
)

server = function(input, output, session){
  output$hist_waiting = renderPlot({
    hist(faithful$waiting,
         breaks = input$nb_bins,
         col = "steelblue")
  }) 
  output$hist_eruptions = renderPlot({
    hist(faithful$eruptions,
         beaks = input$nb_bins,
         col = "steelblue")
  })
}


shinyApp(ui = ui, server = server)


#--------------------- sidebar lauout

ui <- fluidPage(
  # MODIFY CODE BELOW: Wrap in a sidebarLayout
  sidebarLayout(
    # MODIFY CODE BELOW: Wrap in a sidebarPanel
    sidebarPanel(
      selectInput('name', 'Select Name', top_trendy_names$name)),
    # MODIFY CODE BELOW: Wrap in a mainPanel
    mainPanel(
      plotly::plotlyOutput('plot_trendy_names'),
      DT::DTOutput('table_trendy_names')
    )))
# DO NOT MODIFY
server <- function(input, output, session){
  # Function to plot trends in a name
  plot_trends <- function(){
    babynames %>% 
      filter(name == input$name) %>% 
      ggplot(aes(x = year, y = n)) +
      geom_col()
  }
  output$plot_trendy_names <- plotly::renderPlotly({
    plot_trends()
  })
  
  output$table_trendy_names <- DT::renderDT({
    babynames %>% 
      filter(name == input$name)
  })
}
shinyApp(ui = ui, server = server)



#--------------------- exemplo aleatório no rolê


library(shiny)
library(ggplot2)
library(thematic)

# Call thematic_shiny() prior to launching the app, to change 
# R plot theming defaults for all the plots generated in the app
thematic_shiny(font = "auto")

ui <- fluidPage(
  # bslib makes it easy to customize CSS styles for things 
  # rendered by the browser, like tabsetPanel()
  # https://rstudio.github.io/bslib
  theme = bslib::bs_theme(
    bg = "#002B36", fg = "#EEE8D5", primary = "#2AA198",
    # bslib also makes it easy to import CSS fonts
    base_font = bslib::font_google("Pacifico")
  ),
  tabsetPanel(
    type = "pills",
    tabPanel("ggplot", plotOutput("ggplot")),
    tabPanel("lattice", plotOutput("lattice")),
    tabPanel("base", plotOutput("base"))
  )
)

server <- function(input, output) {
  output$ggplot <- renderPlot({
    ggplot(mtcars, aes(wt, mpg, label = rownames(mtcars), color = factor(cyl))) +
      geom_point() +
      ggrepel::geom_text_repel()
  })
  output$lattice <- renderPlot({
    lattice::show.settings()
  })
  output$base <- renderPlot({
    image(volcano, col = thematic_get_option("sequential"))
  })
}

shinyApp(ui, server)

