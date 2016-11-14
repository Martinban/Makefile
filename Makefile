all: clean report.html

words.txt:
	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'

clean:
	rm -f words.txt histogram.tsv histogram.png report.md report.html
	
	
#$< 1st dependency, $@ output, $*%html:%rmd:%tsv

#%dependency

#$< report.rmd, $^report.rmd, report.tsv, $* report, $@ report.html

#The input-file variable $< refers to the first dependency, histogram.r

histogram.tsv: histogram.r words.txt
	Rscript $<

#Plot a histogram of word lengths, update all and clean
#The R snippet is three lines long, but we’ll still include the script 
#in the Makefile directly, and use semicolons ; to separate the R commands. 
#The variable $@ refers to the output file, histogram.png
histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf
report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'

	