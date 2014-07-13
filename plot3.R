# read file into data.table
library(data.table)
hpc_data <- fread("household_power_consumption.txt", sep=";",
	na.strings=c("?"), stringsAsFactors=FALSE)

# convert date column to Date class
hpc_data$Date <- as.Date(hpc_data$Date, "%d/%m/%Y")

# extract subset of data for selected dates
plot_data <- subset(hpc_data, 
	Date %in% as.Date(c("2007-02-01","2007-02-02"),"%Y-%m-%d"))

# convert columns to numeric class
plot_data$Sub_metering_1 <- as.numeric(plot_data$Sub_metering_1)
plot_data$Sub_metering_2 <- as.numeric(plot_data$Sub_metering_2)
plot_data$Sub_metering_3 <- as.numeric(plot_data$Sub_metering_3)

# add Date_Time column "POSIXct"
plot_data$dt <- as.POSIXct(paste(plot_data$Date,plot_data$Time,format='%d/%m/%Y %H:%M:%S'))

# Setup graphics device
png(file="plot3.png", width=480, height=480, units="px")

# create plot
plot(plot_data$dt, plot_data$Sub_metering_1, col="black", 
	type="l", 
	xlab="", 
	ylab="Energy sub metering")
lines(plot_data$dt, plot_data$Sub_metering_2, col="red")
lines(plot_data$dt, plot_data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
	lty=c(1,1,1), 
	col=c("black", "red", "blue"))

dev.off()
