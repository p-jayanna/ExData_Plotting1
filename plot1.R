
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

#set png height and width and plot the histogram
png("plot1.png", width=480, height=480)
hist(power_data_feb$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
