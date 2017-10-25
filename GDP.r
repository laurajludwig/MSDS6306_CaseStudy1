#----------
#This is an example R file we may need to use to generate some piece of the makefile.
#----------
library(readr)
library(tidyr)
library(dplyr)
library(stringr)

#Note: Rankings include only those economies with confirmed GDP estimates. Figures in italics are for 2011 or 2010.
#a. Includes Former Spanish Sahara.  b. Excludes South Sudan  c. Covers mainland Tanzania only. d. Data are for the area 
#controlled by the government of the Republic of Cyprus.   e. Excludes Abkhazia and South Ossetia.  f. Excludes Transnistria.

gdp <- read.csv("GDP.csv", skip = 3)
# Remove extraneous columns
gdp[c(3,6:10)] <- NULL
names(gdp)[c(1, 4)] <- c("CountryCode", "US.dollars")
# Remove Blank Rows
gdp <- gdp[-which(gdp$CountryCode==""),]

gdp$US.dollars <- gsub(",", "", gdp$US.dollars)
  ## ".." in the US Dollars column represents not available. as.Numeric automatically converts these to NA
gdp$US.dollars <- as.numeric(as.character(gdp$US.dollars))
gdp$Ranking <- as.numeric(as.character(gdp$Ranking))

gdp.stats <- gdp[which(is.na(gdp$Ranking) & !is.na(gdp$US.dollars)),]
gdp <- gdp[-which(is.na(gdp$Ranking) & !is.na(gdp$US.dollars)),]

