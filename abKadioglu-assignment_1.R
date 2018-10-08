
# load the required packages (install them if you don't have them already)
library(languageR)
library(tidyverse)
library(ggplot2)


# create a vector named x by assigning it all numbers between 1 and 25

x <- c(1:25)

# compute the average of this vector

mean(x)

# determine how many elements the vector has

length(x)

# convert this integer vector to a character vector

x <- as.character(x)

# load the 'warlpiri' data.frame from the package 'languageR'

data("warlpiri")  ### library(languageR) (p) data(warlpiri)

# display the first 3 lines of the data.frame

head(warlpiri) ### head(warlpiri, 3)

# look up the meaning of the various columns in the data.frame

?warlpiri

# find out how many rows are in the data.frame

nrow(warlpiri)

# find out which values can occur in the column which indicates the presence of ergative case marking

levels(warlpiri$CaseMarking)   ##unique(warlpiri$CaseMarking)

# determine the overall frequency of ergative case marking in the data set

table(warlpiri$CaseMarking)  #table(warlpiri$CaseMarking, warlpiri$WordOrder)
summary(warlpiri$CaseMarking)


###with(warlpiri, {
###  table(CaseMarking, WordOrder)
###)}


## In *separate commands*, determine the frequency of ergative case marking as a function of the variables listed
## below, and please save the results in the specified data frames. Inspect the data frames with View() to make
## sure that the results makes sense.
# ... (i) word order (save in data frame called 'proportions_by_WO')
### proportions_by_WO <- warlpiri %>% group_by(WordOrder)%>%
 
# ... (ii) overtness of object  (save in data frame called 'proportions_by_ovObject')
# ... (iii) animacy of the object (save in data frame called 'proportions_by_animObj')

dplyr::count(warlpiri, CaseMarking, WordOrder)
proportions_by_WO <- warlpiri %>%  dplyr::select(CaseMarking, WordOrder)
proportions_by_WO <- proportions_by_WO %>% filter(CaseMarking == "ergative")
View(proportions_by_WO)

dplyr::count(warlpiri, CaseMarking, OvertnessOfObject)
proportions_by_ovObject <- warlpiri %>%  dplyr::select(CaseMarking, OvertnessOfObject)
proportions_by_ovObject <- proportions_by_ovObject %>% filter(CaseMarking == "ergative")


dplyr::count(warlpiri, CaseMarking, AnimacyOfObject)
proportions_by_animObj <-  warlpiri %>% dplyr::select(CaseMarking, AnimacyOfObject)
proportions_by_animObj <- proportions_by_animObj %>% filter(CaseMarking == "ergative")

# create plots in ggplot2 (with lines or bars)  from each of the data.frames from the previous step

ggplot(proportions_by_WO, aes(CaseMarking, WordOrder)) + geom_jitter()

ggplot(proportions_by_ovObject, aes(CaseMarking, OvertnessOfObject)) + geom_jitter()

ggplot(proportions_by_animObj, aes(CaseMarking, AnimacyOfObject)) + geom_jitter()

## Respond with a a comment below:
## Does there seem to be a relation between ergative case marking and ...
## ... word order

## ... overtness of the object

## ... animacy of the object

####  Ergative case marking seem more likely to occur in presence of overt objects and in subject initial word
####  order. Animacy of objects affects case marking in that, ergative cases tend to choose animate objects.
####  However, I think that the difference in numbers between animate and inanimate objects are disregardable
####  as the difference is not as big compared to the overtness and subject initiality factors.
