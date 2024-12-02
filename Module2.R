###------------Setup and Understanding Data Types-----------------------------
# 
# By Alex Howard, adapted from Danielle Walkup
# EEB OSOS Workshop, August 2024
#
# This script goes with the OSOS-2024 handout, Module 2 
# 
###------------Types of data-------------------------------------------------
## Some examples:
?class()  #we can learn a little something about the classes in R

#
# The classes can vary depending on the type of data:
mydata_num <- c(1.4, 5.6, 8.3, 5.6, 5.0)
class(mydata_num)  #returns numbers

mydata_cha <- c("1.4", "5.6", "8.3", "5.6", "5.0")
class(mydata_cha)  #returns characters

# if you need to change the class, you can:
mydata_num2 <- as.numeric(mydata_cha)
class(mydata_num2)

mydata_cha2 <- as.character(mydata_num)
class(mydata_cha2)

# Notice what happens when we change them to integers:
mydata_int <- as.integer(mydata_cha)
class(mydata_int)
mydata_int

## Factors
# Ordering of factors defaults to alphabetical:
fruit <- factor(c("apple","pear","banana","grape"))
fruit

# But we can change that if we want to:
fruit2 <- factor(c("apple","pear","banana","grape")
                  , levels = c("apple","pear","banana","grape"))
fruit2
#
# We can also create an ordinal variable:
fruit_ord <- factor(c("apple",'pear',"banana","grape"), ordered = TRUE)
fruit_ord  #note the < between the levels now AND our levels changed back to alphabetical
fruit_ord2 <- factor(c("apple",'pear',"banana","grape")
                     , levels = c("apple","pear","banana","grape")
                     , ordered = TRUE)
fruit_ord2  #Much better - if you like grapes...
#
# Notice there are some constraints on classes:
fruit_ch <- as.character(fruit)
class(fruit_ch)
fruit_ch

fruit_num <- as.numeric(fruit_ch)  #It'll do it, but it'll do it badly.
class(fruit_num)
fruit_num
#
# BUT, be careful, because we can coerce factors to numbers or integers:
fruit_num2 <- as.numeric(fruit)  #using the alphabetically ordered fruit
class(fruit_num2)
fruit_num2  #Note that it keeps the ordering

fruit_int <- as.integer(fruit2)  #using our fruit orders
class(fruit_int)
fruit_int  #Again, note that it keeps the changed ordering
# 
###-------------Data Objects Examples-------------------------------------------
#
## Vectors - collection of elements of the same type
vec1 <- c(1, 2, 3, 4, 5)
vec2 <- c("apple", "pear", "banana", "grape")
vec3 <- c("blue", 3, 5i, "lizard") 

# We can see elements in the vectors:
vec2[3] #the single bracket lets us see the element in the 3rd place in the vector
vec2[8] #there's nothing in here - because we only have the 4 fruit in the original vector

# We can get all sorts of information about the vectors:
class(vec1) 
class(vec3) #all elements must be the same type, all elements in this vector are characters
length(vec2)
is.na(vec1)  #a handy function to check for missing values
sum(vec1)    #we can run functions specific to the given class
sum(vec2)   #no numbers to add, will give you an error
str(vec1)

## Lists
ex_list <- list(1, "a", TRUE, 1+4i)
class(ex_list)  #now we see this is a list, with its special list properties
# We can still see the different elements and characteristics
ex_list[2]
length(ex_list)
str(ex_list)

# You can also name the elements in each list
ex_biglist <- list(a = "Testing", b = 1:10, flowers = head(iris))
#

# now if we want to see what's in the list:
names(ex_biglist)  #we can also see the names
ex_biglist[2]  #and what's in the list
ex_biglist$b  #alternatively, if we have elements in the list named, we can use the
            # '$' to choose the different names and show what's in them
length(ex_biglist)  #but we still only have 3 things in the list

## Matrices
ex_mat <- matrix(1:10, nrow = 2)
ex_mat
ex_mat2 <- matrix(1:10, nrow = 2, byrow = TRUE)   
#TIP: instead of writing out 1,2,3,4,5,6,7,8,9,10, we use 1:10 to give us the 
#     sequence of numbers
ex_mat2

# and we can see characteristics:
class(ex_mat)
str(ex_mat)
length(ex_mat)
dim(ex_mat)  #Now we can see the dimensions
ex_mat[2,1]  #now that we have 2 dimensions, we can use [row,column] to id an element
ex_mat[,2]  #or see just a column
ex_mat[2,]  #or see just a row
sum(ex_mat)  #can still do math on a numeric matrix - 
t(ex_mat)  #can also transpose a matrix 

## Data Frames
# here we will create a data frame with 3 columns: id, height, and width
ex_df <- data.frame(id = rep(c("a","b","c"),4), height = 1:12, width = 12:1)
ex_df  #lets make sure it did what we expected

# and check out some of its characteristics:
class(ex_df)
str(ex_df)
summary(ex_df)
length(ex_df)  #we can still get a length, but it may not quite be the info we want
dim(ex_df)
t(ex_df)  #we can still transpose the data frame

# and we can see the different parts:
ex_df$id
class(ex_df$id)  #which we can double check here
class(ex_df$width)  #and it has defaulted width to integer, which we could change:
as.numeric(ex_df$width)
class(ex_df$width)  #wait, I though we changed this?!
# with data frames we need to re-assign the column to "save" the changes
ex_df$width <- as.numeric(ex_df$width)
class(ex_df$width)
#
# We could even do math using columns from the data frame:
sum(ex_df$width)
mean(ex_df$width)

## Subsetting our data frame
# we've subsetted throughout this script using brackets [], but there are lots 
# of ways to subset our database:
ex_df[1, ] #just a row
ex_df[, 1] #just a column
ex_df[2, 2] #row 2 and column 2

# we can subset based on different criteria
ex_df[which(ex_df$id == "a"), ] 
ex_df[ex_df$id %in% "a", ] 
subset(ex_df, id == "a")


###------------Loading Data-----------------------------------------------------
#
## read.csv or read.table are the typical functions we will use to upload data

#you can also input excel files using the package openxlsx
#install.packages("openxlsx")
library(openxlsx)
#I recommend using either csv or txt, as these can be read by base R

## read.csv has a ton of options to read in your data set, check out the different arguments:
args(read.csv)
help(read.csv)
# header  - tell it whether or not there is a head row
# col.names - can change the names of the columns
# row.names - or add row names
# colClasses - can specify the column classes
# strip.white - removes leading or trailing white spaces
# blank.lines.skip - skips empty rows
# na.strings - what values should be considered NA

# First, lets make sure the file is where we think it is! And it's an easy way to 
# get our file name
dir("data")  #looks good

# I'll set a file path here (makes it more easily accessible)
#NOTE: by using data/ I'm telling R to look in that folder for the file
liz_csv <- "data/LizardData.csv"  

## If the file is saved as a .csv we can simply read it in:
liz_df <- read.csv(liz_csv)
head(liz_df, 2)  #double check that it worked

# and we can check out our new data frame:
class(liz_df)
head(liz_df)  #look it automatically reads our headings!
str(liz_df)  #tells us the column classes and info about the data.frame
dim(liz_df)
summary(liz_df)  #gives us a brief overview of each column, already, I can see some indicators of a messy data set: check out the Sex, Regen, and the Recap column summaries! 

## If we have a text file, we can still read it in using read.csv
liz_txt <- "data/LizardData.txt"
liz_df_txt <- read.csv(liz_txt, sep = "\t")  #sep = "\t" tells R its a tab-delimited text file
head(liz_df_txt, 2)  #and it looks the same as above

## Finally, we can also load the excel file using our package openxlsx:
liz_xl <- "data/LizardData.xlsx"
liz_df_xl <- read.xlsx(liz_xl)
head(liz_df_xl, 2)

# but note the differences in how each loads the data by default:
str(liz_df)
str(liz_df_txt)
str(liz_df_xl)
#
#
###------------Load our Practice Data Set---------------------------------------
#
## We've already done this, but let's make sure we have the correct data set loaded and ready to go
## We'll go ahead and add some extra arguments to bring our dataset in cleaner

## 'strip.white = T' removes any leading or trailing white space, because R considers 
## "F", " F", and "F " three different factors.

## Also, since this data set isn't very big, we can just assign colClasses that 
## way each column starts with the correct class, although I will assign date 
## and regen as characters because of some data entry issues
liz_df <- read.csv(liz_csv, strip.white = T,
                   colClasses = c("factor", "factor", "character", "integer",
                                  "factor", "numeric", "numeric", "character",
                                  "numeric","character", "factor", "character"))

# and check that it loaded ok:
head(liz_df)
tail(liz_df)
#
###------------Cleaning our Data Set--------------------------------------------
#
# Let's check the summary again to help identify any issues
summary(liz_df) 

# Some known issues:
# Sex - we have some duplicate categories (M vs. Male) and an age class (J)
# Regen - characters but should be numbers
# Recap - again, with the duplicate categories (N vs no vs No)
# Date is a character here, but we actually want a date. But because people 
# entered the data in multiple formats, it's going to take some work

# We can use some functionality from tidyverse, particularly the dplyr package
# A collection of R packages for data science: https://www.tidyverse.org/
# R for Data Science by Hadley Wickham and Garrett Grolemund:
# http://r4ds.had.co.nz/
library(dplyr)

#
# First lets get rid of those no's (and probable yes's) in the Regen
# I'm just going to run a table to see what we have going on
table(liz_df$Regen)  #so we have 3 No's, 1 Yes, and the weird 38/6
#
# let's check out that weird 38/6 
# We can use ([row,col]) here to find the row that matches the one weird record:
liz_df[liz_df$Regen == "38/6", ]  

# so the notes tells me that there were two areas of tail regeneration,
# so I'm just going to change this to 38 using dplyr::recode
liz_df$Regen <- recode(liz_df$Regen, "38/6" = "38")

# we also need to remove the no's and yes's as just blanks
liz_df$Regen <- recode(liz_df$Regen, "No" = "", "Yes" = "") 
# and one last table to double check
table(liz_df$Regen)  
# so lets make that numeric now.
liz_df$Regen <- as.numeric(liz_df$Regen)

## Let's clean up the sex column, because we do want to use that:
table(liz_df$Sex)
# lets change the Male to M - capitilization matters!
liz_df$Sex <- recode(liz_df$Sex, "Male" = "M", "J" = "")  

## So now that we have those basic columns cleaned up, lets subset the data frame
## down to just the columns we want to use
head(liz_df, 1)
liz_sub <- liz_df[, c(1:2, 5:9)]  
head(liz_sub, 2)

# Alternative ways to subset:
liz_sub1 <- liz_df[, c("ID", "Mark", "Sex", "SVL", "Tail", "Regen", "Mass")]
liz_sub2 <- subset(liz_df, select = c("ID", "Mark", "Sex", "SVL", "Tail", "Regen", "Mass"))
liz_sub3 <- liz_df %>% select(ID, Mark, Sex, SVL, Tail, Regen, Mass)

## So many NA's - what if we wanted to create a subset of our data frame with 
## no NA's? 
sum(is.na(liz_sub$Sex)) #sum counts FALSE as 0 and TRUE as 1, letting us get 
# a count of na's
liz_subna <- liz_sub[!is.na(liz_sub$Sex), ]
is.na(liz_subna$Sex)  #that's a lot of falses, lets summarize that
sum(is.na(liz_subna$Sex))  
dim(liz_sub)
dim(liz_subna)

#We can also subset according to values in our dataset
#for example, say we only wanted to look at males:
liz_male <- liz_df[liz_df$Sex == "M",]
head(liz_male)
#there are still NA's
#we can add conditions using the & symbol
liz_male2 <- liz_df[liz_df$Sex == "M" & !is.na(liz_df$Sex),]
head(liz_male2)

#if we only want animals less than 60 SVL
liz_small <- liz_subna[liz_subna$SVL < 60,]
head(liz_small)

#
###------------Exporting Cleaned and Summary Data-------------------------------
#
## Finally I'm going to export my clean data frame so that I can use it in other
## places as needed
dir.create("outputs")  #first I'm going to add a folder to the directory
write.csv(liz_sub, "outputs/LizardData_Clean.csv")

## What if you just want a table of summary information???
liz_summ <- liz_sub %>% group_by(ID) %>%
  summarise(avgSVL = mean(SVL, na.rm = T), sdSVL = sd(SVL, na.rm = T)
            , maxSVL = max(SVL, na.rm = T), minSVL = min(SVL, na.rm = T)
            , avgTail = mean(Tail, na.rm=T), sdTail=sd(Tail, na.rm = T) 
            , avgMass = mean(Mass, na.rm=T), sdMass=sd(Mass, na.rm=T)
            , Nliz = n())

# and again we can save that summary output:
write.csv(liz_summ, "outputs/LizardSummaryData.csv")


