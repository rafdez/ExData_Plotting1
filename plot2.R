

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
ylab <- "Global Active Power (kilowatts)"

plot(data$Datetime, data$Global_active_power, type="l", xlab="", ylab=ylab)

dev.copy(png,'plot2.png')
dev.off ();
