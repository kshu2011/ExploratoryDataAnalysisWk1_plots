## Plot 4

## reading in the data and cleaning it
library(stringr)
datafile <- read.table("household_power_consumption.txt") ##read in the data
datafile <- str_split_fixed(datafile$V1, ";", 9) ## split the data into the 9 columns, it is read in as 1 column
datafile <- as.data.frame(datafile) ##convert it into a dataframe
names(datafile) <- datafile[1,] ##update column names to the proper names
datafile <- datafile[-1,] ## remove first row, it's just the names of the columns

datafile$dateTime <- strptime(paste(datafile$Date, datafile$Time), "%d/%m/%Y %H:%M:%S") ## create a new column that combines Date and Time so can get it into proper Date format
##transform the other columns into numeric from character
datafile <- transform(datafile, Global_active_power = as.numeric(Global_active_power),
                      Global_reactive_power = as.numeric(Global_reactive_power), Voltage = as.numeric(Voltage),
                      Global_intensity = as.numeric(Global_intensity), Sub_metering_1 = as.numeric(Sub_metering_1),
                      Sub_metering_2 = as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3))
## ONLY looking at 2007-02-01 to 2007-02-02 Data so...
plotdata <- subset(datafile, Date == "2/2/2007" | Date == "1/2/2007")


####### Plotting - Plot4 ######
par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))
plot(plotdata$dateTime, plotdata$Global_active_power, type = "o", cex = .01, xlab = "", ylab = "Global Active Power (kilowatts)")

plot(plotdata$dateTime, plotdata$Voltage, type = "o", cex = .01, xlab = "datetime", ylab = "Voltage")

plot(plotdata$dateTime, plotdata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
points(plotdata$dateTime, plotdata$Sub_metering_1, col = "black", type = "o", cex = .01)
points(plotdata$dateTime, plotdata$Sub_metering_2, col = "red", type = "o", cex = .01)
points(plotdata$dateTime, plotdata$Sub_metering_3, col = "blue", type = "o", cex = .01)
legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), 
       lty = c(1, 1, 1), lwd = c(2.5, 2.5, 2.5), col = c("black", "red", "blue"), bty = "n")

plot(plotdata$dateTime, plotdata$Global_reactive_power, type = "o", cex = .01, xlab = "datetime", ylab = "Global_reactive_power")
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()