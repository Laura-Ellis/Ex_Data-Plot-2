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

# Coal data
scc.coal <- SCC[grep("Fuel Comb.*Coal", SCC$EI.Sector),  ]
scc.coal.list <- unique(scc.coal$SCC)
coal <- subset(scc_pm, SCC %in% scc.coal.list)
coal <- coal %>% group_by(type, year) %>% summarize(total = sum(Emissions))

# Plot 4
# Save png
png("plot4.png", width=480, height=480)
# Turn off scientific notation
options(scipen=999)
#Factorize year
coal$year <- as.factor(coal$year)
ggplot(coal, aes(x=year, y=total))+
  geom_col(aes(fill=type))+
  scale_fill_manual(values = c("#0073C2FF", "#EFC000FF"))+
  ggtitle("US Coal Emissions")
dev.off()
