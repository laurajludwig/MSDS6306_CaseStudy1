load("edstats.data")
load("gdp.data")
merged <- merge(gdp, edstats, by = "CountryCode")
save(merged, file="merged.data")