## Intro to ggplot2 -- OSOS 2024, 24 Aug 2024

##### Objectives ####
#1.Install and load ggplot2
#2.Discuss basics of ggplot2 syntax
#3.Build a plot
#4.Save the graphic as a file

#### Install and Load ggplot2 ####

install.packages("ggplot2")
library(ggplot2)

#### Discuss the basics of ggplot syntax ####

# ggplot allows us to make more complicated graphics
# by using a "grammar of layered graphics"

## What's in a ggplot graphic? ##
# 1. data: the dataset containing variables you want to visualize
# 2. mapping: how variables in the dataset are represented
    # with different visual "aesthetics" -- position, size, shape, etc.
# 3. geom: geometric objects used to represent those "aesthetics"
        # the type of geometric object you use determines
        # the types of aesthetics that are available to map to.
      # geom_point(): points
      # geom_boxplot(): boxplots...
      # etc. etc.
# 4. scaling: how values of variables are translated to aesthetics
# 5. faceting: represent different subsets of data with different
      # subplots

## How do I build one? ##
# the "basic ingredients" above give us a nice workflow for building one
# 1. specify the data using ggplot()
# 2. add aesthetic mapping using the "mapping = aes()" argument
    # inside the ggplot() function. You can also specify these
    # mappings for individual geom_ layers (we will come back to this)
# 3. Define the geometric objects we'd like to represent these mappings
# 4. Add any additional plot element by layering additional geom_()
    # functions. (Layering!!)
# 5. Define scaling of any variables (as needed)
# 6. Make non-data adjustments ("tweaking appearance")
# 7. Faceting -- replicate the graphic across any additional
    # subsets of data as needed.

#### Build a plot step-by-step ####

install.packages("palmerpenguins")
library(palmerpenguins)

penguins
# convert this "tibble" to a dataframe to formally break
# ties with the rest of the "tidyverse"
penguins_df = as.data.frame(penguins)
head(penguins_df)
# great, this looks all good.

## Deciding what to plot ##
names(penguins_df)

# let's plot flipper length on the x-axis
# let's plot body mass on the y-axis
# we will eventually look at how this relationship b/w
# flipper length and body mass differs between 
# male and female penguins

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g))

# Ah, let's tell it what kind of geom_ to use!

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g)) +
  geom_point()


# BUT, we want to see data for males and females separately!
# We can do this by adding another aesthetic mapping
# Let's map "sex" variable to point color

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                      y = body_mass_g,
                      color = sex)) +
  geom_point()

# That's nice, but I don't like those colors much
# Can we pick our own colors?
# Yes! with scaling.

## Scaling variables ##

# The way taht variables are mapped to aesthetics is
# controlled by the "scale_()" functions
# This gets deep preetty quickly

# Let's use scale_color_manual()
# BUT first, what colors can we specify?
colors()
# you can also specify colors using rgb() function
rgb(0.1, 0.2, 0.5)
# you can also use hex codes

# let's remake the plot, specify our own colors,
# and I'm going to do this using rgb() and colors()

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     color = sex)) +
  geom_point() +
  scale_color_manual(values = c("peachpuff4",
                                rgb(0.1, 0.2, 0.5)))
## or using hex codes...
ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     color = sex)) +
  geom_point() +
  scale_color_manual(values = c("peachpuff4",
                                "#1A3380"))

# built in R color palettes we can use
# HSV colors, HCL colors (I don't have a preference)
hcl.pals() # what palettes are available?
# now pick 2 colors from a palette of choice
hcl.colors(palette = "Broc",
           n = 2)

# put this color picking function inside our scale_
# function

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     color = sex)) +
  geom_point() +
  scale_color_manual(values = hcl.colors(palette = "Harmonic",
                                         n = 2))
# Nice!

## If we have to print in greyscale, might want to map sex
## to different shapes of points instead of colors

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     shape = sex)) +
  geom_point()

# What if we don't like those shapes?
# we'll use a scale_shape_manual()
ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     shape = sex)) +
  geom_point() +
  scale_shape_manual(values = c(2, 1))

## We can map lots of things at the same time
# let's add color now as the island of origin

ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     shape = sex,
                     color = island)) +
  geom_point() +
  scale_shape_manual(values = c(2, 1))


## Fine tuning ##

# let's change our axis labels
ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     shape = sex,
                     color = island)) +
  geom_point() +
  scale_shape_manual(values = c(2, 1)) +
  ylab("Body mass (g)") +
  xlab("Flipper length (mm)")

# Legends
# modify within the scale_ functions
ggplot(data = penguins_df,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     shape = sex,
                     color = island)) +
  geom_point() +
  scale_shape_manual(values = c(2, 1),
                     breaks = c("female",
                                "male")) +
  ylab("Body mass (g)") +
  xlab("Flipper length (mm)")


### We're out of time, so let's save this to a file
# use the function ggsave()
# by default, ggsave will save the last 
# ggplot() object you *viewed*
ggsave("TestFigure.pdf",
       dpi = 300,
       width = 4,
       height = 4,
       units = "in")
