## Downloading file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "FullData.zip", method = "curl")

## Unzip files
if (!file.exists("./Electricpowerconsumption"))
{ unzip("FullData.zip") }

## Reading Table and sub setting dates 1/2/2007 and 2/2/2007 
FullData <- read.table("household_power_consumption.txt", header = TRUE, 
                       sep=";")
Data <- subset(FullData, FullData$Date=="1/2/2007" | 
                 FullData$Date =="2/2/2007")

## Formatting Data
Data$Global_active_power <- as.numeric(Data$Global_active_power)
Data$TimeDate <- strptime(paste(Data$Date, Data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")


##Drawing Plot2 = Plot "Global Active Power by day"
png("plot2.png", width=480, height=480)
with(Data, plot(TimeDate, Global_active_power, type="l", xlab= "", ylab="Global Active Power (kilowatts)"))
dev.off()

