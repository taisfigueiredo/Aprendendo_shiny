
#----------------------------------------------------------------------------------------------------------------------------------------#
#                                               Building web applications with shiny in R                                                #
#----------------------------------------------------------------------------------------------------------------------------------------#

usethis::use_git()
usethis::use_github()
usethis::use_readme_md()
usethis::pr_init()
usethis::use_git("Shiny")
usethis::pr_push()



#-----------------------------------------------------------  CAPÍTULO 1  -------------------------------------------------------------#



library(shiny)

ui = fluidPage()

#Servidor é criado em R definindo uma função personalizada
#Para construir um servidor: crie um obj chamado servidor e, em seguida, atribuído a ele deve ser uma função 
#com, no mínimo, o argumentos de entrada e saída, embora existam argumentos opcionais que ajudam a criar aplicativos mais avançados.

server = function(input, output, session){}

#Executar o aplicativo:

shinyApp(ui = ui, server = server)


#Exemplo simples de App:

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




#---------------------------------------------------------    CAPÍTULO 2   ------------------------------------------------------------#
