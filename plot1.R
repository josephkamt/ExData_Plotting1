Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(Url, destfile="./household_power_consumption.zip", method="curl")


unzip("/Users/josephkamt/GH_JK/ExData_Plotting1/household_power_consumption.zip")


library(dplyr)
library(lubridate)

hpc <- read.table("./household_power_consumption.txt", header=T, sep=";", stringsAsFactors=F, dec=".")
hpc2 <- hpc[hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007",]
hpc3 <- hpc2 %>% select(Global_active_power) %>% mutate(Global_active_power = as.numeric(as.character(Global_active_power)))


png("plot1.png", width=480, height=480)
hist(hpc3$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()











