library(shiny)

##1. Include input for person's weight
##2. Include input for person's goal date
##3. Calculate "goal pounds/day":
  ##a. Take current date, goal date, get number of days from now to then
  ##b. Initialize array with number of rows equal to that number of days
  ##c. Take number of pounds to lose and divide it by the number of days
##4. Have user input number of pounds to lose and goal weight
##5. Select days of the week to check in 
##6. Subset out rows of array that correspond to the days of the week that have been checked
##7. Output text message that gives the user a list of goals to hit - using renderTable()

shinyUI(pageWithSidebar(
  headerPanel("Weight loss app"),
  sidebarPanel(
    numericInput('currentWeight',"What is your current weight?",0,min=0,max=500,step=1),
    numericInput('weightLoss',"How many pounds would you like to lose?",0,min=0,max=500,step=1),
    dateInput("goalDate","By when would you like to lose this weight?"),
    radioButtons("weekday",label="Day of week to check in",
                 choices = list("Monday" = "Monday",
                                "Tuesday" = "Tuesday",
                                "Wednesday" = "Wednesday",
                                "Thursday" = "Thursday",
                                "Friday" = "Friday",
                                "Saturday" = "Saturday",
                                "Sunday" = "Sunday"),
                 selected = "Monday")
    ), 
  mainPanel(
    h3("Your schedule for losing weight is:"),
    dataTableOutput("goalTableFinal")
    )
))

