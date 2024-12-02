
#Exercise 1 - Make a plot using x and y vectors with overplotted points and lines 
#points are intersected by lines) - 2 min
plot(x, y, type = "o")


#Exercise 2 - Make a plot using x and y vectors with the following characteristics: 
# Title: "My plot", size = 4,  font style = bold
# Axis labels: "My x label" for x axis, "My y label" for y axis, size = 2, font style = bold italic
# Axis size = 1
# Family font = AvantGarde
plot(x, y, main = "My plot", xlab = "My x label", ylab = "My y label", font.main = 2,
     cex.main = 4, cex.lab = 2, cex.axis = 1, font.lab = 4, family = "serif")

#Exercise 3 - Make a plot using x and y vectors, where  the axes are in a vertical position, and 
#remove y tick labels - 2 min
plot(x, y, las = 3, yaxt = "n")


#Exercise 4 - Make a plot using x and y vectors without box - 2 min
plot(x, y, bty = "n")  


#Exercise 5 - Make a plot using x and y vectors in which the points are represented by filled diamonds
##with a size of 1.5, with pink background, a green line border, and a width of 2 - 2 min
plot(x, y, pch = 23, cex = 1.5, lwd = 2, bg = "#F770BC", col = "#69D18B")


#Exercise 6 - Make a plot using x and y vector and using the function title or mtext, add a title in the
#top right corner and a subtitle in the bottom left corner. Besides that, using axis function add y axis
#on the left side and a x axis at the top with intervals of 1.5. Finally, using text function add the label
#individual data (the different letters) for each point in red - 3 min
plot(x, y, axes = FALSE, xlim = c(-3, 3))
axis(3,  at = seq(-3, 3, 1.5))
axis(2)
title(main = "My title", adj = 1, line = 3)
title(sub = "My subtitle", adj = 0)
text(x, y, labels = xyDataframe$letters, pos = 3, col = "red")

##Exercise 7 - Make a plot using x and y vectors in which the points have a specific color depending on
#the letter associated and add a legend that shows which color corresponds to each letter - 5 min

plot(x,y, pch = 16, col = c("green", "red", "pink", "black" ))
text(x,y, labels = xyDataframe$letters, pos = 3)
#Can we know which color represent each letter?

#Option 1
myColors<-c("coral1", "cyan4", "darkgoldenrod2", "grey")
plot(xyDataframe$x, xyDataframe$y, pch=16, col = myColors[factor(xyDataframe$letters)])

legend("bottomright", c("A","B", "C", "D"),
       col = c("coral1","cyan4", "darkgoldenrod2", "grey"), pch= 16)

#Option 2
plot(x, y, pch=16, col = ifelse(xyDataframe$letters == "A","coral1",
                                ifelse(xyDataframe$letters == "B","cyan4",
                                       ifelse(xyDataframe$letters ==  "C", "darkgoldenrod2", "grey"))))
legend("bottomright", c("A","B", "C", "D"),
       col = c("coral1","cyan4", "darkgoldenrod2", "grey"), pch= 16)

