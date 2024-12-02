## Intro to Tidyverse approach to data wrangling in R ##

# tidyverse is a set of R packages that make organizing, cleaning,
# analyzing and visualizing data easier by adopting a shared set
# of standards for how data is presented, and how it is treated.
# Key packages in the tidyverse are dplyr, tidyr, and ggplot2.

#### Objectives ####
#1. Installing and loading tidyverse
#2. Subsetting data and chaining operations with pipes (%>%)
#3. Calculating new variables from existing variables
#4. Summarize data using apply-split-combine approach
#5. Apply statistical analysis "in the pipeline"
#6. Plotting "in the pipeline"
#7. Moving between long- and wide-format data

#### Install and load tidyverse  ####

install.packages("tidyverse") # installing it
library(tidyverse)

#### Subsetting Data using dplyr ####
# dplyr package has lots of functions for subsetting data
# select(), pull(), filter()

# select(data, variable)

# let's grab some data to subset!
install.packages("palmerpenguins") # install it
library(palmerpenguins) # load it into current session
# data are available in an object called penguins
penguins
# this is a tibble.
# tibbles give nice previews, they also behave differently
# compared with standard data.frames

# can we turn this into a regular data.frame?
penguins_df = as.data.frame(penguins)
penguins_df
# what is in here?
str(penguins_df)
# can we see just a preview of a regular data frame?
head(penguins_df)

# Can we get just one variable from a dataset?
# let's try that using select()
select(penguins, body_mass_g)

# let's compare to getting a single variable from
# a data.frame
penguins_df$body_mass_g
# pulling a variable from a data.frame produces
# a vector, not another data.frame
# BUT, select() from a tibble returns another tibble.

# so, what if we *wanted* to get that variable as a vector?
# let's use the pull() function
pull(penguins, body_mass_g)
# great! A vector! asked for by name.

# can we select() multiple variables at once?
names(penguins)
select(penguins, body_mass_g, sex)
# we sure can!

# can we filter the data for observations (rows)
# that meet some criterion (i.e., value of a variable)
# let's try to get only females

# There are 3 ways we could do this.
# 1. Intermediate Steps
bodyMassDat = select(penguins, body_mass_g, sex)
filter(bodyMassDat, sex == "female")
# we can use lots of different logical operators for filtering
# less than (<), less than equal to (<=), is.na(), etc...

# 2. Nested steps
filter(select(penguins, body_mass_g, sex), sex == "female")
# little nicer, we only have one line of code
# BUT, have to read "inside-out" which is tough.

#3. Piping %>%
# pipes forward the output of an operation to the next function
# We don't have to specify the data set again for the 
# "downstream" function
select(penguins, body_mass_g, sex) %>%
  filter(sex == "female")
# that's pretty *tidy*

# filter according to multiple criteria at the same time
select(penguins, body_mass_g, sex) %>%
  filter(sex == "female" & island == "Torgersen")
# BE CAREFUL! Any variables used downstream must be included
# in upstream operations
# modify our select() function to include island
select(penguins, body_mass_g, sex, island) %>%
  filter(sex == "female" & island == "Torgersen")

#### Calculating new variables using mutate() ####

# Let's calculate a measure of penguin body condition
# Penguin Plumpness Index = body mass / flipper length
# we can do this in our pipeline using mutate()

mutate(penguins,
       pengPlumpInd = body_mass_g / flipper_length_mm) %>%
pull(pengPlumpInd)

# let's use mutate() after a filter function to get rid
# of any observations where sex is not known

filter(penguins, !is.na(sex)) %>%
  mutate(pengPlumpInd = body_mass_g/flipper_length_mm) %>%
  pull(pengPlumpInd)


#### Summarizing with split-apply-combine approach ####
# quickly summarize data using two key functions:
# group_by(): groups observations in your tibble by values of a variable
# summarize(): calculates summary statistics for groups
              # makes a tibble with one row for each group
              # and one column for each summary statistic

filter(penguins, !is.na(sex)) %>%
  group_by(sex)
# this doesn't really change appearance, but does
# change how the tibble interacts with downstream functions

# you can group by multiple variables at the same time
filter(penguins, !is.na(sex)) %>%
  group_by(sex, island)

# now that we've grouped, let's calculate summary stats
# for each group
# use the summarize(data,
#.                  SummaryVariableName = how its calculated)

filter(penguins, !is.na(sex)) %>%
  group_by(sex) %>%
  summarize(meanBodyMassg = mean(body_mass_g))

# add a summary of variation
filter(penguins, !is.na(sex)) %>%
  group_by(sex) %>%
  summarize(meanBodyMassg = mean(body_mass_g),
            sdBodyMassg = sd(body_mass_g))

# calculate a coefficient of variation in body mass
# CV = mean / sd
# can actually do this in the same summarize()
# if we are mindful of order

filter(penguins, !is.na(sex)) %>%
  group_by(sex) %>%
  summarize(meanBodyMassg = mean(body_mass_g),
            sdBodyMassg = sd(body_mass_g),
            CVBodyMassg = meanBodyMassg/sdBodyMassg)
# so we can kind of sneak a mutate() into a summarize()

# Let's take this to its logical extreme
filter(penguins, !is.na(sex)) %>%
  group_by(species, island, sex) %>%
  summarize(meanBodyMassg = mean(body_mass_g),
            sdBodyMassg = sd(body_mass_g),
            CVBodyMassg = meanBodyMassg/sdBodyMassg,
            sampleSize = n())
# however, it's kind of hard to take away a main message
# Can we sort these summary data?
filter(penguins, !is.na(sex)) %>%
  group_by(species, island, sex) %>%
  summarize(meanBodyMassg = mean(body_mass_g),
            sdBodyMassg = sd(body_mass_g),
            CVBodyMassg = meanBodyMassg/sdBodyMassg,
            sampleSize = n()) %>%
  arrange(desc(meanBodyMassg))

#### Stats ####
# you can "pipe" into a statistical analysis
# Let's fit a lm() where body mass is a response
# and species, sex, and their interaction are predictor

filter(penguins, !is.na(sex)) %>%
  lm(formula = body_mass_g ~ species + sex + species:sex) %>%
  anova()

#### Plots ####
# can we in fact pipe into a plot?
# we'll use ggplot2 in this example

filter(penguins, !is.na(sex)) %>%
  ggplot(mapping = aes(x = species,
                       y = body_mass_g,
                       color = sex)) +
  geom_boxplot()

### Wide and long formats ####
filter(penguins, !is.na(sex)) %>%
  group_by(species, island, sex) %>%
  summarize(meanBodyMassg = mean(body_mass_g),
            sdBodyMassg = sd(body_mass_g),
            CVBodyMassg = meanBodyMassg/sdBodyMassg,
            sampleSize = n()) %>%
  arrange(desc(meanBodyMassg))

# pivot_wider(data, names_from, values_from)
filter(penguins, !is.na(sex)) %>%
  group_by(species, island, sex) %>%
  summarize(meanBodyMassg = mean(body_mass_g),
            sdBodyMassg = sd(body_mass_g),
            CVBodyMassg = meanBodyMassg/sdBodyMassg,
            sampleSize = n()) %>%
  arrange(desc(meanBodyMassg)) %>%
  pivot_wider(names_from = island, values_from = meanBodyMassg) %>%
  pivot_longer(cols = c("Biscoe", "Dream", "Torgersen"),
               names_to = "island",
               values_to = "meanBodyMassg")
