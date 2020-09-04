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

# Baltimore city subset
balt <- scc_pm[ which(scc_pm$fips==24510),]
balt_yr <- balt %>% group_by(year) %>%
  summarize(total = sum(Emissions))
balt_type <- balt %>% group_by(year, type) %>%
  summarize(total = sum(Emissions))

# Plot 3
# Save png
png("plot3.png", width=480, height=480)
# Turn off scientific notation
options(scipen=999)
balt$year <- as.factor(balt$year)
ggplot(balt, aes(x=year, y=Emissions))+
  geom_bar(stat='identity', fill="forest green")+
  ylab("Emissions in tons")+
  facet_wrap(~type)
dev.off()
