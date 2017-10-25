all: report.html 
#report.html
clean:
	rm -f GDP.csv EDSTATS.csv gdp.data edstats.data Report.html
	#report.html

#We will need to add functions in here, as modular as possible, that 
#perform the data retrievals, data cleaning and data merging. The 
#Build process should execute/create all of the necessary files, which
#will then be referenced in the Report.Rmd file for creating the final 
#report. 

loaddata:
	Rscript -e 'download.file("https://d396qusza40orc.cloudfront.net/getdata/data/GDP.csv", destfile = "GDP.csv", method="curl", quiet = TRUE)'
	Rscript -e 'download.file("https://d396qusza40orc.cloudfront.net/getdata/data/EDSTATS_Country.csv", destfile = "EDSTATS.csv", method="curl", quiet = TRUE)'

cleandata: 
	Rscript 'GDP.R'
	Rscript 'EDSTATS.R'
	
mergedata: Merge.R loaddata cleandata
	Rscript '$<'
 
analysis: Analysis.R mergedata
	Rscript '$<'	

report.html: Report.Rmd analysis
	Rscript -e 'rmarkdown::render("$<")'