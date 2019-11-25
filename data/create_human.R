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

colnames(hd) <- c('HDIrank', 'Country', 'HDI', 'LifeExp', 'ExpEdu', 'MeanEdu', 'GNI', 'GNImHDIrank')
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
