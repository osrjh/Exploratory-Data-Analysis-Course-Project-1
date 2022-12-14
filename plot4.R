# Creating parameter strings 
dataset_file_name <- "exdata_data_household_power_consumption.zip"
dataset_folder_name <- "exdata_data_household_power_consumption"
fname <- "household_power_consumption.txt"

# Unzipping the dataset if it has not already been unzipped
if(!file.exists(dataset_folder_name)) {
  dir.create(dataset_folder_name)
  unzip(zipfile = dataset_file_name, exdir = dataset_folder_name)
}

# Loading the data
data <- read.table(paste0(dataset_folder_name,"/",fname), 
                   header = TRUE,
                   sep = ";",
                   na.strings = "?")

# Converting the date and time variables to Date/Time classes in R
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Subsetting the data
data[data$Date >= "2007-02-01",] -> data
data[data$Date <= "2007-02-02",] -> data

# Combining the dates and times
data$POSIX <- paste(data$Date, " ", data$Time)
data$POSIX <- as.POSIXct(data$POSIX)

png("plot4.png", width = 480, height = 480)

# Plot 4
par(mfrow = c(2,2))

plot(x = data$POSIX,
     y = data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

plot(x = data$POSIX,
     y = data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

plot(x = data$POSIX,
     y = data$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering",)
lines(x = data$POSIX,
      data$Sub_metering_2, 
      type = "l", 
      col = "red")
lines(x = data$POSIX,
      data$Sub_metering_3, 
      type = "l", 
      col = "dodgerblue2")
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "dodgerblue2"))

plot(x = data$POSIX,
     y = data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()