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

# plot 1
hist(d$Global_active_power,main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.copy(png, "plot1.png",width = 480, height = 480, units = "px")
dev.off()

