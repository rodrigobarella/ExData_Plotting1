##This program creates an histogram from the Household Power Consumption dataset - which considers only the days of February 1st and 2nd, 2007

##checking if data folder exists in the selected working directory
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


##create plot 1 - Histogram

#opening png device
png("plot1.png",width = 480,height = 480)

hist(data$Global_active_power,col="red",xlab="Global Active Power(kilowatts)",main="Global Active Power")

##close png device
dev.off()

