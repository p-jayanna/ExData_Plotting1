
#libraries for faster reading and flexible data manipulation
library(data.table)
library(dplyr)

#read data using fread method and specify how NAs are repressented in the file using na.strings.
power_data <- fread("~/Coursera/EDA/household_power_consumption.txt", na.strings = "?")

#format date column to date format 
power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")

#subset the data using filter method from dplyr
sub_dates <- as.Date(c("2007-02-01", "2007-02-02"))
power_data_feb <- power_data %>% filter(Date %in% sub_dates)

#convert Time columns to time format and combine with date
power_data_feb$Time <- strptime(paste(power_data_feb$Date, power_data_feb$Time), "%Y-%m-%d %H:%M:%S") 

#set png height and width and set the number of rows and frames
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

#plot all the diagrams
plot(power_data_feb$Time, power_data_feb$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(power_data_feb$Time, power_data_feb$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(power_data_feb$Time, power_data_feb$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(power_data_feb$Time, power_data_feb$Sub_metering_2, type="l", col="red")
lines(power_data_feb$Time, power_data_feb$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=2)
plot(power_data_feb$Time, power_data_feb$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
