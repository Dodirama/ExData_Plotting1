
if (!file.exists("household.csv")) {
  library(sqldf)
  myFile <- "./household_power_consumption.txt"
  mySql <- "SELECT * FROM file WHERE (Date='1/2/2007' OR Date='2/2/2007')"
  dfData <- read.csv2.sql(file = myFile, sql = mySql)
  write.csv(dfData, "household.csv")
}

if(!exists("household")) {
  household <- read.csv("household.csv")
}

## Change the Date variable to a date class. 
household$Date.2 <- as.Date(household$Date, "%d/%m/%Y")

## Combine the time and date variables, and then convert to a time class..
household$Date.Time <- paste(household$Date, household$Time, sep = " ")
household$Date.Time.2 <- strptime(household$Date.Time, "%d/%m/%Y %H:%M:%S")

with(household, plot(Date.Time.2, Global_active_power, type = "l", 
                    ylab = "Global Active Power (kilowatts)",
                    xlab = ""))


dev.copy(png, file = "plot2.png")
dev.off() 