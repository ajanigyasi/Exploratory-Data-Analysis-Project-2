## Load package
library(ggplot2)

## Zip file
filename <- "exdata_data_NEI_data.zip"

## Unzip zip file for rds
if (!file.exists("summarySCC_PM25.rds")){
  unzip(filename)
}

## Read in data 
NEI <- readRDS("summarySCC_PM25.rds")

## Create Baltimore data
baltimore <- subset(NEI, NEI$fips == "24510")

## Plot 3
png('Plot3.png', width=480, height=480)
ggplot(data=baltimore, aes(x = year, y = Emissions)) + 
  geom_point(size = 4, alpha = 0.5, aes(color = type)) + 
  ggtitle("Baltimore, MD Emissions by Type: 1999-2008")
dev.off()
