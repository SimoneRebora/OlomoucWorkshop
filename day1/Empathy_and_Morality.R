# Empathy_and_Morality

library(tidyverse)
library(reshape2)

# 1. Read the data (into a dataframe)
good <- read.csv("data/Empathy_and_Morality/Good.csv", header = T, row.names = 1)

good$morality <- NULL
colnames(good)[2] <- "morality"
good$student <- paste("student", 1:length(good$student))
good <- good[,-(3:11)]
good <- good[,-18]

# prepare data for visualization
SWAS_melt <- melt(t(SWAS_1))
colnames(SWAS_melt) <- c("SWAS_item", "user", "value")
my_plot <- ggplot(SWAS_melt, aes(x=SWAS_item, y=value)) +
  ggtitle(paste("In a network of lines that intersect", "- Readers:", length(SWAS_1$A1))) +
  geom_hline(yintercept=0, linetype="dotted") +
  geom_boxplot()

# visualize data
my_plot

# save to file
ggsave(my_plot, filename = "story_1.png", scale = 2)

# 2. Read the data (into a dataframe) for story 2
bad <- read.csv("data/Empathy_and_Morality/Bad.csv", header = T, row.names = 1)

bad$morality <- NULL
colnames(bad)[2] <- "morality"
bad$student <- paste("student", 1:length(bad$student))
bad <- bad[,-(3:11)]
bad <- bad[,-18]

# prepare data for visualization
SWAS_melt <- melt(t(SWAS_2))
colnames(SWAS_melt) <- c("SWAS_item", "user", "value")
my_plot <- ggplot(SWAS_melt, aes(x=SWAS_item, y=value)) +
  ggtitle(paste("Around an empty grave", "- Readers:", length(SWAS_2$A1))) +
  geom_hline(yintercept=0, linetype="dotted") +
  geom_boxplot()

# visualize data
my_plot

# save to file
ggsave(my_plot, filename = "story_2.png", scale = 2)




for(my_item in c("morality", paste("Q", 12:26, sep = ""))){
  
  # isolate it in the two stories
  item_story_1 <- good %>% select(all_of(my_item)) %>% unlist()
  item_story_2 <- bad %>% select(all_of(my_item)) %>% unlist()
  
  # run descriptive statistics
  summary(item_story_1)
  hist(item_story_1)
  shapiro.test(item_story_1)
  # if p-value of Shapiro-Wilk normality test is < 0.05, then data is not normally distributed
  
  summary(item_story_2)
  hist(item_story_2)
  shapiro.test(item_story_2)
  # if p-value of Shapiro-Wilk normality test is < 0.05, then data is not normally distributed
  
  # as data is not normally distributed, a comparison between the two series should be done using Wilcoxon test
  result <- wilcox.test(item_story_1, item_story_2, paired = F)
  # interpretation of the result: if p-value of Wilcoxon test is < 0.05, then the first series of answers (for story_1) has significantly lower values than the second series of answers (for story_2)
  
  print(my_item)
  print(result$p.value)
  
}
  
cor.test(c(good$morality, bad$morality), c(good$Q13, bad$Q13))
