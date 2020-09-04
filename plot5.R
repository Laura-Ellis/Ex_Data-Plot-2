# JHU Exploratory Data Analysis
# Course Project 2

# set working directory
setwd("C:/Users/Laura/OneDrive/Coursera JHU/4_EXDATA/Project 2")

# Load libraries
library(data.table)
library(dplyr)
library(ggplot2)
library(scales)

# import data
scc_pm <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Vehicle data
scc.veh <- SCC[grep("Mobile.*Vehicles", SCC$EI.Sector),  ]
scc.veh.list <- unique(scc.veh$SCC)
vehicle <- subset(scc_pm, SCC %in% scc.veh.list)
veh_balt <- vehicle[ which(vehicle$fips==24510),]
# Add detail
veh_balt <- merge(x=veh_balt, y=scc.veh[, c("SCC", "SCC.Level.Two", "SCC.Level.Three")], by = "SCC")
veh_balt <- veh_balt %>% group_by(SCC.Level.Two, year) %>% summarize(total = sum(Emissions))
# Rename SCC Level Two
colnames(veh_balt)[1] <- "type"

# Plot 4
# Save png
png("plot5.png", width=480, height=480)
# Turn off scientific notation
options(scipen=999)
#Factorize year
veh_balt$year <- as.factor(veh_balt$year)
ggplot(veh_balt, aes(x=year, y=total))+
  geom_col(aes(fill=type))+
  scale_fill_manual(values = c("#00AFBB", "#FC4E07", "#FC4E07"))+
  ggtitle("Baltimore City Vehicle Emissions")
dev.off()
