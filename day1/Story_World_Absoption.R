# Story_World_Absoption

# install new package
install.packages("reshape2")

# load packages
library(tidyverse)
library(reshape2)

# 1. Read the data (into a dataframe)
SWAS_1 <- read.csv("data/Story_Word_Absorption/Network_lines.csv", header = T, row.names = 1)

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
SWAS_2 <- read.csv("data/Story_Word_Absorption/Empty_grave.csv", header = T, row.names = 1)

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

# 3. compare single items in the two stories

# define the item you want to analyze
my_item <- "A1"

# isolate it in the two stories
item_story_1 <- SWAS_1 %>% select(all_of(my_item)) %>% unlist()
item_story_2 <- SWAS_2 %>% select(all_of(my_item)) %>% unlist()

# run descriptive statistics
summary(item_story_1)
hist(item_story_1)
shapiro.test(item_story_1)
# if p-value of Shapiro-Wilk normality test is < 0.05, then data is not normally distributed

summary(item_story_2)
hist(item_story_2)
shapiro.test(item_story_2)
# if p-value of Shapiro-Wilk normality test is < 0.05, then data is not normally distributed

# to get an overview of the distribution, let's join the two series
shapiro.test(c(item_story_1, item_story_2))

# as data is not normally distributed, a comparison between the two series should be done using Wilcoxon test
wilcox.test(item_story_1, item_story_2, paired = T, alternative = "less") 
# note 1: paired is true because we are comparing reactions by the same student to two different stories (should be false if comparing two groups of unrelated measurements)
# note 2: alternative is "less" because we want to test if item_story_1 is significantly less than item_story_2 (this because we know that mean and median are lower). If item_story_1 were higher, we should have used alternative = "greater"
# interpretation of the result: if p-value of Wilcoxon test is < 0.05, then the first series of answers (for story_1) has significantly lower values than the second series of answers (for story_2)

# note: if data were normally distributed, then you should have run a t-test
t.test(item_story_1, item_story_2, paired = T, alternative = "less")

### Your turn!
# find an item for which there is a significant difference

# 4. Alternative approach. Work on all items in a dimension

# define the item you want to analyze
my_item <- paste("T", 1:5, sep = "")
my_item

# isolate it in the two stories
item_story_1 <- SWAS_1 %>% select(all_of(my_item)) %>% unlist()
item_story_2 <- SWAS_2 %>% select(all_of(my_item)) %>% unlist()

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
wilcox.test(item_story_1, item_story_2, paired = T, alternative = "less")
# interpretation of the result: if p-value of Wilcoxon test is < 0.05, then the first series of answers (for story_1) has significantly lower values than the second series of answers (for story_2)
