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
df <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# View data
str(df)
summary(df)
head(df)

# Sum by year
df1 <- df %>% group_by(year) %>%
  summarize(total = sum(Emissions))

# Save png
png("plot1.png", width=480, height=480)

# Plot 1
plot(df1$year, df1$total/1000000, col="blue", type='o', main="Tons of Emissions in US", xlab="Year", ylab="Thousands of Tons of Emissions (all sources)")
text(2005, 7.2,
     "PM Emissions have decreased")
text(2005, 7,
     "each year (1999 to 2008)")
dev.off()
