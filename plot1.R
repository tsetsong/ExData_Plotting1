# Read selected data rows into table and name the columns correctly.
tbl<-read.table("../household_power_consumption.txt",sep=";",skip=66637,nrow=2880,stringsAsFactors=FALSE, na.string="?")
names<-read.table("../household_power_consumption.txt",sep=";",nrow=1,stringsAsFactors=FALSE, na.string="?")
colnames(tbl)<-names

# Opening graphic device
png(file = "./figure/Plot1.png",height=480,width=480)

# Plot and label the graph
with(tbl,hist(Global_active_power,col="red",xlab="Global Active Power(kilowatts)",main="Global Active Power"))
# Off graphic device
dev.off()