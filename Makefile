all: clean words.txt histogram.tsv

words.txt:
	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'

clean:
	rm -f words.txt
	
	
#$< 1st dependency, $@ output, $*%html:%rmd:%tsv

#%dependency

#$< report.rmd, $^report.rmd, report.tsv, $* report, $@ report.html

#The input-file variable $< refers to the first dependency, histogram.r

histogram.tsv: histogram.r words.txt
	Rscript $<
	
