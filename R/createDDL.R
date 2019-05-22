createDDL <- function(rawdata)
{
  #dat <- read.csv("C:/Accenture/Programs/R/datasets/medicalcompare/Ambulatory Surgical Measures-National.csv", colClasses="character")
  
  temp = list.files(path = "C:/Accenture/Programs/R/datasets/medicalcompare", pattern="*.csv")
  fileConn <- file("output.txt") 
  
  str <- "VARCHAR(100)"
  
  strten <- "VARCHAR(10)"
  
  for (i in 1:length(temp)) 
  {
    
    temp2 = read.csv(paste("C:/Accenture/Programs/R/datasets/medicalcompare/",temp[i], sep = ""), stringsAsFactors=FALSE, nrows = 5, header = TRUE)
    #assign(temp[i], read.csv(temp[i]))
    #dates$Date <- as.Date(dates$Date, "%m/%d/%y")
    
    classes <- lapply(temp2, class)
    
    
    tablename <- gsub(" ", "_", temp[i])
    tablename <- sub(".csv", "", tablename)
    
    #tablename <- str_replace_all(temp[i],"\\s+","_")

    # INTEGER, NUMERIC, CHAR, VARCHAR, DATE, TIME,
    sql <- paste("CREATE table ",tablename, "(" ,sep = "")
     
    for( key in names(classes))
      {
    
        value <- classes[[key]]
        value <- sub("character", str, value, ignore.case = FALSE)  
        value <- ifelse(grepl("Date", key, ignore.case = FALSE ), "DATE", value)
        value <- sub("integer", "bigint", value, ignore.case = FALSE)
        value <- sub("numeric", "bigint", value, ignore.case = FALSE)
        value <- sub("logical", strten, value, ignore.case = FALSE)
       
        sql <- paste(sql, key, " ", value, ", ",sep = "")
      }
    
    
    sql <- substring(sql, 0, nchar(sql)-2)
    sql <- paste(sql, ")", sep = "")
  
    write(sql, file="asql.sql",append=TRUE, sep="\n\n")
    print(sql) 
    
    #writeLines(sql, fileConn, append=TRUE, sep="\n\n\n")
      
 }
 close(fileConn)
  
}