# 2024 OSOS Workshop

## BASIC CONTROLS

# run current line <- ctrl + enter
# clear console workspace <- ctrl + L
# see information on functions/objects <- help(dir) OR ?data.frame

## DIRECTORIES
getwd() # see current working directory

dir() # see files in currently working directory

setwd()
# OR click Session > Set Working Directory > Choose Directory
getwd() #check path

## USING R AS A CALCULATOR
# R can do addition, subtraction, multiplication, division, exponents
2+2
10-2
4*5
6/3
2^3
2*3+1

# Log functions
log(10)
log2(10)
log10(10)
exp(10)

# Trig functions
cos(45)
sin(45)
tan(45)
atan(45)

# Logical operators i.e. True vs False
10 == 10 # equal to
10 > 2 # greater than
10 < 10 # less than
5 >= 10 # greater than or equal to
4 <= 2 # less than or equal to
5 != 4 # not equal to

# R constants
pi
pi^2

# Other functions
sqrt(25) # square root
abs(-5) # absolute value

# Help function can be very useful! Explains what a function does!
help(abs)
help(tan)

### Numeric variables

a <- 2 # saves numeric value of 2 to variable 'a' in environment
alpha <- 3

class(a) # class is the function and 'a' is the argument which shows that 'a' is a numeric variable
class(alpha)

a # shows the value of a in the console

a^2
a + alpha

sum_a_alpha <- a + alpha # adds a with alpha and saves to a new variable

### Numeric Vectors and Functions

vector <- c(2, 3, 6, 8, 5, 5, 4, 3, 2, 9, 8) #vector creates numeric array
class(vector)

mean(vector) #average
median(vector) #median
range(vector) #range
min(vector) #minimum
max(vector) #maximum
sd(vector) #standard deviation

summary(vector) #provides IQR of object

length(vector)

head(vector) #gives first six values of object (default)
head(vector,2) #gives first two values of object
head(vector,8)

tail(vector) #gives last six values of object (default)
tail(vector,3) #gives last three values of object

### Variable types in R

# Integer (similar to numeric but integers CANNOT contain decimals)

a_integer <- as.integer(a) #converts 'a' (a numeric variable) to an integer
class(a_integer) #shows that our new variable is an integer
class(a) #original 'a' variable is numeric

# Characters are variables made of text (strings) // Always use quotations!

course_name <- "Open Source for Open Science" #makes a character variable

course_topics <- c("R Introduction", "Calculations", "Variables") #makes a character vector
course_topics

number <- "5" #R reads anything with quotations as a character
class(number) #shows class is 'character'

number + 4 #doesn't work because number is a character not a string

number2 <- as.numeric(number)
class(number2) #shows as 'numeric'
number2 + 4 #works now because both are numeric variables

vector_char <- as.character(vector) #converts numeric to character
class(vector_char)

new_vec <- c("text", 3, 1.3) #if there is one character in a vector, whole vector is classified as a character
class(new_vec) #shows 'character'

b <- 3 #for numeric variables, spaces DO NOT matter
b2 <-3
b == b2 #TRUE

c <- "3"
c2 <- " 3"
c == c2 #FALSE; for character variables, spaces DO matter


# Factors display categorical variables

surveys <- factor(c("Agree", "Disagree", "Disagree", "Neutral", "Neutral"))
surveys #five responses, three different levels

factor(surveys) #Agree Disagree Disagree Neutral Neutral 
levels(surveys) #Levels: Agree Disagree Neutral

surveys2 <- c("Agree", "Disagree", "Disagree", "Neutral", "Neutral")
surveys2_factor <- as.factor(surveys2)


# Logical variables are either TRUE or FALSE
test <- a > alpha
class(test)

test2 <- a < alpha

# Convert to numeric (false = 0, true = 1)
test_numeric <- as.numeric(test)
test_numeric2 <- as.numeric(test2)


# How to install R packages
install.packages("readxl")
library(readxl)
