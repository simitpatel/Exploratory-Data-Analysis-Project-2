###GLOBAL TO ALL PLOTS###

library(plyr)
library(dplyr)
library(ggplot2)

raw <- readRDS("./R/project4/nei/summarySCC_PM25.rds")
scc <- readRDS("./R/project4/nei/Source_Classification_Code.rds")

###START PLOT 5###

baltroads <- filter(baltimore,type == "ON-ROAD")
baltroademissions <- inner_join(baltroads,scc)

baltroademissions99 <- filter(baltroademissions,year==1999)
baltroademissions02 <- filter(baltroademissions,year==2002)
baltroademissions05 <- filter(baltroademissions,year==2005)
baltroademissions08 <- filter(baltroademissions,year==2008)

baltroademissions992 <- baltroademissions99 %>% group_by(year) %>% summarise(sum(Emissions))
baltroademissions022 <- baltroademissions02 %>% group_by(year) %>% summarise(sum(Emissions))
baltroademissions052 <- baltroademissions05 %>% group_by(year) %>% summarise(sum(Emissions))
baltroademissions082 <- baltroademissions08 %>% group_by(year) %>% summarise(sum(Emissions))

baltyear <- rbind(baltroademissions992,baltroademissions022,baltroademissions052,baltroademissions082)
names(baltyear) <- c("year","emissions")
png(filename="plot2-4.png", width=480, height=480)
qplot(year,emissions,data=baltyear,geom="line")
dev.off()
