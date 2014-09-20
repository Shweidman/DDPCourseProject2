
goalTable <- function(currentWeight,weightLoss,goalDate,weekday) {
  #Caluclate the goal weight
  goalWeight <- currentWeight - weightLoss
  
  #Get the current date and goal date into "Date" format
  currentDate <- Sys.Date()
  goalDate <- as.Date(goalDate)
  
  #Calculate the number of days until the goal
  daysUntilGoal <- as.numeric(difftime(goalDate,currentDate,units="days"))
  
  ##Initialize the goal matrix
  #goalTable <- matrix(data=0,nrow=daysUntilGoal,ncol=3)
  
  ##Calculate how many pounds must be lost each day
  poundsPerDay <- weightLoss/daysUntilGoal
  
  goalTable <- data.frame(date = as.Date(rep(Sys.Date(),daysUntilGoal)),
                          weight = rep(currentWeight,daysUntilGoal),
                          weekdays = weekdays(as.Date(rep(Sys.Date(),daysUntilGoal))),
                          stringsAsFactors = FALSE)
  
  ##Fill it in with the goals for each day
  for (i in 1:daysUntilGoal) {
    goalTable[i,1] <- as.Date(currentDate + i)
    goalTable[i,2] <- round(currentWeight - i*poundsPerDay,1)
    goalTable[i,3] <- weekdays(goalTable[i,1])
  }
  
  ##Subset out just the days that are on the weekday selected, eliminate the weekdays variable
  goalTableFinal <- subset(goalTable,weekdays==weekday | date==goalDate)
  
  goalTableFinal
}

shinyServer(
  function(input, output) {
    output$goalTableFinal <- renderDataTable({goalTable(input$currentWeight,input$weightLoss,input$goalDate,input$weekday)}) 
  }
)