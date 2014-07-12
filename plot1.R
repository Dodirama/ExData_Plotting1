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

hist(household$Global_active_power, col = "red", 
      xlab = "Global Active Power (kilowatts)", 
      main = "Global Active Power")

dev.copy(png, file = "plot1.png")
dev.off()     
