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

main <- function() {
  downloadFile()
  data <- loadFile()
  xaxis <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  ylab <- 'Energy sub metering'
  png(filename = "plot3.png",
    width = 480, height = 480, bg='transparent')
  plot(xaxis, data$Sub_metering_1, ylab=ylab, xlab='', type='l')
  lines(xaxis, data$Sub_metering_2, col='red')
  lines(xaxis, data$Sub_metering_3, col='blue')
  legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}

main()
