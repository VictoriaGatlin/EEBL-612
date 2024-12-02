### OSOS 2024 Workshop Intro Statistics

#set seed; can be any number
set.seed(1)

#simulate normal distribution data

help(rnorm)
x <- rnorm(100, mean = 10, sd =2)
x

#summary statistics
mean(x)
median(x)
sd(x)
min(x)
max(x)
range(x)

#visualize data
x
help(hist)
hist(x)
hist((x),col = blues9)

#Test for normality
#H0 data is normal distribution
#NULL or Ha = data is not normally distributed
shapiro.test(x)

#data:  x, W = 0.9956, p-value = 0.9876

#set different seed
set.seed(5)
y <- rnorm(100, mean = 11, sd = 2)
y
shapiro.test(y) 
# data:  y, W = 0.98711, p-value = 0.445
hist(y)

#visualizing both data sets
hist(x = x,
     col = "pink",
     breaks = 20,
     border = "white")

hist(x = y,
     col = "lightblue",
     breaks = 20,
     border = "white",
     add = TRUE)

### Independent Samples

#T-Test (parametric)
help("t.test")
t.test(x = x, y = y)

## OUTPUT: Welch Two Sample t-test
#data:  x and y
#t = -3.242, df = 197.49, p-value = 0.001393
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
# -1.3597919 -0.3311987
#sample estimates:
#  mean of x mean of y 
#10.21777  11.06327 

#non-parametric tests: i.e. WILCOXON MANN-WHITNEY TEST
wilcox.test(x = x, y = y)

## OUTPUT: Wilcoxon rank sum test with continuity correction
#data:  x and y
#W = 3814, p-value = 0.003772
#alternative hypothesis: true location shift is not equal to 0
#(indicative of the fact that the test is less powerful than a parametric test)

### Dependent T-test

#paired T-test (parametric)
t.test(x = x, y = y, paired = TRUE)

## OUTPUT: Paired t-test
#data:  x and y
#t = -3.2742, df = 99, p-value = 0.00146
#alternative hypothesis: true mean difference is not equal to 0
#95 percent confidence interval: -1.3578724 -0.3331182
#sample estimates: mean difference -0.8454953 

#PAIRED WILCOXON MANN-WHITNEY TEST (NON-PARAMETRIC)
wilcox.test(x = x, y = y, paired = T)

## OUTPUT: Wilcoxon signed rank test with continuity correction
#data:  x and y, V = 1612, p-value = 0.001704
#alternative hypothesis: true location shift is not equal to 0

#P-value: assuming NULL hypothesis is true, then the p-value is the probability of observing data that is as extreme or more extreme than your data

### simulating character/group data

rep(letters[1:2]) #rep is used to repeat
group <- rep(letters[1:2], length.out = 200)
group
set.seed(6)
response <- rnorm(100, mean = c(10,11), sd = 2) #mean can be set as a vector, not always scalar!
response


test.df <- data.frame(group, response) #creates df in order to run statistical tests

head(test.df) #provides table view of data
str(test.df)

### T-test paired Wilcoxon with groups

#T-test by group (WELCH TWO SAMPLE T-TEST)
t.test(response~group, data = test.df)

##Welch Two Sample t-test
#data:  response by group
#t = -2.1976, df = 197.55, p-value = 0.02914 (i.e. a & b are significantly different)!!!
#alternative hypothesis: true difference in means between group a and group b is not equal to 0
#95 percent confidence interval:
 # -1.21415080 -0.06567404
#sample estimates:
  #mean in group a mean in group b 
#10.15963        10.79954 



## Visualizing with boxplots
boxplot(response~group,
        data = test.df, col = "skyblue", outline = T)
help("boxplot")

#Wilcoxon test by group
wilcox.test(response~group, data = test.df)

### ANOVA (must have 3 or more groups)

#simulating ANOVA data
group.aov <- as.factor(rep(letters[1:3], length.out = 300)) #example of nested function

head(group.aov)
str(group.aov)

response.aov <- rnorm(300, mean = c(10,25,35), sd = 2)

#visualize data
hist(response.aov, breaks = 20, col = rgb(0,0,1,1/4))

test.aov <- data.frame(group.aov,
                       response.aov)
str(test.aov)
head(test.aov)

test.aov.fit <- aov(response.aov ~ group.aov,
                    data = test.aov) #response.aov is the dependent variable here
#R has hidden features that allow for graphics not specified before
plot(test.aov.fit)

summary_statistics <- summary(test.aov.fit)

#Tukey post-hoc test
TukeyHSD(test.aov.fit)

#OUTPUT: Tukey post-hoc test shows that all three are significantly different
#$group.aov
#diff       lwr      upr p adj
#b-a 14.748184 14.103002 15.39337     0
#c-a 24.399908 23.754726 25.04509     0
#c-b  9.651724  9.006541 10.29691     0


#AOV and post-hoc where not everything is different
group.aov2 <- as.factor(rep(letters[1:3],
                            length.outm = 300))

response.aov2 <- rnorm(300,
                   mean = c(10, 10.5, 35),
                   sd = c(2, 6, 1.5))

hist(response.aov2, breaks = 20)

test.aov2 <- data.frame(group.aov2, response.aov2)

test.aov.fit2 <- aov(response.aov2 ~ group.aov2, data = test.aov2)
summary(test.aov.fit2)

TukeyHSD(test.aov.fit2)
