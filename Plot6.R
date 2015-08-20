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

## Create Baltimore's Motor Vehicle data 
baltimore <- subset(NEI, NEI$fips == "24510")
grep2 <- with(SCC, unique(grep("mobile", EI.Sector, ignore.case = T, value = T)))

## Subset SCC by vehicle type
gas_heavy <- subset(SCC, EI.Sector %in% grep2[1])
deisel_heavy <- subset(SCC, EI.Sector %in% grep2[2])
gas_light <- subset(SCC, EI.Sector %in% grep2[3])
deisel_light <- subset(SCC, EI.Sector %in% grep2[4])

## Subset baltimore by SCC retained vehicle type
gasHeavy <- subset(baltimore, SCC %in% gas_heavy$SCC)
deiselHeavy <- subset(baltimore, SCC %in% deisel_heavy$SCC)
gasLight <- subset(baltimore, SCC %in% gas_light$SCC)
deiselLight <- subset(baltimore, SCC %in% deisel_light$SCC)

## Created a vehicle type column to baltimore
car1 <- data.frame(gasHeavy, vehicle = "Gasoline Heavy Duty Vehicles")
car2 <- data.frame(deiselHeavy, vehicle = "Deisel Heavy Duty Vehicles")
car3 <- data.frame(gasLight, vehicle = "Gas Light Duty Vehicles")
car4 <- data.frame(deiselLight, vehicle = "Deisel Light Duty Vehicles")
cars <- rbind(car1, car2, car3, car4)

cars$year <- as.character(as.integer(cars$year)) ## For plotting purposes

## Subset Los Angeles data
la <- subset(NEI, NEI$fips == "06037")

## Subset la by SCC retained vehicle type
LAgasHeavy <- subset(la, SCC %in% gas_heavy$SCC)
LAdeiselHeavy <- subset(la, SCC %in% deisel_heavy$SCC)
LAgasLight <- subset(la, SCC %in% gas_light$SCC)
LAdeiselLight <- subset(la, SCC %in% deisel_light$SCC)

## Created a vehicle type column to la 
LAcar1 <- data.frame(LAgasHeavy, vehicle = "Gasoline Heavy Duty Vehicles")
LAcar2 <- data.frame(LAdeiselHeavy, vehicle = "Deisel Heavy Duty Vehicles")
LAcar3 <- data.frame(LAgasLight, vehicle = "Gas Light Duty Vehicles")
LAcar4 <- data.frame(LAdeiselLight, vehicle = "Deisel Light Duty Vehicles")
allCars <- rbind(cars, LAcar1, LAcar2, LAcar3, LAcar4)

## Changed the fips name
allCars$fips <- gsub("06037", "Los Angeles", allCars$fips)
allCars$fips <- gsub("24510", "Baltimore", allCars$fips)


## Plot 6
png('plot6.png', width=550, height=480)
ggplot(data = allCars, aes(x = year, y = Emissions, fill = vehicle)) +  facet_grid(.~fips) + 
  geom_bar(stat ="identity", position = position_dodge()) +
  ggtitle(expression(atop("Two City Motor-Vehicle Emission Comparison", 
                          atop(italic("Los Angeles and Baltimore Emissions: 1999-2008")))))
dev.off()







