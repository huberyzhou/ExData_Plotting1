# plot 2
setwd("D:/Coursera/Course materials for the Data Science Specialization/04_ExploratoryAnalysis/PeerAssignment/ExData_Plotting1")

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

filename <- "exdata-data-household_power_consumption.zip"

if(!file.exists(filename)) {
  download.file(url, filename)
}

unzipped.file <- unzip(filename)

install.packages("sqldf")
library(sqldf)
sql.query <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
df <- read.csv.sql(file = unzipped.file, sql = sql.query, sep=";")
unlink(unzipped.file)

df$DateTime <- as.POSIXct(strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S"))
str(df)

png(filename = "plot3.png",
    width = 480, height = 480, units = "px", bg = "white")

plot(x = df$DateTime, y = df$Sub_metering_1, 
     type="l",
     xlab="",ylab="Energy Sub Meetering")

lines(x = df$DateTime, y = df$Sub_metering_2, type = "l", col = "red")
lines(x = df$DateTime, y = df$Sub_metering_3, type = "l", col = "blue")

legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       c("Sub Meetering 1","Sub Meetering 2", "Sub Meetering 3"))

dev.off()
