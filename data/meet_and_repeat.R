#####################
### Exercise 6 ######
### Data wrangling ##
#####################
### Alisa Elizarova #
#####################

# 1
# Download the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

write.csv(BPRS, "data/BPRS.csv")
write.csv(RATS, "data/RATS.csv")

# Take a look at the data sets
str(BPRS)
glimpse(BPRS)
head(BPRS)
str(RATS)
glimpse(RATS)
head(RATS)

# 2
# Convert the categorical variables of both data sets to factors. 
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# 3 
# Convert the data sets to long form. 
library(dplyr)
library(tidyr)
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
RATSL <-  RATS %>% gather(key = times, value = weight, -ID, -Group)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks,5,5)))
RATSL <-  RATSL %>% mutate(time = as.integer(substr(RATSL$times,3,4)))

write.csv(BPRSL, "data/bprs.csv", row.names = FALSE)
write.csv(RATSL, "data/rats.csv", row.names = FALSE)

# 4
# Explore
head(BPRSL)
head(BPRS)
summary(BPRSL)
head(RATSL)
head(RATS)
summary(RATSL)

# In the wide data, each row contains all observations related to one person/subject. 
# When we convert it to long form, the each row contains only one measurement.
# It means that if in the wide data one subject has 5 measurements and 1 row, in the long data it will have 5 rows. 