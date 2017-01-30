Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(Url, destfile="./household_power_consumption.zip", method="curl")


unzip("/Users/josephkamt/GH_JK/ExData_Plotting1/household_power_consumption.zip")


library(dplyr)
library(lubridate)

hpc <- read.table("./household_power_consumption.txt", header=T, sep=";", stringsAsFactors=F, dec=".")
hpc2 <- hpc[hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007",]
hpc3 <- hpc2 %>% mutate(Date = as.POSIXct(dmy_hms(as.character(paste(Date, Time)))), Global_active_power = as.numeric(as.character(Global_active_power)),  Global_reactive_power = as.numeric(as.character(Global_reactive_power)),
Voltage = as.numeric(as.character(Voltage)))
hpc3 <- hpc3 %>% mutate(Sub_metering_1 = as.numeric(as.character(Sub_metering_1)), Sub_metering_2 = as.numeric(as.character(Sub_metering_2)), Sub_metering_3 = as.numeric(as.character(Sub_metering_3))) 


png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))

with(hpc3, plot(Date, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

with(hpc3, plot(Date, Voltage, type="l", xlab = "datetime", ylab = "Voltage"))

with(hpc3, plot(Date,Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering"))
with(hpc3, points(Date,Sub_metering_1, col="black", type="l"))
with(hpc3, points(Date,Sub_metering_2, col="red", type="l"))
with(hpc3, points(Date,Sub_metering_3, col="blue", type="l"))
legend("topright", bty="n", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(hpc3, plot(Date, Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()
