###GLOBAL TO ALL PLOTS###

library(plyr)
library(dplyr)
library(ggplot2)

raw <- readRDS("./R/project4/nei/summarySCC_PM25.rds")
scc <- readRDS("./R/project4/nei/Source_Classification_Code.rds")

###START PLOT 1###

yeartotals <- tapply(raw$Emissions,raw$year,sum)
yearframe <- as.data.frame(yeartotals)
yearframe <- mutate(yearframe, year = rownames(yearframe))
png(filename="plot2-1.png", width=480, height=480)
plot(yearframe$year,yearframe$yeartotals,type="line")
dev.off()