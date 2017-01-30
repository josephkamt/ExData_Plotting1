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
hpc3 <- hpc2 %>% mutate(Date = as.POSIXct(dmy_hms(as.character(paste(Date, Time)))), Global_active_power = as.numeric(as.character(Global_active_power))) %>% select(Date, Global_active_power)

# Calling device and saving plotting
png("plot2.png", width=480, height=480)
with(hpc3, plot(Date,Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
