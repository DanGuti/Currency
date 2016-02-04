## Convert mxn to usd in 2015 with official data
library(XML)
u <- "http://www.federalreserve.gov/releases/h10/hist/dat00_mx.htm"

#Retrieve website
webpage <- getURL(u)
webpage <- readLines(tc <- textConnection(webpage)); close(tc)

#Parse html
pagetree <- htmlTreeParse(webpage, error=function(...){}, useInternalNodes = TRUE)

date <- xpathSApply(pagetree, "//*/table[@class='statistics']/tr/th", xmlValue)
rate <- xpathSApply(pagetree, "//*/table[@class='statistics']/tr/td", xmlValue)

#Clean and format date and rate data
date = gsub(" ","",date)
date = gsub("-","",date)
date = as.Date(date,"%d%b%y")

rate=gsub(" ","",rate)

#Gather data in reference table and fill missing values with average of prev and following values
reft <- cbind(date,rate)
colnames(reft) <- c("Date", "Rate")


