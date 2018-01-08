library("quantmod")


#Get CPI Data from online using GetSymbols which is a part of the quantmod package
getSymbols("CPIAUCSL", src='FRED')
set.seed(1)

#You'll have to adjust this for different date ranges by changing the from date and length.out
#Look up the documentation on xts() as well to get a better idea of the variables used here.

p <- xts(rnorm(224, mean=10, sd=3), seq(from=as.Date('1997-01-02'), by='months', length.out=224))
colnames(p) <- "price"


#Get ratio of index to a base year.
avg.cpi <- apply.monthly(CPIAUCSL, mean)
cf <- avg.cpi/as.numeric(avg.cpi['2017'])#using 2017 as the base year


#Join to original sales data
adjRate <- data.frame(date=index(cf), coredata(cf))
rm(p, cf, avg.cpi, CPIAUCSL)
adjRate$key <- format(as.Date(adjRate$date), "%Y-%m")
