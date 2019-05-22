library(shiny)
library(SQLCon)
#source("C:/Accenture/Program/workbench/SQLCon/R/RenderSql.R")

shinyServer(function(input, output, session) {
  
  print("dffffd")
  
  # cache <- reactiveValues(target = "", 
  #                         clicks = 0,
  #                         parameters = NULL)
  
  parameters <- reactive({
    params <- regmatches(input$source, gregexpr("@[a-zA-Z0-9_]+", input$source))[[1]]
    params <- unique(params)
    params <- params[order(params)]
    params <- substr(params, 2, nchar(params))
    print("dffffd")
    return(params)
  })
  
  output$target <- renderText({
    # if (!input$continuous && (input$renderTranslate == cache$clicks)) {
    #   return(cache$target)
    # } else {
      # print(paste("continuous: ", input$continuous, ", renderTranslate: ", input$renderTranslate))
  
    
      parameterValues <- list()
      for (param in parameters()) {
        value <- input[[param]]
        
        print(aaaabbbbba)
        print(value)
        print(aaaaa)
        
        if (!is.null(value)) {
          parameterValues[[param]] <- value
        }
      }
      sql <- do.call("render", append(input$source, parameterValues))
      warningString <- c()
      handleWarning <- function(e) {
        output$warnings <- e$message
      }
      oracleTempSchema <- input$oracleTempSchema
      if (oracleTempSchema == "")
      oracleTempSchema <- NULL
      
      print("345353535353535")
      print(input$Algorithm)
      if(input$Algorithm=="Pattern")
       sql <- withCallingHandlers(suppressWarnings(translate(sql, targetDialect = tolower(input$dialect), oracleTempSchema = oracleTempSchema)), warning = handleWarning)
     
      if(input$Algorithm=="Replace")
       sql <- withCallingHandlers(suppressWarnings(sqlconvertcall(sql, targetDialect = tolower(input$dialect), oracleTempSchema = oracleTempSchema)), warning = handleWarning)  
    
      print("1111111111345353535353535")
      
        
        if (!is.null(warningString))
        output$warnings <- warningString
      # cache$target <- sql
      # cache$clicks <- input$renderTranslate
     
      
      return(sql)
    # }
  })
  
  
#----------------
 
  output$parameterInputs <- renderUI({
    params <- parameters()
    sourceSql <- input$source
    print("dfddfffdaqaaaaaaaaaaaaaasadadadadadadadaaaaaaaaaaaaaaaaaaaaa")
    
    
    createRow <- function(param, sourceSql) {
      
      print("inside createRow")
      print("sourceSql")
      
      # Get current values if already exists:
      value <- isolate(input[[param]])
      
      print("aaaaa")
      print(value)
      print("aaaaa")
      
      if (is.null(value)) {
        # Get default values:
        value <- regmatches(sourceSql, regexpr(paste0("\\{\\s*DEFAULT\\s*@", param, "\\s=[^}]+}"), sourceSql))
        if (length(value) == 1) {
          value = sub(paste0("\\{\\s*DEFAULT\\s*@", param, "\\s=\\s*"), "", sub("\\}$", "", value)) 
        } else {
          value = ""
        }
      }
      textInput(param, param, value = value)
    }
    
    print("aaaawwwwwwwwwwwwwa")
    lapply(params, createRow, sourceSql = sourceSql)
    print("aaaawwwwwwwwwwwwwsssssssssssssa")
  })
  
  observeEvent(input$open, {
    sql <- SQLCon::readSql(input$open$datapath)
    updateTextAreaInput(session, "source", value = sql)
  })
  
  output$save <- downloadHandler(
    filename = function() {
      paste('query-', Sys.Date(), '.sql', sep='')
    },
    content = function(con) {
      SQLCon::writeSql(sql = input$source, targetFile = con)
    }
  )
})

