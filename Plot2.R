## Zip file
filename <- "exdata_data_NEI_data.zip"

## Unzip zip file for rds
if (!file.exists("summarySCC_PM25.rds")){
  unzip(filename)
}

## Read in data
NEI <- readRDS("summarySCC_PM25.rds")

# Create Baltimore data
baltimore <- subset(NEI, NEI$fips == "24510")
totalBaltimore <- with(baltimore, tapply(Emissions, INDEX = year, sum))

## Plot 2
png('Plot2.png', width=480, height=480)
barplot(totalBaltimore,  xlab = "Year", ylab = "Emissions", 
     main = expression("Total Baltimore City, MD" ~ PM[2.5] ~ "Emissions by Year"), col = "purple")
dev.off()

