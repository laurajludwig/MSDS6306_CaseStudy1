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

edstats <- read.csv("EDSTATS.csv", stringsAsFactors = FALSE)
# Remove extraneous columns
edstats <- edstats[1:3]

edstats <- edstats[-which(edstats$Income.Group==""),]
edstats$Income.Group <- revalue(edstats$Income.Group, c("Low income" = "LI", 
                                                        "Lower middle income" = "LMI", 
                                                        "High income: nonOECD" = "HI_nonOECD", 
                                                        "Upper middle income" = "UMI", 
                                                        "High income: OECD" = "HI_OECD"))

