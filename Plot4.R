## Load package
library(ggplot2)

## Zip file
filename <- "exdata_data_NEI_data.zip"

## Unzip zip files for rds
if (!file.exists("summarySCC_PM25.rds")) {
  unzip(filename)
}
if (!file.exists("Source_Classification_Code.rds")){
  unzip(filename)
}

## Read in data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Create Coal data 
greps <- with(SCC, unique(grep("coal", EI.Sector, ignore.case = TRUE, value = TRUE)))
data <- subset(SCC, EI.Sector %in% greps)
coal <- subset(NEI, SCC %in% data$SCC)

coal$year <- as.character(as.integer(coal$year)) ## For plotting purposes

# Plot 4
png('Plot4.png', width=480, height=480)
ggplot(data = coal, aes(x = year, y = Emissions, fill = type)) + 
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("U.S. Coal Combustion-Related Emissions: 1999-2008")
dev.off()


