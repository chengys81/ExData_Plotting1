setwd("~/Documents/Courses/Exploratory_Data_Analysis_JHU")

# download raw data and unzip
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "./Fdata.zip", method="curl")
unzip("./Fdata.zip")

# read data
data <- read.table("./household_power_consumption.txt",header=TRUE, sep=";",colClasses=rep(c("character","numeric"),c(2,7)), na.strings="?")
str(data)

# subset data from 2007-02-01 to 2007-02-02
idx <- grepl("^((1/2/2007)|(2/2/2007))",data$Date)
d <- data[idx,]

# change Date and Time to POSIXct format
d$datetime <- as.POSIXct(strptime(paste(d$Date,d$Time, sep=" "),"%d/%m/%Y %H:%M:%S"))
str(d)

# plot4
par(mfrow=c(2,2))
plot(Global_active_power ~ datetime, data=d,type="l",xlab="",ylab="Global Active Power (kilowatts)")
plot(Voltage ~ datetime, data=d,type="l",xlab="datetime",ylab="Voltage")
plot(Sub_metering_1 ~ datetime, data=d, type="l", xlab="",ylab="Energy sub metering")
lines(Sub_metering_2 ~ datetime, data=d, col="red")
lines(Sub_metering_3 ~ datetime, data=d, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,lwd=1,bty="n",cex=0.5, xjust=100000)
plot(Global_reactive_power ~ datetime, data=d,type="l",xlab="datetime")
dev.copy(png, "plot4.png",width = 480, height = 480, units = "px")
dev.off()

