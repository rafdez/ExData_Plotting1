

# Dataset

filename <- "household_power_consumption.txt"
format <- "%d/%m/%Y %H:%M:%S"
  
data <- read.table(filename, sep=";", header=TRUE, colClasses = "character")

data <- cbind("Datetime"=strptime(paste(data$Date, data$Time), format), data[,3:9])

lowerLimit <- strptime("01/02/2007 00:00:00", format=format)
upperLimit <- strptime("03/02/2007 00:00:00", format=format)

data <- subset(data, data$Datetime >= lowerLimit & data$Datetime < upperLimit)

data[, 2:8] <- lapply(data[, 2:8], as.numeric)


# Plot
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))

# Plot[1,1]
ylab <- "Global Active Power"

plot(data$Datetime, data$Global_active_power, type="l", xlab="", ylab=ylab)

# Plot[1,2]
xlab <- "datetime"
ylab <- "Voltage"

plot(data$Datetime, data$Voltage, type="l", xlab=xlab, ylab=ylab)

# Plot[2,1]
ylab <- "Energy sub metering"

colors <- c("black","red","blue")
legends <- c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")

plot(range(data$Datetime), range(data[,6:8]), type="n", xlab="", ylab=ylab)

lines(data$Datetime, data$Sub_metering_1, col=colors[1])
lines(data$Datetime, data$Sub_metering_2, col=colors[2])
lines(data$Datetime, data$Sub_metering_3, col=colors[3])

legend("topright", legends, lty=c(1,1), col=colors, bty="n")

# Plot[2,2]
xlab <- "datetime"
ylab <- "Global_reactive_power"

plot(data$Datetime, data$Global_reactive_power, type="l", xlab=xlab, ylab=ylab)

dev.copy(png,'plot4.png')
dev.off ();
