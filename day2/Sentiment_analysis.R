# Sentiment_analysis

install.packages("syuzhet")
library(syuzhet) # you will have to do it every time you restart R

# 1. read a text in the folder
# to read another text in the "corpus" folder, you have to change the title
# tip: you can help yourself by using the "Tab" key (autocomplete)
text <- readLines("corpus/Doyle_Study_1887.txt") 
# you might get a warning here (please disregard it!)

# as warnings in readLines are generally useless (and annoying), you might want to disable them
text <- readLines("corpus/Doyle_Study_1887.txt", warn = F)

# R reads the text line by line. To simplify Syuzhet's work, let's collapse it in a single string
text <- paste(text, collapse = "\n")

# here Syuzhet comes into action: it splits the text into sentences
sentences_vector <- get_sentences(text)

# ...and calulates the sentiment for each sentence
syuzhet_vector <- get_sentiment(sentences_vector, method="syuzhet")

# let's visualize the results
syuzhet_vector

# put them in a graph
plot(
  syuzhet_vector, 
  type="l", 
  main="Sentiment Arc", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence"
)

# ...it is still too noisy: we'll need to use some filters
simple_plot(syuzhet_vector, title = "Sentiment arc")

# we can save the plot as a png file
png("my_simple_plot.png", height = 900, width = 1600, res = 100)
simple_plot(syuzhet_vector, title = "Sentiment arc")
dev.off()

# we can also look at the basic emotions (Plutchik)
syuzhet_emotions <- get_nrc_sentiment(sentences_vector)

# and visualize the result (in a matrix)
View(syuzhet_emotions)

# to have an overview, we can calculate the mean for each emotion (i.e. the columns of the matrix)
colMeans(syuzhet_emotions)

# 2. Opening the Syuzhet box

# download the sentiment dictionaries included in Syuzhet
download.file("https://github.com/mjockers/syuzhet/raw/master/R/sysdata.rda", destfile = "syuzhet_dict.RData")
load("syuzhet_dict.RData")

# let's explore them!
View(afinn)
View(syuzhet_dict)
# etc.

# let's test syuzhet on tough sentences
my_sentence <- "Well, he was like a potato!"
get_sentiment(my_sentence, method="syuzhet")
get_sentiment(my_sentence, method="afinn")

# give me one sentence!
my_sentence <- "..."
get_sentiment(my_sentence, method="syuzhet")
get_sentiment(my_sentence, method="afinn")

### Your turn!!
# Suggested activities: 
# 1. Run the same analyses on a different text from the "corpus" folder
# 2. Try out syuzhet on tougher sentences