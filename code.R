#Description####
#HarvardX: PH525.1x Data Analysis for Life Sciences 1: Statistics and R
#
#Brief Introduction to dplyr
#
#recommended packaged
#library(devtools)
#install_github("genomicsclass/dagdata")

#Introduction####
#location of the packege
dir <- system.file(package="dagdata")
list.files(dir)
list.files(file.path(dir,"extdata")) #external data is in this directory

filename <- file.path(dir,"extdata/femaleMiceWeights.csv")

#load package
dat <- read.csv(filename)
library(dplyr)

chow <- filter(dat, Diet=="chow") #keep only the ones with chow diet 
head(chow)

#select the values
chowVals <- select(chow,Bodyweight)
head(chowVals)

#in one line with the pipe
chowVals <- filter(dat, Diet=="chow") %>% select(Bodyweight)
chowVals

#For pedagogical reasons, we will often want the final result to be a simple numeric vector. To obtain such a vector with dplyr, we can apply the unlist function which turns lists, such as data.frames, into numeric vectors:
chowVals <- filter(dat, Diet=="chow") %>% select(Bodyweight) %>% unlist
class( chowVals )

#To do this in R without dplyr the code is the following:
chowVals <- dat[ dat$Diet=="chow", colnames(dat)=="Bodyweight"]

#Exercise####
#For these exercises, we will use a new dataset related to mammalian sleep. This data is described here. Download the CSV file from this location:
#We are going to read in this data, then test your knowledge of they key dplyr functions select and filter. We are also going to review two different classes: data frames and vectors.

#Readinthemsleep_ggplot2.csvfilewiththefunctionread.csvandusethefunctionclass to determine what type of object is returned.
getwd()
dat2 <- read.csv("msleep_ggplot2.csv")

class(dat2)

#Now use the filter function to select only the primates. How many animals in the table are primates? Hint: the nrow function gives you the number of rows of a data frame or matrix.
head(dat2)

dat2_primates <- filter(dat2, order=="Primates")
nrow(dat2_primates)

#What is the class of the object you obtain after subsetting the table to only include primates?
class(dat2_primates)

#Now use the select function to extract the sleep (total) for the primates. What class is this object? Hint: use %>% to pipe the results of the filter function to select.
dat2_sleep_primates <- filter(dat2, order=="Primates") %>% select(sleep_total)

class(dat2_sleep_primates)

#Now we want to calculate the average amount of sleep for primates (the average of the numbers computed above). One challenge is that the mean function requires a vector so, if we simply apply it to the output above, we get an error. Look at the help file for unlist and use it to compute the desired average.
mean(filter(dat2, order=="Primates") %>% select(sleep_total) %>% unlist)

#For the last exercise, we could also use the dplyr summarize function. We have not introduced this function, but you can read the help file and repeat exercise 5, this time using just filter and summarize to get the answer.
?summarise
filter(dat2, order=="Primates") %>% summarise(mean(sleep_total))
