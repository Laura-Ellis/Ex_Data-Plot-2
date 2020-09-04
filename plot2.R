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

# Plot 2
# Save png
png("plot2.png", width=480, height=480)
# Turn off scientific notation
options(scipen=999)
plot(balt_yr, type="l", ylim=c(1500, max(balt_yr$total+200)), lwd=2,
     xlab="year", ylab = "PM25 emissions", main="Baltimore City Emissions by Year")
text(2005, 3500,
     "PM25 Emissions have decreased")
text(2005, 3400,
     "overall (1999 to 2008)")
text(2005, 3300,
     "even with an increase between 2002 and 2005")
require(stats)
reg <- lm(total~year, data=balt_yr)  
coeff=coefficients(reg)
eq = paste0("y = ", round(coeff[2],1), "*x ", round(coeff[1],1))
abline(reg, col="red")
dev.off()
