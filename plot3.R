##This program creates an histogram from the Household Power Consumption dataset - which considers only the days of February 1st and 2nd, 2007

##checking if data folder exists in the selected working directory before creating
if(!file.exists("./data")){
    
    dir.create("./data")    
    
}

##downloading file
if(!file.exists("./data/data.zip")){
    URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(URL,"./data/data.zip",method="curl")    
}
#unzip file
unzip("data/data.zip",exdir = "data",overwrite = T)



##reading the .txt dataset file
data <- read.table("data/household_power_consumption.txt",header = T,na.strings = "?",sep=";")

##subset the used period of Feb, 1st and Feb, 2nd, 2007
subset <- which(data$Date == "1/2/2007" |data$Date ==  "2/2/2007")
data <- data[subset,]

##converting Date column to date  "POSIXlt" / "POSIXct" format
data$Formdate <- strptime(data$Date,format = "%d/%m/%Y" )

##extracting weekdays from formated data column
data$weekday <- weekdays(data$Formdate)


##create plot 3 - energy sub metering

#opening png device
png("plot3.png",width = 480,height = 480)


plot(data$Sub_metering_1,ylab="Energy Sub Metering",type="l",xaxt="n",xlab="")
lines(data$Sub_metering_2,col="red")
lines(data$Sub_metering_3,col="blue")

#add weekdays to x axis
axis(1, at=c(1,head(which(data$Date == "2/2/2007"),1),nrow(data)), labels = c("Thu","Fri","Sat"))

#add legends
legend("topright",,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)

##close png device
dev.off()








