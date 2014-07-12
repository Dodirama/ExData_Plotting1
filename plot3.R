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

## Combine the time and date variables, and then convert to a time class..
household$Date.Time <- paste(household$Date, household$Time, sep = " ")
household$Date.Time.2 <- strptime(household$Date.Time, "%d/%m/%Y %H:%M:%S")

with(household, 
     plot(Date.Time.2, Sub_metering_1, type = "l", 
                     ylab = "Energy sub metering",
                     xlab = ""))
with(household, lines(Date.Time.2, Sub_metering_2, col = "red"))
with(household, lines(Date.Time.2, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)


dev.copy(png, file = "plot3.png")
dev.off() 