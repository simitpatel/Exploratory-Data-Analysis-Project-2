###GLOBAL TO ALL PLOTS###

library(plyr)
library(dplyr)
library(ggplot2)

raw <- readRDS("./R/project4/nei/summarySCC_PM25.rds")
scc <- readRDS("./R/project4/nei/Source_Classification_Code.rds")

###START PLOT 2###

baltimore <- filter(raw,fips == "24510")
baltimore2 <- tapply(baltimore$Emissions,baltimore$year,sum)
baltimore2 <- as.data.frame(baltimore2)
baltimore2 <- mutate(baltimore2, year = rownames(baltimore2))
#png(filename="plot2-2.png", width=480, height=480)
plot(baltimore2$year,baltimore2$baltimore,type="line")
#dev.off()
