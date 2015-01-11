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
  ylab <- 'Global Active Power (kilowatts)'
  png(filename = "plot2.png",
    width = 480, height = 480)
  plot(xaxis, data$Global_active_power, ylab=ylab, xlab='', type='l')
  dev.off()
}

main()
