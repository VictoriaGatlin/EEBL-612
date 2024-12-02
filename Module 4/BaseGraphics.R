#####################################################################################################
#################################### BASE GRAPHICS IN R #############################################
#####################################################################################################

# Open Source Open Science Workshop 2024
# Author: Maria A. Hurtado-Materon
# Date: August 24th, 2024

# During this class, we will learn mainly about the plot() function, the different
# types of graphs that you can make, and tools to modify them to improve their 
# appearance.
  
# In R, most base functions aim to return an object itself. However, plot() 
# interacts with the graphic interface in R and creates a new window, but not an 
# object. In RStudio the graph will be displayed in the pane layout. 
# Then, plot() return an invisible copy of an object.

plot(c(1,2,3))

plot.name <- plot(c(1,2,3)) # What happens when I try to create an object with the plot?

#Clear the current plot window in R with dev.off 
dev.off()

# Opens a new graphics window for interactive plotting
windows() # Windows
# quartz() # Mac
# x11() # Unix/Linux

# Switch back to the window device
dev.set(dev.prev())

# Switch to the next window device
dev.set(dev.next())

plot(cars)

# List all open graphical devices

dev.list() 

#Clear all the plots use graphics.off()
graphics.off()

## 1. Types of plots ##

#Depending on the class of our object, we have different types of plots 

# Scatter plot (numeric vectors)

#Generate a sample data based on a normal distribution with 100 elements
x <- rnorm(100)
y <- x + rnorm(100)

#Create a matrix with the vectors
xyMatrix <- cbind(x,y)

#What is the class of the vectors and the matrix? numerical

#Make the scatter plot
plot(x, y)
plot(xyMatrix)

# Barplot (factors)

#Create a vector with different letters and make the letters factors
letters <- sample(c("A", "B", "C", "D"), 100, rep = TRUE) #Take a sample (n=100) from the elements of x
lettersFactor <- factor(letters)

plot(lettersFactor)
barplot(lettersFactor)

lettersMatrix <- matrix(data = c(26, 21, 21, 32), nrow = 1, ncol = 4)
colnames(lettersMatrix) <- c("A", "B", "C", "D")

barplot(lettersMatrix)

# Boxplot (factor and numeric vector)

plot(lettersFactor, x)

lettersDataframe <- data.frame(lettersFactor, x)

boxplot(x ~ lettersFactor, lettersDataframe)

# Scatterplot of all dataframe columns (dataframe)

#Create a dataframe with the matrix of x and y, and the letters
xyDataframe <- data.frame(xyMatrix, letters)
plot(xyDataframe)

## 2. The types of plot to be drawn ##

#Create a vector with sequences numbers
a <- seq(1, 10, 1)

#par() function sets graphical parameters. mfrow is a vector with the number of columns and rows for the
#graph
par(mfrow = c(3,2))

plot(a, a, type = "p") # for points (by default)
plot(a, a, type = "l") # for lines
plot(a, a, type = "b") # for both; points are connected by a line
plot(a, a, type = "h") # for ‘histogram’ like vertical lines
plot(a, a, type = "s") # for stair steps
plot(a, a, type = "n") # for no plotting

par(mfrow=c(1,1))

#Exercise 1 - Make a scatterplot with overplotted points and lines (points are
#intersected by lines)

#Exercise 1 answer: plot(a, a, type = "o")


## 3. Title and and labels ##

#By default, R will use the vector names of your plot as X and Y axis labels and no title.
#However, you can change them using several arguments.
#For title    main
#For subtitle sub
#For x label  xlab
#For y label  ylab

plot(x,y, main = "Title", sub = "Subtitle", xlab = "X label", ylab = "Y label")

#Change the size of each word of the graph using the arguments: cex.main, cex.sub, cex.lab, cex.axis
plot(x,y, main = "Title", sub = "Subtitle", xlab = "X label", ylab = "Y label",
     cex.main = 3, cex.sub = 0.5, cex.lab = 1, cex.axis = 2)

#Change font styles using the arguments: font.main, font.sub, font.axis, font.lab for the font style. 
# 1 = pain text
# 2 = bold
# 3 = italic
# 4 = bold italic
plot(x,y, main = "Title", sub = "Subtitle",  xlab = "X label", ylab = "Y label",
     font.main = 1, font.sub = 2, font.axis = 3, font.lab = 4)

#Change family fonts using family argument
#You can see the available families using
names(pdfFonts()) #Some of this families can not be installed in your computer 

par(mfrow=c(1,3))

plot(x,y, main = "Title",  xlab = "X label", ylab = "Y label", family = "serif")
plot(x,y, main = "Title",  xlab = "X label", ylab = "Y label", family = "mono")
plot(x,y, main = "Title",  xlab = "X label", ylab = "Y label", family = "sans")

par(mfrow=c(1,1))

#Delete labels with ann = FALSE
plot(x, y, main = "Title",  xlab = "X label", ylab = "Y label", ann = FALSE)

#Exercise 2 - Make a scatter plot with the following characteristics: 
# Title: "My plot", size = 4,  font style = bold
# Axis labels: "My x label" for x axis, "My y label" for y axis, size = 2, font style = bold italic
# Axis size = 1
# Family font = serif 

#Exercise 2 answer:
plot(x,y, main = "My plot", cex.main = 4, font.main = 2,
     xlab = "My x label",
     ylab = "My y label", cex.lab = 2,
     cex.axis = 1, font.axis = 4, family = "serif")


## 4. Tick labels, tick marks ##

#Use last argument to change tick label orientation

par(mfrow = c(1, 3))
plot(x, y, las = 0)   # Parallel to axis (default)
plot(x, y, las = 1)   # Horizontal
plot(x, y, las = 2)   # Perpendicular to axis

#Remove tick labels setting the arguments xaxt or yaxt to "n"
par(mfrow=c(1,2))
plot(x,y, main = "Title",  xlab = "X labe", ylab = "Y label", xaxt= "n")   # x axis
plot(x,y, main = "Title",  xlab = "X label", ylab = "Y label", yaxt= "n")   # y axis
par(mfrow=c(1,1))

#Exercise 3 - Make a scatterplot, where  the axes are in a vertical position, and 
#remove y tick labels


## 5. Axes lines and boxes

#Define the limits of the axes with xlim and ylim arguments
par(mfrow = c(1, 2))
plot(x, y, xlim = c(-1,1), ylim = c(-1,1))      
plot(x, y, xlim = c(-10,10), ylim = c(-10,10))    

#The bty argument allows changing the type of box of the R graphs
par(mfrow = c(2, 3))
plot(x, y, bty = "o")    # Entire box (default) 
plot(x, y, bty = "7")    # Top and right
plot(x, y, bty = "L")    # Left and bottom
plot(x, y, bty = "U")    # Left, bottom and right
plot(x, y, bty = "C")    # Top, Left and bottom  

par(mfrow = c(1, 1))
#Remove axes  with axes = FALSE
plot(x, y, axes = FALSE) 

#Exercise 4 - Make a scatterplot without box


## 6. Colors and appearance ##

#plot() function has plenty of arguments to improve the appearance  of your graph, we will see some 
#examples of them.

#Create two vectors with the positions of the points
seq1 <- rep(c(5,10,15,20,25), each = 5)
seq2 <- rep(c(5,10,15,20,25), each = 1, length.out = 25)

#pch modifies the symbol of the points in the plot
plot(seq1, seq2, pch = 1:25, cex = 3, ann = FALSE, yaxt = "n", xaxt = "n", 
     xlim = c(3,27), ylim = c(3,27))

#cex modifies the symbol size
seq1 <- c(1:4)
seq2 <- c(1,1,1,1)

plot(seq1, seq2, pch = 16, cex = c(1:4), ann = FALSE, yaxt = "n", xaxt = "n", xlim = c(0,5))

#lwd modifies the line width of the symbol
plot(seq1, seq2, pch = 6, cex = 3, lwd = c(1:4), ann = FALSE, yaxt = "n", xaxt = "n", xlim = c(0,5))


#Set border width and background color with the col and bg arguments, respectively
plot(seq1, seq2, pch = 21, cex = 3, lwd = 3, ann = FALSE, yaxt = "n", xaxt = "n", 
     xlim = c(0,5),  bg = c("#F39C12", "black", "#82E0AA", "red"), col = rainbow(4)) 
#Note what is the result when you use rainbow(4)

#Define a color palette using RColorBrewer package
library(RColorBrewer)
brewer.pal(4, "PRGn")
plot(seq1, seq2, cex = 3, lwd = 3, ann = FALSE, yaxt = "n", xaxt = "n", 
     xlim = c(0,5), col = brewer.pal(4, "PRGn"))

#Exercise 5 - Make a scatter plot in which the points are represented by filled diamonds
#with a size of 1.5, with pink background, a green line border, and a width of 2



## 7. Functions that modify plot() ##

## title function
#The main difference between using the title() or the argument inside plot() is that 
#the arguments you pass to title() only affect the title.
plot(x,y)
title(main = "My title line 2",  line = 2)
title(main = "My title line -1", line = -1)
title(main = "My title line -2", line = -2)

#The value of adj determines the way in which text strings are justified in text
plot(x,y)
title(main = "My title adj 0.5", adj = 0.5) 
title(main = "My title adj 0",   adj = 0)
title(main = "My title adj 1",   adj = 1)

## axis function
# Add axes
par(mfrow = c(1,1))
plot(x, y, axes = FALSE)
axis(1) # Add X-axis
axis(2) # Add Y-axis

#Change axis intervals
plot(x, y, axes = FALSE, xlim = c(-3, 3), ylim = c(-4, 4))
axis(2)
axis(1, at = seq(-3, 3, 0.5), labels = seq(-3, 3, 0.5))

## Add text
#The mtext function in R allows you to add text to all sides of the plot box. 
#There are 12 combinations (3 on each side of the box, as left, center and right align). 
#You just need to change the side and adj to obtain the combination you need
plot(x,y)
mtext("Bottom-center", side = 1)
mtext("Bottom-left",   side = 1, adj = 0)
mtext("Bottom-right",  side = 1, adj = 1)

mtext("Right-center",  side = 2)
mtext("Right-bottom",  side = 2, adj = 0)
mtext("Right-top",     side = 2, adj = 1)

#Add text at coordinates (-2, 2)
text(-2, 2, "Text")

#Exercise 6 - Make a scatter plot and using the function title or mtext, add a title in the
#top right corner and a subtitle in the bottom left corner. Besides that, using axis function add y axis
#on the left side and a x axis at the top with intervals of 1.5. Finally, using text function add the label
#individual data (the different letters) for each point in red


## grid function
#Add a grid 
plot(x, y, pch = 16)
grid()

## legend function
#Add a legend in the position that you want
plot(x, y, col = "white")
legend("top", title="Top", c("A"), col = "red", pch = 16)
legend("center", title="Center", c("A"), col = "red", pch = 16)
legend("bottom", title="Bottom", c("A"), col = "red", pch = 16)
legend("topright", title="Top right", c("A"), col = "red", pch = 16)
legend("bottomright", title="Bottom right", c("A"), col = "red", pch = 16)
legend("right", title="Right", c("A"), col = "red", pch = 16)
legend("topleft", title="Top left", c("A"), col = "red", pch = 16)
legend("left", title="Left", c("A"), col = "red", pch = 16)
legend("bottomleft", title="Bottom left", c("A"), col = "red", pch = 16)

## Add a line

plot(x, y, pch=16)
lines(x[1:5], y[1:5])

#Add a line 
regressionLine<-lm(y ~ x) #fit linear model
abline(regressionLine, col = "blue")

#What happen when you try to add something before call the plot

##Exercise 7 - Make a scatter plot in which the points have a specific color depending on
#the letter associated and add a legend that shows which color corresponds to each letter - 5 min


## 8. Save my plot ##
#You can save your plot in several formats, but following the same structure
pdf("rplot.pdf")          # pdf file
png("rplot.png")          # png file
jpeg("rplot.jpg")         # jpeg file
postscript("rplot.ps")    # postscript file
bmp("rplot.bmp")          # bmp file
win.metafile("rplot.wmf") # windows metafile

#Open the file
pdf("myPlot.pdf") 

#create the plot
plot(xyDataframe$x, xyDataframe$y, pch = 16, col = c("coral1","cyan4", "darkgoldenrod2", "grey"),
     xlab = "X", ylab = "Y", main = "My plot")

legend("bottomright", c("A","B", "C", "D"),
       col = c("coral1","cyan4", "darkgoldenrod2", "grey"), pch= 16)

#close the file
dev.off()


## 9. More options to plot ##

# Pie plot
barplotData <- data.frame(letter = c("A", "B", "C"), value = c(25, 25, 50))
pie(barplotData$value, labels = barplotData$letter)

# Histogram
hist(x)

# Scatter plot
library("car")
scatterplot(y ~ x, data = xyMatrix)

# 3D scatter plot
library(scatterplot3d)
scatterplot3d(x, y, y, pch = 16)

