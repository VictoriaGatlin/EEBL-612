
# NOTES ON OSOS WORKSHOP 

## WORKING DIRECTORIES

getwd() #get working directory

dir() #see your files in your working directory

setwd("/Users/nicolestevens/Dropbox/Mac/Desktop") #change working directory to desktop
getwd() #check working directory

## USING R AS A CALCULATOR
#R can do addition, subtraction, multiplication, division, and exponents
2+2
4*5
10-2
6/3
2^3
2*3+1

#R functions
log(10) #log of 10
log2(10)
log10(10)
exp(10)

#Trig functions
cos(45)
sin(90) 
tan(180)

#Logical operators (either TRUE or FALSE)
10 == 10 #equal to
10 < 10 #less than
5 > 10 #greater than
4 >= 2 #greater than or equal to
4 <= 2 #less than or equal to
5 != 4 #not equal to

#R constants
pi
pi^2

# Other functions
sqrt(25) #square root
abs(-5) #absolute value

#Help function can be very useful! Explains what a function does
help(abs)
help(tan)


### Numeric variables

a <- 2 #gives 2 as the value of a
alpha <- 3

class(a) # shows that a is a numeric variable
class(alpha)

a #shows the value of a in the console

a^2
a + alpha

sum_a_alpha <- a + alpha #adds a and alpha and saves that as a new variable


### Numeric Vectors and Functions

vector <- c(2, 3, 6, 8, 5, 5, 4, 3, 2, 9, 8) #vector creation
vector

#functions on the vector
mean(vector) #gives average
median(vector)
min(vector)
max(vector)
sd(vector) #standard deviation

summary(vector) #gives min, max, mean, median, quartiles

length(vector)

head(vector) #gives first six values of my vector (default)
head(vector,2) #gives first two digits of vector
head(vector, 8) #gives first 8 digits of vector

tail(vector) #shows last 6 digits of vector (default)
tail(vector,3) #shows last 3 digits of vector


### Variable types in R

# Integers CANNOT contain decimals
a_integer <- as.integer(a) #converts a (a numeric variable) to an integer
class(a_integer) #shows that our new variable is an integer
class(a) #original a variable is numeric

# Characters are variables made of text (strings)
course_name <- "Open Source for Open Science" #makes a character variable

course_topics <- c("R introduction", "calculations", "variables") #makes character vector
course_topics

number <- "5"
class(number)

number + 4 #doesn't work because number is a character not a string

number2 <- as.numeric(number) #converts character variable to numeric
class(number2)
number2+4

vector_char <- as.character(vector) #converts numeric to character

new_vec <- c("text", 3, 1.3) #if there is one chr in a vector, whole vector is characters
class(new_vec)

b <- 3 #for numeric variables, spaces do not matter
b2 <-3
b == b2 #TRUE

c <- "3"
c2 <- " 3"
c == c2


# Factors display categorical variables
surveys <- factor(c("Agree", "Disagree", "Disagree", "Neutral", "Neutral"))
surveys #five responses, 3 different levels

levels(surveys)

surveys2 <- c("Agree", "Disagree", "Disagree", "Neutral", "Neutral")
surveys2_factor <- as.factor(surveys2)


#Logical variables are either TRUE or FALSE
test <- a > alpha
class(test)

test2 <- a < alpha

#convert to numeric (false = 0, true = 1)
test_numeric <- as.numeric(test)
test_numeric2 <- as.numeric(test2)


# How to Install R packages
install.packages("readxl")
library(readxl)

