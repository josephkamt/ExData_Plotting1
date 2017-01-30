# Downloading File
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(Url, destfile="./household_power_consumption.zip", method="curl")

# Unzipping file
unzip("/Users/josephkamt/GH_JK/ExData_Plotting1/household_power_consumption.zip")

# Loading relevant packages
library(dplyr)
library(lubridate)

# Reading and setting up tables for plot
hpc <- read.table("./household_power_consumption.txt", header=T, sep=";", stringsAsFactors=F, dec=".")
hpc2 <- hpc[hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007",]
hpc3 <- hpc2 %>% mutate(Date = as.POSIXct(dmy_hms(as.character(paste(Date, Time)))), Sub_metering_1 = as.numeric(as.character(Sub_metering_1)), Sub_metering_2 = as.numeric(as.character(Sub_metering_2)), Sub_metering_3 = as.numeric(as.character(Sub_metering_3))) %>% select(Date, Sub_metering_1, Sub_metering_2, Sub_metering_3)

# Calling device and saving plotting
png("plot3.png", width=480, height=480)
with(hpc3, plot(Date,Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering"))
with(hpc3, points(Date,Sub_metering_1, col="black", type="l"))
with(hpc3, points(Date,Sub_metering_2, col="red", type="l"))
with(hpc3, points(Date,Sub_metering_3, col="blue", type="l"))
legend("topright", bty="n", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
