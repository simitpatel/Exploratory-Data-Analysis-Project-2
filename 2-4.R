###GLOBAL TO ALL PLOTS###

library(plyr)
library(dplyr)
library(ggplot2)

raw <- readRDS("./R/project4/nei/summarySCC_PM25.rds")
scc <- readRDS("./R/project4/nei/Source_Classification_Code.rds")

###START PLOT 4###


coal <- filter(scc, grepl(" Coal",EI.Sector))
cc <- filter(coal, grepl("Combustion",SCC.Level.One))

coalemissions <- inner_join(raw,cc)

coalemissions99 <- filter(coalemissions,year==1999)
coalemissions02 <- filter(coalemissions,year==2002)
coalemissions05 <- filter(coalemissions,year==2005)
coalemissions08 <- filter(coalemissions,year==2008)

coalemissions992 <- coalemissions99 %>% group_by(year) %>% summarise(sum(Emissions))
coalemissions022 <- coalemissions02 %>% group_by(year) %>% summarise(sum(Emissions))
coalemissions052 <- coalemissions05 %>% group_by(year) %>% summarise(sum(Emissions))
coalemissions082 <- coalemissions08 %>% group_by(year) %>% summarise(sum(Emissions))

coalyear <- rbind(coalemissions992,coalemissions022,coalemissions052,coalemissions082)
names(coalyear) <- c("year","emissions")
png(filename="plot2-4.png", width=480, height=480)
qplot(year,emissions,data=coalyear,geom="line")
dev.off()