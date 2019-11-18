### Exercise 3
### Data wrangling
###
### Alisa Elizarova
### 18.11.2019
### Data was taken from https://archive.ics.uci.edu/ml/datasets/Student+Performance
###


# 3
# Reading data
setwd("/Users/alisaelizarova/Documents/IODS/IODS/data")
s_mat <- read.csv("student-mat.csv", sep = ";" , header=TRUE)
s_por <- read.csv("student-por.csv", sep = ";" , header=TRUE)
str(s_mat)
str(s_por)

# 4
# Using the funtion "inner_join" we are going to join the datasets
library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
mat_por <- inner_join(s_mat, s_por, by = join_by, suffix = c(".math", ".por"))
str(mat_por)

# 5
# b
alc <- select(mat_por, one_of(join_by))
notjoined_columns <- colnames(s_mat)[!colnames(s_mat) %in% join_by]

for(column_name in notjoined_columns) {
  two_columns <- select(mat_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}
str(alc)

# 6
alc <- mutate(alc, alc_use = (Dalc + Walc)/2)
alc <- mutate(alc, high_use = alc_use > 2)

# 7
glimpse(alc)
write.csv(alc, "alc.csv")
