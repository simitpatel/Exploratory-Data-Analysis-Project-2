###GLOBAL TO ALL PLOTS###

library(plyr)
library(dplyr)
library(ggplot2)

raw <- readRDS("./R/project4/nei/summarySCC_PM25.rds")
scc <- readRDS("./R/project4/nei/Source_Classification_Code.rds")
###START PLOT 3###

baltimore99 <- filter(baltimore,year==1999)
baltimore02 <- filter(baltimore,year==2002)
baltimore05 <- filter(baltimore,year==2005)
baltimore08 <- filter(baltimore,year==2008)

baltimore992 <- baltimore99 %>% group_by(type) %>% summarise(sum(Emissions))
baltimore992 <- mutate(baltimore992,year=1999)

baltimore022 <- baltimore02 %>% group_by(type) %>% summarise(sum(Emissions))
baltimore022 <- mutate(baltimore022,year=2002)

baltimore052 <- baltimore05 %>% group_by(type) %>% summarise(sum(Emissions))
baltimore052 <- mutate(baltimore052,year=2005)

baltimore082 <- baltimore08 %>% group_by(type) %>% summarise(sum(Emissions))
baltimore082 <- mutate(baltimore082,year=2008)

baltimorepoints <- rbind(baltimore992,baltimore022,baltimore052,baltimore082)
names(baltimorepoints) <- c("type", "emissions", "year")
png(filename="plot2-3.png", width=650, height=650)
qplot(year,emissions,data=baltimorepoints,color=type,geom="line")
dev.off()