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
  xlab <- 'Global Active Power (kilowatts)'
  col <- 'red'
  main <- 'Global Active Power'
  png(filename = "plot1.png",
    width = 480, height = 480)
  hist(data$Global_active_power, xlab=xlab, col=col, main=main)
  dev.off()
}

main()
