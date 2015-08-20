## Zip file 
filename <- "exdata_data_NEI_data.zip"

## Unzip zip file for rds
if (!file.exists("summarySCC_PM25.rds")) {
  unzip(filename)
}

## Read in data
NEI <- readRDS("summarySCC_PM25.rds")

## Create data 
total_PM25yr <- with(NEI, tapply(Emissions, INDEX = year, sum))

## Plot 1
png('plot1.png', width=480, height=480)
barplot(total_PM25yr, xlab = "Year", ylab = "Emissions", 
        main = expression("Total U.S." ~ PM[2.5] ~ "Emissions by Year"), col = "purple")
dev.off()

