downloadFile <- function() {
  if (!file.exists("household_power_consumption.txt")) {
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'hpc.zip', method='curl')
    unzip('hpc.zip')
    file.remove('hpc.zip')
  }
}

loadFile <- function() {
  startRow <- 66638
  endRow <- 69517
  headings <- names(read.table('household_power_consumption.txt', nrows=1, sep=';', header=TRUE))
  data <- read.table('household_power_consumption.txt', skip=(startRow -1), nrows=(endRow - startRow + 1), na.strings='?', sep=';')
  names(data) <- headings
  return (data)
}

plot11 <- function(data) {
  xaxis <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  ylab <- 'Global Active Power (kilowatts)'
  plot(xaxis, data$Global_active_power, ylab=ylab, xlab='', type='l')
}

plot12 <- function(data) {
  xlab <-'datetime'
  ylab <-'Voltage'
  xaxis <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  plot(xaxis, data$Voltage, ylab=ylab, xlab=xlab, type='l')
}

plot21 <- function(data) {
  xaxis <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  ylab <- 'Energy sub metering'
  plot(xaxis, data$Sub_metering_1, ylab=ylab, xlab='', type='l')
  lines(xaxis, data$Sub_metering_2, col='red')
  lines(xaxis, data$Sub_metering_3, col='blue')
  legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
}

plot22 <- function(data) {
  xaxis <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  xlab <- 'datetime'
  ylab <- 'Global_reactive_power'
  plot(xaxis, data$Global_reactive_power, type='l', ylab=ylab, xlab=xlab)
}

main <- function() {
  downloadFile()
  data <- loadFile()
  png(filename = "plot4.png", width = 480, height = 480)
  par(mfrow=c(2,2))
  plot11(data)
  plot12(data)
  plot21(data)
  plot22(data)
  dev.off()
}

main()
