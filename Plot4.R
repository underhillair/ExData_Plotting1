#data had been previously downloaded into the Github folder, a sub-directory of base directory
#reading it into R data frame
Electric_Raw <- read.table("./ExData_plotting1/household_power_consumption.txt", header = TRUE, sep=";")

#column classes adjusted from 'factor' using as.character to make successful transition to desired format.
Electric_Raw$Date <- as.Date(Electric_Raw$Date, "%d/%m/%Y")
Electric_Raw$Time <- as.character(Electric_Raw$Time)
Electric_Raw$Date_Time <- paste(Electric_Raw$Date,Electric_Raw$Time)
Electric_Raw$Global_active_power <- as.numeric(as.character(Electric_Raw$Global_active_power))
Electric_Raw$Global_reactive_power <- as.numeric(as.character(Electric_Raw$Global_reactive_power))
Electric_Raw$Voltage <- as.numeric(as.character(Electric_Raw$Voltage))
Electric_Raw$Global_intensity <- as.numeric(as.character(Electric_Raw$Global_intensity))
Electric_Raw$Sub_metering_1 <- as.numeric(as.character(Electric_Raw$Sub_metering_1))
Electric_Raw$Sub_metering_2 <- as.numeric(as.character(Electric_Raw$Sub_metering_2))
Electric_Raw$Sub_metering_3 <- as.numeric(as.character(Electric_Raw$Sub_metering_3))

#create combined date/time variable to combine results over two consecutive days
Electric_Raw$Date_Time <- as.POSIXlt(Electric_Raw$Date_Time, "%d/%m/%Y %H:%M:%S")

#subset raw data for Feb 1 & 2, 2007 as requested in assigment
Electric <- Electric_Raw[Electric_Raw$Date %in% as.Date("2007-02-01"):as.Date("2007-02-02"),]

#create four-panel display of graphs
par(mfcol = c(2,2))

#creates line graph with proper labels and other specs as in Plot2.R
plot(Electric$Date_Time, type = "l", Electric$Global_active_power,
     breaks = c("Wednesday","Thursday","Friday"),   
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

#creates line graph with proper labels and other specs as in Plot3.R
plot(Electric$Date_Time, type = "l", Electric$Sub_metering_1, col = "black",
  breaks = c("Wednesday","Thursday","Friday"),   
  ylab = "Energy sub metering",
  xlab = "")
lines(Electric$Date_Time, type = "l", Electric$Sub_metering_2, col = "red")
lines(Electric$Date_Time, type = "l", Electric$Sub_metering_3, col = "blue")
#legend parameters adjusted to work in R Studio and look correct in the png file
legend('topright', lty = c(1,1,1), col = c("black","red","blue"), 
    legend = c("Sub_metering1        ","Sub_metering2        ","Sub_metering3       "),
    cex=0.50, pt.cex = 1, xjust=1, bty = "n")

#creates line graph with proper labels and other specs
plot(Electric$Date_Time, type = "l", Electric$Voltage,
     breaks = c("Wednesday","Thursday","Friday"),   
     ylab = "Voltage",
     xlab = "datetime")

#creates line graph with proper labels and other specs
plot(Electric$Date_Time, type = "l", Electric$Global_reactive_power,
     breaks = c("Wednesday","Thursday","Friday"),   
     ylab = "Global_reactive_power",
     xlab = "datetime")

#exports graph to Github as png
dev.copy(png,'./ExData_plotting1/plot4.png')
dev.off()
