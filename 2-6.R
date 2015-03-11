###GLOBAL TO ALL PLOTS###

library(plyr)
library(dplyr)
library(ggplot2)

raw <- readRDS("./R/project4/nei/summarySCC_PM25.rds")
scc <- readRDS("./R/project4/nei/Source_Classification_Code.rds")

###START PLOT 6###

la <-  filter(raw,fips == "06037")
baltla <- rbind(baltimore,la)
baltla$fips <- revalue(baltla$fips, c("06037"="LA"))
baltla$fips <- revalue(baltla$fips, c("24510"="Baltimore"))

baltlaroademissions <- inner_join(baltlaroads,scc)
baltlaroads <- filter(baltla,type == "ON-ROAD")

baltlaroademissions99 <- filter(baltlaroademissions,year==1999)
baltlaroademissions02 <- filter(baltlaroademissions,year==2002)
baltlaroademissions05 <- filter(baltlaroademissions,year==2005)
baltlaroademissions08 <- filter(baltlaroademissions,year==2008)

baltlaroademissions992 <- baltlaroademissions99 %>% group_by(year,fips) %>% summarise(sum(Emissions))
baltlaroademissions022 <- baltlaroademissions02 %>% group_by(year,fips) %>% summarise(sum(Emissions))
baltlaroademissions052 <- baltlaroademissions05 %>% group_by(year,fips) %>% summarise(sum(Emissions))
baltlaroademissions082 <- baltlaroademissions08 %>% group_by(year,fips) %>% summarise(sum(Emissions))

baltlayear <- rbind(baltlaroademissions992,baltlaroademissions022,baltlaroademissions052,baltlaroademissions082)
names(baltlayear) <- c("year","city","emissions")
png(filename="plot2-6.png", width=650, height=650)
qplot(year,emissions,data=baltlayear,geom="line",color=city)
dev.off()
