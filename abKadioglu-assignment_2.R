
# load all required packages
library(languageR)
library(magrittr)
library(tidyverse)
# create a vector called 'p' with the values 0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9 (use seq())
p <- seq(0.1, 0.9, by = 0.1)
# create a vector called 'q' from p, by multiplying it by 3 
q <- p*3
# create a vector called 'r' from q, by adding 5 to it
r <- p+5
# create a data.frame called df, with three columns which correspond to the vectors p, q, r (use data.frame())
df <- data.frame(p, q, r)
# print the first three rows of df
head(df, 3)
## Run the line below to estimate the parameters of a linear model with r as dependent variable, and p as predictor.
## The last two lines of the output below show the estimated value of the intercept, and of the slope for p (when p is used as a predictor)  
lm (r ~ p, data = df)

# What do the intercept and slope estimates tell us about the relationship between r and p?

##### The intercept is 5, so we can measure the value of dependent variable at 5. The slope being 1 shows that
##### p and r increase in same proportions. 

# Does the mathematical relationship between p and r have anything to do with how we created the vectors q and r? 

##### Well, I don't understand the question very well but the relative relationships of q and r differ in that
##### the former works by multiplication so the distance btw the dependent variable and the predictor widens 
##### in each step.

# What will happen to the estimates of the linear model above if we added 1 to all elements of vector r?

##### Intercept would be 6. Slope would remain the same.

## Moving on ...

# load the 'dative' data.frame from the package 'languageR'

data("dative")
head(dative)

# determine the number of occurences of each verb in the dataset (use group_by() and summarize())

verb_occ <- dative %>% group_by(Verb) %>% 
  dplyr::summarize(Verb_count = length(Verb))

# which verb occurs 207 times? (use subset() or filter() on the previously created data frame)

filter(verb_occ, Verb_count == 207)

## in several steps, determine which verb co-occurs with the longest theme argument
# step 1: using group_by()/summarize() and max(), create a data.frame called 'theme_max_themelen_by_verb' which contains 
#         the longest LengthOfTheme value for each verb. Call the column containing the maximum of LengthOfTheme max_LengthOfTheme.

theme_max_themelen_by_verb <- dative %>% group_by(Verb) %>% 
  dplyr::summarise(max_LengthOfTheme = max(LengthOfTheme))

# step 2: take a subset of theme_max_len_by_verb
subset(theme_max_themelen_by_verb, max_LengthOfTheme == max(max_LengthOfTheme))

## Bonus question: Why does the code a produce a different result than the code under the previous comment?
## Hint: It has to do with the difference between '=' and '=='.

##### In the previous code, we are defining a column with a name and a function. In the
##### last code we are asking for the result of a logical command.

# plot a histogram of maximum theme lengths by verb (use geom_histogram())

theme_max_themelen_by_verb %>% ggplot(aes(y = max_LengthOfTheme, x = Verb)) + geom_histogram(stat = "identity", binwidth = 1)

# plot another histogram of maximum theme lengths by verb, but this time with the parameter "binwidth = 10" to geom_histogram()

# let's plot the same again, but this time with the parameter "binwidth = 30" to geom_histogram()

# let's plot the same again, but this time with the parameter "binwidth = 1" to geom_histogram()

## Why do the four above histograms look so different?

#### I seem to have a problem with RStudio, when I try to change bins a warning message reads: "Warning: Ignoring unknown parameters: binwidth, bins, pad"

# Repeat the above aggregation by Verb, but this time include the verb's semantic class in the grouping (use group_by(Verb, SemanticClass)).
# Save the result in 'theme_max_themelen_by_verb'

theme_max_themelen_by_verb2 <- dative %>% group_by(Verb, SemanticClass) %>%
  dplyr::summarise(max_LengthOfTheme = max(LengthOfTheme))

## Compare theme_max_themelen_by_verb and theme_max_themelen_by_verb2. How do they differ?

##### We can see the maximum theme length for each semantic class now.

# create a boxplot of maximum theme lengths by the verb's semantic class (i.e., the semantic class goes on the x-axis, and the theme length
# on the y-axis). (use geom_boxplot()) 

theme_max_themelen_by_verb2 %>% ggplot(aes(x = SemanticClass, y = max_LengthOfTheme)) + geom_boxplot()

## By looking at the above plot, please answer the following question:
# What can we say about the median of theme length in the semantic class 'p' compared to the other semantic classes?

##### It's almost twice the size of other semantic classes' medians.

# Please verify this statement by computing the medians of maximum theme length for every semantic class (use group_by(), summarize(), and median())

medians <- theme_max_themelen_by_verb2 %>% 
  group_by(SemanticClass) %>% 
  dplyr::summarize(Median = median(max_LengthOfTheme))
