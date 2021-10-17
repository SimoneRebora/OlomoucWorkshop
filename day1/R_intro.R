### Welcome!

# This is an R script file, created by Simone
# Everything written after an hashtag is a comment
# Everything else is R code
# To activate the code, place the cursor on the corresponding line and press Ctrl+Enter
# (the command will be automatically copy/pasted into the console)

### 1. Creating variables

# numbers
my_number <- 1
my_number

# strings of text
my_string <- "to be or not to be"
my_string

# vectors
my_first_vector <- c(1,2,3,4,5)
my_first_vector

# tip: you can get the same by writing
my_first_vector <- 1:5
my_first_vector

# vectors (of strings)
my_second_vector <- c("to", "be", "or", "not", "to", "be")
my_second_vector

# lists
my_list <- list(1:5, c("to", "be", "or", "not", "to", "be"))
my_list

# tip: you can get the same by writing
my_list <- list(my_first_vector, my_second_vector)
my_list

# dataframes
my_df <- data.frame(author = c("Shakespeare", "Dante", "Cervantes", "Pynchon"), nationality = c("English", "Italian", "Spanish", "American"))
View(my_df)

### 2. Accessing variables

# vector subsets
my_first_vector[1]
my_second_vector[1]
my_second_vector[4]
my_second_vector[1:4]
my_second_vector[c(1,4)]

# list subsets
my_list[[1]]
my_list[[1]][4]
my_list[[2]][4]
my_list[[2]][1:3]

# dataframes
my_df$author 
my_df[,1] # the same!!
my_df$nationality
my_df[,2] # the same!!
my_df$author[1:3]
my_df[1:3,1] # the same!!
my_df[1,]
my_df[3,]

# accessing variables in a meaningful way
my_df$author == "Dante"
which(my_df$author == "Dante")
my_df$nationality[which(my_df$author == "Dante")]

### 3. Manipulating variables
my_first_vector+1
my_first_vector[2]+1
my_second_vector+1 # this produces an error!!

# manipulating strings
paste(my_string, "?")
strsplit(my_string, " ")
strsplit(my_string, " ")[[1]]
unlist(strsplit(my_string, " ")) # the same! (in this specific case)

# saving to a new variable (for exploration)
my_third_vector <- unlist(strsplit(my_string, " "))
table(my_third_vector)
sort(table(my_third_vector))
sort(table(my_third_vector), decreasing = T)

### 4. Reading/writing text files

# printing working directory
getwd()
setwd("/cloud/project/corpus") # notice that this can also be done via the RStudio GUI
getwd()
setwd("/cloud/project")

# read text line by line
my_text <- readLines("corpus/Cbronte_Jane_1847.txt")
head(my_text)

# collapse all text in a single line (separated by the "newline" character)
my_text <- paste(my_text, collapse = "\n")

# write file
cat("The cat is on the table")
cat("The cat is on the table", file = "Cat.txt")

### 5. Making loops

# basic loop
for(i in 1:10){
  print(i)
}

# if conditions
for(i in 1:10){
  if(i == 1){
    print(i)
  }
}

# if/else conditions
for(i in 1:10){
  if(i == 1){
    print(i)
  }else{
    print("more than one")
  }
}

# the sapply/lapply functions
# (with a simple example: increase the values in one vector)
my_vector <- 1:10
my_vector
for(i in 1:10){
  
  my_vector[i] <- my_vector[i]+1
  
}
my_vector

# it is the same of this sapply function:
my_vector <- 1:10
my_vector <- sapply(my_vector, function(x) x+1)
my_vector

# if you are working with lists, then you can use lapply
my_list <- list(1:10, 2:20)
my_list <- lapply(my_list, function(x) x+1)
my_list

# why use sapply/lapply? Because they are faster than a loop

### 6. Functions

# basic (stupid) example
my_function <- function(){
  cat("Ciao")
}

my_function()

### 7. Packages

# install (this should be done just once)
install.packages("tidyverse")

# load (this should be done every time you start R!)
library(tidyverse)
# more efficient ways to manage dataframes

# for example: find the Italian author in our dataframe of authors
# with base R, you should do like that
my_df[which(my_df$nationality == "Italian"),]

# with tidyverse, you do like
my_df %>% filter(nationality == "Italian")

### Appendix
# note: the "<-" sign can be substitited by "="
my_variable <- "Shakespeare"
my_variable = "Shakespeare"
# still, it is advised to distinguish between the two, as the "<-" sign has a "stronger" function. See for example in the creation of a dataframe
my_df <- data.frame(author = c("Shakespeare", "Dante", "Cervantes", "Pynchon"), nationality = c("English", "Italian", "Spanish", "American"))
author # it does not exist!!

my_df_2 <- data.frame(author <- c("Shakespeare", "Dante", "Cervantes", "Pynchon"), nationality <- c("English", "Italian", "Spanish", "American"))
author # now it exists!!

# for more details (and discussion): https://stackoverflow.com/questions/1741820/what-are-the-differences-between-and-assignment-operators-in-r 