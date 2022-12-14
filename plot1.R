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

png("plot1.png", width = 480, height = 480)

# Plot 1
hist(data$Global_active_power, 
     col = "indianred", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()