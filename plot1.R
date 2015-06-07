# plot 1
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

png(filename = "plot1.png",
    width = 480, height = 480, units = "px", bg = "white")

hist(df$Global_active_power, col = "#FF2500", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()
