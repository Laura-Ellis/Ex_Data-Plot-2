# JHU Exploratory Data Analysis
# Course Project 2

# set working directory
setwd("C:/Users/Laura/OneDrive/Coursera JHU/4_EXDATA/Project 2")

# Load libraries
library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
library(tidyverse)

# import data
scc_pm <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data
scc.veh <- SCC[grep("Mobile.*Vehicles", SCC$EI.Sector),  ]
scc.veh.list <- unique(scc.veh$SCC)
vehicle <- subset(scc_pm, SCC %in% scc.veh.list)
vehicle_la <- vehicle[ which(vehicle$fips=="06037"),]
vehicle_bc <- vehicle[ which(vehicle$fips=="24510"),]
vehicle_bc$location <- "Baltimore City"
vehicle_la$location <- "Los Angeeles County"
vehicle <- rbind(vehicle_bc, vehicle_la)
summary <- vehicle %>% group_by(location,year) %>% summarize(total = sum(Emissions))
summary_add <- summary
summary_add$year <- summary_add$year-3                                                        
colnames(summary_add)[3] <- "next_year"
df <- merge(summary, summary_add)
df$percent_change <- (df$next_year - df$total)/df$total*100
df$year2 <- df$year+3
colnames(df)[2] <- "year1"
colnames(df)[3] <- "total1"
colnames(df)[4] <- "total2"
df$label <- paste(df$year1, " to ", df$year2)
mytable <- data.frame(paste(df$total1, " to ", df$total2))

# Plot 6
veh$year <- as.factor(veh$year)
ggplot(veh, aes(x=year, y=total, fill=location))+
  geom_bar(position="dodge", stat="identity")+
  ggtitle("Vehicle Emissions: Baltimore City and LA County")+
  labs(y="Emissions", x="year")

png("plot6.png", width=480, height=480)
ggplot(df, aes(x=label, y=percent_change, fill=location)) +
  geom_bar(position="dodge", stat="identity") +
  ggtitle("% Change in Vehicle Emissions: Baltimore City and LA County") +
  labs(y="% Change", x="time period")
dev.off()
