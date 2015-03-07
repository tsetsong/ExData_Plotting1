# Read selected data rows into table and name the columns correctly.
tbl<-read.table("../household_power_consumption.txt",sep=";",skip=66637,nrow=2880,stringsAsFactors=FALSE, na.string="?")
names<-read.table("../household_power_consumption.txt",sep=";",nrow=1,stringsAsFactors=FALSE, na.string="?")
colnames(tbl)<-names

# Create a separate data frame containing the date and time from the read data
# then name the columns correctly.
dateTime <-data.frame(tbl$Date)
dateTime$Time <- tbl$Time
colnames(dateTime)<-c("Date", "Time")

# Create a new column in the dateTime dataframe and combine the contents of the first 
# two columns in the new column, separated by a comma
dateTime$DateTime <- sapply(dateTime, function(x) paste(dateTime$Date,dateTime$Time,sep=","))[,1] 

# create yet another column in dateTime and convert dateTime$DateTime into POSIXlt and store it here.
dateTime$dt<-strptime(dateTime$DateTime, "%d/%m/%Y,%H:%M:%S")

# Opening graphic device
png(file = "./figure/Plot3.png",height=480,width=480)

# Using the dateTime$dt column as x-axis, plot the sub metering 1 data
plot(dateTime$dt,tbl$Sub_metering_1,type="line",xlab="",ylab="Energy sub metering")
# add the submetering 2 and sub metering 3 data
lines(dateTime$dt,tbl$Sub_metering_2,col="red")
lines(dateTime$dt,tbl$Sub_metering_3,col="blue")

# Off graphic device
dev.off()
