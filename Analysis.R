library(ggplot2)

load("merged.data")
load("gdp.data")
load("edstats.data")

#Number of NA's for GDP:
sum(is.na(gdp$US.dollars))
sum(is.na(gdp$Ranking))

# Number of common Country Codes
length(intersect(gdp$CountryCode, edstats$CountryCode))

# Sort Merged data by GDP and retrieve 13th row
merged.sortGDP <- merged[order(merged$US.dollars),]
merged.sortGDP[13,]

# Get the Average GDP for High Income OECD
mean(merged$US.dollars[which(merged$Income.Group=="HI_OECD")])

# Get the Average GDP for High Income nonOECD
mean(merged$US.dollars[which(merged$Income.Group=="HI_nonOECD")], na.rm = TRUE)

# Plot GDP for all the countries, color-coded by income group
ggplot(merged, aes(x =CountryCode, y = US.dollars, color=Income.Group)) +geom_point()

# Cut the GDP Ranking into 5 separate quantile groups
quantiles <- list()
for(i in 1:5){
  quantiles[[i]] <- merged[((i-1)*38+1):(i*38),]
}

# Country Code vs. Income Group Table
with(quantiles[[1]], table(CountryCode, Income.Group))

# How many countries are in the Lower Middle Income, but in the top 38 nations with highest GDP?
sum(quantiles[[5]]$Income.Group=="LMI")




