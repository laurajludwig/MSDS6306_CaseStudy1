all: loaddata 
#report.html
clean:
	rm -f GDP.csv EDSTATS.csv
	#report.html

#We will need to add functions in here, as modular as possible, that 
#perform the data retrievals, data cleaning and data merging. The 
#Build process should execute/create all of the necessary files, which
#will then be referenced in the Report.Rmd file for creating the final 
#report. 

report.html: Report.Rmd 
	Rscript -e 'rmarkdown::render("$<")'

loaddata:
	Rscript -e 'download.file("https://d396qusza40orc.cloudfront.net/getdata/data/GDP.csv", destfile = "GDP.csv", method="curl", quiet = TRUE)'
	Rscript -e 'download.file("https://d396qusza40orc.cloudfront.net/getdata/data/EDSTATS_Country.csv", destfile = "EDSTATS.csv", method="curl", quiet = TRUE)'

cleandata:
	Rscript 'GDP.r'
	
mergedata:
 Rscript -e 'merged <- merge(gdp, edstats, by = "CountryCode")'
 
analysis:
	Rscript 'Analysis.R'	