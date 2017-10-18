all: report.html
clean:
	rm -f report.html

#We will need to add functions in here, as modular as possible, that 
#perform the data retrievals, data cleaning and data merging. The 
#Build process should execute/create all of the necessary files, which
#will then be referenced in the Report.Rmd file for creating the final 
#report. 

report.html: Report.Rmd 
	Rscript -e 'rmarkdown::render("$<")'