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
Data$TimeDate             <- strptime(paste(Data$Date, Data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
Data$Global_active_power  <- as.numeric(Data$Global_active_power)
Data$Sub_metering_1       <- as.numeric(Data$Sub_metering_1)
Data$Sub_metering_2       <- as.numeric(Data$Sub_metering_2)
Data$Sub_metering_3       <- as.numeric(Data$Sub_metering_3)
Data$Voltage              <- as.numeric(Data$Voltage)
Data$Global_reactive_power<- as.numeric(Data$Global_reactive_power)

##Drawing Plot4 = 4 Graphics
##Setting graphs layout
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
##Graph 1
with(Data, plot(TimeDate, Global_active_power, type="l", xlab= "", ylab="Global Active Power (kilowatts)"))
##Graph 2
with(Data, plot(TimeDate, Voltage, type="l", xlab = "datetime" ))
##Graph 3
with(Data, plot(TimeDate, Sub_metering_1, type="l", xlab= "", ylab="Energy sub metering"))
with(Data, lines(TimeDate, Sub_metering_2,  col= "red"))
with(Data, lines(TimeDate, Sub_metering_3,  col= "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.6,
       col=c("black","red","blue"), lty=1)
##Graph 4
with(Data, plot(TimeDate, Global_reactive_power, type="l", xlab = "datetime" ))
dev.off()