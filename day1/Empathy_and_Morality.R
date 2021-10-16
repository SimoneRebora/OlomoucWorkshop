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

# # prepare data for visualization
# SWAS_melt <- melt(t(SWAS_1))
# colnames(SWAS_melt) <- c("SWAS_item", "user", "value")
# my_plot <- ggplot(SWAS_melt, aes(x=SWAS_item, y=value)) +
#   ggtitle(paste("In a network of lines that intersect", "- Readers:", length(SWAS_1$A1))) +
#   geom_hline(yintercept=0, linetype="dotted") +
#   geom_boxplot()
# 
# # visualize data
# my_plot
# 
# # save to file
# ggsave(my_plot, filename = "story_1.png", scale = 2)

# 2. Read the data (into a dataframe) for story 2
bad <- read.csv("data/Empathy_and_Morality/Bad.csv", header = T, row.names = 1)

bad$morality <- NULL
colnames(bad)[2] <- "morality"
bad$student <- paste("student", 1:length(bad$student))
bad <- bad[,-(3:11)]
bad <- bad[,-18]

# # prepare data for visualization
# SWAS_melt <- melt(t(SWAS_2))
# colnames(SWAS_melt) <- c("SWAS_item", "user", "value")
# my_plot <- ggplot(SWAS_melt, aes(x=SWAS_item, y=value)) +
#   ggtitle(paste("Around an empty grave", "- Readers:", length(SWAS_2$A1))) +
#   geom_hline(yintercept=0, linetype="dotted") +
#   geom_boxplot()
# 
# # visualize data
# my_plot
# 
# # save to file
# ggsave(my_plot, filename = "story_2.png", scale = 2)




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

for(my_item in paste("Q", 12:26, sep = "")){
  print(my_item)
  print(cor.test(c(good$morality, bad$morality), c(good %>% select(all_of(my_item)) %>% unlist(), bad %>% select(all_of(my_item)) %>% unlist())))
}

my_item <- c("morality", "Q13")

# isolate it in the two stories
good_sel <- good %>% select(all_of(my_item))
bad_sel <- bad %>% select(all_of(my_item))

good_sel <- melt(good)
good_sel$condition <- "good" 

bad_sel <- melt(bad)
bad_sel$condition <- "bad" 

good_bad <- rbind(good_sel, bad_sel)

my_plot <- ggplot(good_bad, aes(x=condition, y=value)) +
  geom_boxplot() +
  facet_wrap(vars(variable))

# visualize data
my_plot

my_item <- "Q13"
plot(x = c(good$morality, bad$morality), y = c(good %>% select(all_of(my_item)) %>% unlist(), bad %>% select(all_of(my_item)) %>% unlist()))


my_item <- c("student", "morality", "Q13")

good_sel <- good %>% select(all_of(my_item))
good_sel$condition <- "good" 
bad_sel <- bad %>% select(all_of(my_item))
bad_sel$condition <- "bad" 

good_bad <- rbind(good_sel, bad_sel)

colnames(good_bad)[3] <- "empathy"
good_bad$student <- paste("student", 1:length(good_bad$student))

write.csv(good_bad, file = "data/Empathy_and_Morality/v1.csv", row.names = F)

good <- 


good_bad <- read.csv("data/Empathy_and_Morality/v1.csv")


good_bad_melt <- melt(good_bad)

my_plot <- ggplot(good_bad_melt, aes(x=condition, y=value)) +
  geom_boxplot() +
  facet_wrap(vars(variable))

# visualize data
my_plot


# isolate it in the two stories
morality_good <- good_bad %>% 
  filter(condition == "good") %>% 
  select(all_of("morality")) %>% 
  unlist()

morality_bad <- good_bad %>% 
  filter(condition == "bad") %>% 
  select(all_of("morality")) %>% 
  unlist()

shapiro.test(c(morality_bad, morality_good))
# if p-value of Shapiro-Wilk normality test is < 0.05, then data is not normally distributed
  
# as data is not normally distributed, a comparison between the two series should be done using Wilcoxon test
wilcox.test(morality_bad, morality_good, paired = F)



# isolate it in the two stories
empathy_good <- good_bad %>% 
  filter(condition == "good") %>% 
  select(all_of("empathy")) %>% 
  unlist()

empathy_bad <- good_bad %>% 
  filter(condition == "bad") %>% 
  select(all_of("empathy")) %>% 
  unlist()

shapiro.test(c(empathy_bad, empathy_good))
# if p-value of Shapiro-Wilk normality test is < 0.05, then data is not normally distributed

# as data is not normally distributed, a comparison between the two series should be done using Wilcoxon test
wilcox.test(empathy_bad, empathy_good, paired = F, alternative = "less")


my_plot <- ggplot(good_bad, aes(x = morality, y = empathy)) +
  geom_count() +
  geom_smooth(method = 'lm')

my_plot

cor.test(good_bad$morality, good_bad$empathy)
