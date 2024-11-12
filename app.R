verificaPckg <- function(pacotes) {
  auxList <- pacotes[!(pacotes %in% installed.packages()[, "Package"])]
  if (length(auxList) > 0) {
    install.packages(auxList)
  }
  lapply(pacotes, library, character.only = TRUE)
}

pacotes <- c("readxl", "dplyr", "ggplot2", "tidyverse", "likert", "FactoMineR", 
             "factoextra", "htmltools", "base64enc", "plotly", "shiny", "DT", "bs4Dash")
verificaPckg(pacotes)


library(shiny)
library(bs4Dash)
library(dplyr)
library(ggplot2)
library(DT)


valid_user <- "me918@unicamp.br"
valid_password <- "projeto4"

# UI
ui <- bs4DashPage(
  title = "ME918 - Trabalho 4",
  header = bs4DashNavbar(),
  sidebar = bs4DashSidebar(
    skin = "light",
    status = "primary",
    title = "ME918 - Trabalho 4",
    bs4SidebarMenu(
      bs4SidebarMenuItem("Análise", tabName = "analysis", icon = icon("chart-line")),
      bs4SidebarMenuItem("Tabela Completa", tabName = "table", icon = icon("table"))
    )
  ),
  body = bs4DashBody(
    uiOutput("main_ui")  
  ),
  controlbar = bs4DashControlbar(),
  footer = bs4DashFooter()
)

# Server
server <- function(input, output, session) {
  
  
  logged_in <- reactiveVal(FALSE)
  
  
  output$main_ui <- renderUI({
    if (!logged_in()) {
      # Tela de Login
      fluidPage(
        titlePanel("Login - ME918"),
        sidebarLayout(
          sidebarPanel(
            textInput("user", "Usuário"),
            passwordInput("password", "Senha"),
            actionButton("login", "Entrar")
          ),
          mainPanel(
            h3("Por favor, faça login para acessar o dashboard")
          )
        )
      )
    } else {
      # Dashboard principal
      bs4TabItems(
        # Aba de Análise
        bs4TabItem(
          tabName = "analysis",
          fluidRow(
            box(
              title = "Configurações",
              width = 4,
              fileInput("file", "Carregar Arquivo CSV",
                        accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
              uiOutput("variable_ui"),
              actionButton("analyze", "Analisar"),
              br(),
              downloadButton("downloadData", "Baixar Dados Processados")
            ),
            box(
              title = "Resumo dos Dados",
              width = 8,
              tableOutput("data_summary")
            ),
            box(
              title = "Gráfico de Dispersão",
              width = 12,
              plotOutput("scatter_plot")
            )
          )
        ),
        # Aba de Tabela Completa
        bs4TabItem(
          tabName = "table",
          box(
            title = "Tabela Completa do Dataset",
            width = 12,
            DT::dataTableOutput("full_table")
          )
        )
      )
    }
  })
  
  
  observeEvent(input$login, {
    if (input$user == valid_user && input$password == valid_password) {
      logged_in(TRUE)  
    } else {
      showNotification("Usuário ou senha incorretos", type = "error")
    }
  })
  
 
  data <- reactive({
    if (is.null(input$file)) {
      mtcars  
    } else {
      tryCatch({
        read.csv(input$file$datapath)
      }, error = function(e) {
        showNotification("Erro ao carregar o arquivo. Verifique se é um CSV válido.", type = "error")
        return(NULL)
      })
    }
  })
  
  
  analyzed_data <- reactiveVal(mtcars)
  
  
  observeEvent(input$file, {
    analyzed_data(data())
  })
  observeEvent(input$analyze, {
    analyzed_data(data())
  })
  
 
  output$variable_ui <- renderUI({
    req(analyzed_data())
    selectInput("var_x", "Escolha a Variável X", names(analyzed_data()))
  })
  
  # Resumo dos dados
  output$data_summary <- renderTable({
    req(analyzed_data())
    summary(analyzed_data())
  })
  
  # Gráfico de Dispersão
  output$scatter_plot <- renderPlot({
    req(input$var_x, analyzed_data())
    var_y <- ifelse(ncol(analyzed_data()) > 1, names(analyzed_data())[2], names(analyzed_data())[1])
    ggplot(analyzed_data(), aes_string(x = input$var_x, y = var_y)) +
      geom_point() +
      theme_minimal() +
      labs(title = paste("Dispersão de", input$var_x, "vs", var_y),
           x = input$var_x,
           y = var_y)
  })
  
  # Tabela Completa do Dataset
  output$full_table <- DT::renderDataTable({
    req(analyzed_data())
    analyzed_data()
  })
  
  # Download dos dados processados
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("dados_processados.csv")
    },
    content = function(file) {
      write.csv(analyzed_data(), file, row.names = FALSE)
    }
  )
}

# Run the application 
shinyApp(ui = ui, server = server)
