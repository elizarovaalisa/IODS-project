### Exercise 4 
### Data wrangling
###
### Alisa Elizarova

# 1 : read datasets
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# 2: explore
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

# 3: rename 

colnames(hd) <- c('HDIrank', 'Country', 'HDI', 'ExpLife', 'ExpEdu', 'MeanEdu', 'GNI', 'GNImHDIrank')
# HDI = Human.Development.Index.
# LifeExp = Life.Expectancy.at.Birth
# ExpEdu =  Expected.Years.of.Education
# MeanEdu = Mean.Years.of.Education
# GNI = Gross.National.Income..GNI..per.Capita
# GNImHDIrank = GNI.per.Capita.Rank.Minus.HDI.Rank

colnames(gii) <- c('GIIrank', 'Country', 'GII', 'MMR', 'BirthRate', 'PP', 'SecEduF', 'SecEduM','LabourForceF', 'LabourForceM')
# GII = Gender.Inequality.Index.
# MMR = Maternal.Mortality.Ratio
# BirthRate = Adolescent.Birth.Rate
# PP = Percent.Representation.in.Parliament
# SecEduF = Population.with.Secondary.Education..Female.
# SecEduM = Population.with.Secondary.Education..Male
# LabourForceF = Labour.Force.Participation.Rate..Female.
# LabourForceM = Labour.Force.Participation.Rate..Male.

# Mutate
hd <= as.data.frame(hd)
eduFM <- gii$SecEduF/gii$SecEduM 
labFM <- gii$LabourForceF/gii$LabourForceM
gii <- as.data.frame(gii)
gii <- cbind(gii, eduFM, labFM)

# Join
library(dplyr)
human <- inner_join(hd, gii, by = c("Country"))
write.csv(human, file = 'human.csv')

#####################################
### Exercise 5 - data wrangling #####
#####################################

str(human)
# The data includes information of the population of 195 countries. You can find info about f.ex. HDI, GNI and Birth Rate.

# 1: transform GNI to numeric
library(stringr)
human$GNI <- as.numeric(str_replace(human$GNI, pattern = ',', replace = ''))

# 2: exclude some columns
keep <- c('Country', 'eduFM', 'labFM', 'ExpEdu', 'ExpLife', 'GNI', 'MMR', 'BirthRate', 'PP')
human <- dplyr::select(human, one_of(keep))
# 3: remove observations with NA
human <- filter(human, complete.cases(human))
# 4: remove observations that relate to regions
human <- human[1:155,]

# rownames
rownames(human) <- human$Country
human <- human[,-1]

write.csv(human, file = 'human.csv', row.names = TRUE)
