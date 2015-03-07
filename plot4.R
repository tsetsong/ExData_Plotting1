# Read selected data rows into table and name the columns correctly.
tbl<-read.table("../household_power_consumption.txt",sep=";",skip=66637,nrow=2880,stringsAsFactors=FALSE, na.string="?")
names<-read.table("../household_power_consumption.txt",sep=";",nrow=1,stringsAsFactors=FALSE, na.string="?")
colnames(tbl)<-names

# Create a separate data frame containing the date and time from the read data
# then name the columns correctly.dateTime <-data.frame(tbl$Date)
dateTime$Time <- tbl$Time
colnames(dateTime)<-c("Date", "Time")

# Opening graphic device
png(file = "./figure/Plot4.png",height=480,width=480)

# Create a new column in the dateTime dataframe and combine the contents of the first 
# two columns in the new column, separated by a comma
dateTime$DateTime <- sapply(dateTime, function(x) paste(dateTime$Date,dateTime$Time,sep=","))[,1] 
# create yet another column in dateTime and convert dateTime$DateTime into POSIXlt and store it here.
dateTime$dt<-strptime(dateTime$DateTime, "%d/%m/%Y,%H:%M:%S")

# Create two columns and two rows in the plot window
par(mfrow=c(2,2))

# Output first plot
plot(dateTime$dt,tbl$Global_active_power,type="line",ylab="Global Active Power", xlab="")

# Output second plot
plot(dateTime$dt,tbl$Voltage,type="l",ylab ="Voltage",xlab="datetime")

# Output third plot
plot(dateTime$dt,tbl$Sub_metering_1,type="line",xlab="",ylab="Energy sub metering")
lines(dateTime$dt,tbl$Sub_metering_2,col="red")
lines(dateTime$dt,tbl$Sub_metering_3,col="blue")

# Output fourth plot
plot(dateTime$dt,tbl$Global_reactive_power,type="l",ylab ="Global_reactive_power",xlab="datetime")

# copy the plot to png file

dev.off()

#tbl$Date<-as.Date(tbl$Date, "%d/%m/%Y")
#tbl$Time <-chron(times=tbl$Time)


#with(tbl,hist(Global_active_power,col="red",xlab="Global Active Power(kilowatts)",main="Global Active Power"))
#dev.copy(png,file="./figure/Plot1.png")
#dev.off()