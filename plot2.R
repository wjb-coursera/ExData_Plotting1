# read file into data.table
library(data.table)
hpc_data <- fread("household_power_consumption.txt", sep=";", 
	na.strings=c("?"), stringsAsFactors=FALSE)

# convert date column to Date class
hpc_data$Date <- as.Date(hpc_data$Date, "%d/%m/%Y")

# extract subset of data for selected dates
plot_data <- subset(hpc_data, 
	Date %in% as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d"))

# convert columns to numeric class
plot_data$Global_active_power <- as.numeric(plot_data$Global_active_power)

# add Date_Time column "POSIXct"
plot_data$dt <- as.POSIXct(paste(plot_data$Date,plot_data$Time,format='%d/%m/%Y %H:%M:%S'))

# setup graphics device
png(file="plot2.png", width=480, height=480, units="px")

# create plot
plot(plot_data$dt, plot_data$Global_active_power, 
	type="l",
	xlab="",
	ylab="Global Active Power (kilowatts)")

dev.off()
