## Intro to ggplot2 -- OSOS August 2024
# AMAZING PLOTTING WALKTHROUGH #

##### Objectives #####
#1. Install and load ggplot2
#2. Discuss basics of ggplot2 syntax
#3. Build a plot
#4. Save the graphic as a file

#### Install and Load ggplot2 ####

install.packages("ggplot2")
library(ggplot2)

#### Discuss the basics of ggplot syntax ####

# ggplot allows us to make more complicated graphics
# by using a "grammar of layered graphics"

## What's in a ggplot graphic? ##
# 1. data: the data set containing variables you want to visualize
# 2. mapping: how variables in the data set are represented
  # with different visual "aesthetics" -- position, size, shape, 
#3. geom: geometric objects used to represent those "aesthetics
    # the types of geometric object you use determines
    # the types of aesthetics that are available to map to.
  # geom_point(): points
  # geom_boxplot(): boxplots
  # etc. etc.
#4. scaling: how values of variables are translated to aesthetics
#5. faceting: represent different subsets of data with different subplots

## How do I build one? ##
# the "basic ingredients" above give us a nice workflow for building
# 1. specify the data using ggplot()
# 2. add aesthetic mapping using "mapping = aes()" argument
  # inside the ggplot() function. You can also specify these
  # mappings for individual geom_layers (we will come back to this)
# 3. Define the geometric objects we'd like to represent these mappings
# 4. Add any additional plot elements by laying additional geom_()
  # functions. (Layering!!)
# 5. Define scaling of any variables (as needed) i.e. scaling colors
# 6. Make non-data adjustments ("tweaking appearance")
# 7. Faceting -- replicate the graphic across any additional
  # subsets of data as needed.

#### Build a plot step-by-step ####

install.packages("palmerpenguins")
library(palmerpenguins)

penguins #data is a tibble -> which is part of a tidyverse dataframe in R
#convert this to a dataframe
penguins_df = as.data.frame(penguins)
head(penguins_df)

## Deciding what to plot ##
names(penguins_df)

# let's plot flipper length on the x-axis
# let's plot body mass on the y-axis
# we will eventually look at how this relationship b/w
# flipper length and body mass differs between
# male and female penguins

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g)) +
  geom_point() #have to specify which geom_ object type to plot

# now separate by sex
names(penguins_df) #double check for spelling and capitalization (this lists features)

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     color = sex)) +
  geom_point()

## Scaling variables ##

# the way that variables are mapped to aesthetics is
# controlled with the "scale_()" functions

colors()

scale_color_manual("slategray")
# you can also specify colors using rgb() function
rgb(0.1, 0.2, 0.5)
# you can also use hex codes

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     color = sex)) +
  geom_point() +
  scale_color_manual(values = c("slategray","skyblue", "lightblue"))

# built in R color palettes we can use
# HSV colors, HCL colors
hcl.pals() # what palettes are available?
# now pick 2 colors from a palette of choice
hcl.colors(palette = "Dynamic",
           n = 2)

# now add this into the code for colors
ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     color = sex)) +
  geom_point() +
  scale_color_manual(values = hcl.colors(palette = "TealRose",
             n = 2))

## super important transition for greyscale / publication purposes ##
# use different shapes!

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     shape = sex)) +
  geom_point()

# default shapes are circles and triangles
# to change this - use a scale_shape_manual()

?pch #add points to a plot walk through

## now try with the pch funciton ##

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     shape = sex)) +
  geom_point() +
  scale_shape_manual(values = c(2,8))

## now add color classified by island

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     shape = sex,
                     color = island)) +
  geom_point() +
  scale_shape_manual(values = c(2,8))

## Fine tuning ##

# let's change our axis labels

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     shape = sex,
                     color = island)) +
  geom_point() +
  scale_shape_manual(values = c(2,8)) +
  ylab("Body mass (g)") +
  xlab("Flipper length (9mm)")

# Legends
# modify within the scale_ functions

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     shape = sex,
                     color = island)) +
  geom_point() +
  scale_shape_manual(values = c(2,8),
                     breaks = c("female",
                                "male")) +
  ylab("Body mass (g)") +
  xlab("Flipper length (9mm)")

### Save file
getwd() #make sure cwd is correct before saving!
# use the function ggsave()
# by default, ggsave will save the last
# ggplot() object you *viewed*
ggsave("TestFigure.pdf",
       dpi = 300,
       width = 4,
       height = 4,
       units = "in")

# How to plot using basic plotting techniques -- not ggplot related #
x <- penguins_df$flipper_length_mm
y <- penguins_df$body_mass_g
plot(x,y)
plot(x,y, main = "Penguin Information", cex.main = 4, font.main = 2,
     xlab = "Flipper length (9mm)",
     ylab = "Body mass (g)", cex.lab = 2,
     cex.axis = 1, font.axis = 4, family = "serif")
