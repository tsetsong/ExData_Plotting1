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
png(file = "./figure/Plot2.png",height=480,width=480)

# Using the dateTime$dt column as x-axis, plot the Global Active power
plot(dateTime$dt,tbl$Global_active_power,type="line",xlab="",ylab="Global Active Power")

# Off graphic device
dev.off()

