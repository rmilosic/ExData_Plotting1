library(dplyr)
# read in data
if(!file.exists("rawdataset/household_power_consumption.txt")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "rawdataset.zip")
        unzip("rawdataset.zip", exdir = "rawdataset")
}

dataset <- read.table("rawdataset/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

# make 1 variable datetime from Date and Time, reorder and drop Date and Time columns, filter relevant dates
tidydata <- dataset %>% mutate(datetime = as.POSIXct(paste(as.character(Date),as.character(Time)), format="%e/%m/%Y %T")) %>% select(datetime, Global_active_power:Sub_metering_3, -c(Date,Time)) %>% filter(datetime >= as.POSIXct("2007-02-01") & datetime < as.POSIXct("2007-02-03"))

# open graphics device
png(filename = "plot1.png", width=480, height=480)
par(mar=c(5,5,4,2))
# make a histogram of global active power
hist(tidydata$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab="Frequency" )

dev.off()