library(shiny)
library(shinydashboard)
library(shiny.router)
source("widgets.R")

titlePanel(" DOC SQL Conversion Tool")

dashboardPage(
  dashboardHeader(title = "DOC-SQLCon"), 
      dashboardSidebar(
              sidebarMenu(
                #menuItem("Open new tab", href = "", icon = shiny::icon("plus-square")),
                menuItemCopyTextAreaToClipboard("source", "Copy source to clipboard"),
                menuItemCopyDivToClipboard("target", "Copy target to clipboard"),
                
                menuItem("Convert", tabName = "convert", icon = icon("dashboard")),
                menuItem("Generate D", tabName = "ceateddl", icon = icon("dashboard")),
                menuItem("Widgets", icon = icon("th"), tabName = "widgets",
                         badgeLabel = "placeholder", badgeColor = "green"),
                menuItem("Help", icon = icon("file-code-o"), 
                         href = "https://help")
                  )
              ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "convert",
              fluidRow(
                 column(width = 9,menuItemFileInput("open", "Open SQL file"),
                        menuItemDownloadLink("save", "Save"),
                       box(background = "green",
                         title = "Source: Input SQL", width = NULL, status = "primary",
                         textAreaInput("source", NULL, width = "100%", height = "200px")
                       ), 
                       box(background = "green",
                         title = "Target: Rendered translation", width = NULL,
                         # tags$table(width = "100%",
                         #            tags$tr(
                         #              tags$td(align = "left", actionButton("renderTranslate", "Render and translate")),
                         #              tags$td(align = "right", checkboxInput("continuous", "Auto render and translate")))),
                         pre(textOutput("target"))
                       )
                ),
                column(width = 3,
                       box(background = "green",
                           h4("Algorithm Style"),
                           selectInput("Algorithm", NULL, choices = c("Pattern", "Replace"), selected = "Replace"),
                           h4("Target dialect"), width = NULL,
                           selectInput("dialect", NULL, choices = c("Netezza", "Hive", "BigQuery", "Impala",  "Oracle", "PDW", "PostgreSQL", "RedShift", "SQL Server", "SQLite"), selected = "SQL Server"),
                           h4("Place Holder"),  # Oracle temp schema
                           textInput("oracleTempSchema", NULL),
                           h4("Parameters"),
                           uiOutput("parameterInputs"),
                           textOutput("warnings")
                       )
                )
              )
      ),
      
      # tabItem(tabName = "ceateddl",
      #                     fluidRow(
      #                       column(12,
      #                              menuItemFileInput("open", "Open raw file"),
      #                              box(title = "Table - Schema", width = 6, solidHeader = TRUE, status = "warning",
      #                                      pre(textOutput("target"))
      #                       )
      #                   )    )
      #             ),
      #         

      # Second tab content
      tabItem(tabName = "widgets",
              h2("Widgets tab content")
      )
      
      
      
    )
  )
)
