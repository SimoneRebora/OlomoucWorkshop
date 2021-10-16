# Empathy_and_Morality

library(tidyverse)
library(reshape2)

# 1. Read the data (into a dataframe)
good_bad <- read.csv("data/Empathy_and_Morality/Good_and_bad.csv")

# prepare for visualization
good_bad_melt <- melt(good_bad)

# create plot
my_plot <- ggplot(good_bad_melt, aes(x=condition, y=value)) +
  geom_boxplot() +
  facet_wrap(vars(variable))

# visualize it
my_plot

# 2. Verify the significance of the differences

# 2.1 Morality
# from the dataframe, extract morality for good and bad
morality_good <- good_bad %>% 
  filter(condition == "good") %>% 
  select(all_of("morality")) %>% 
  unlist()

morality_bad <- good_bad %>% 
  filter(condition == "bad") %>% 
  select(all_of("morality")) %>% 
  unlist()

# test normality
shapiro.test(c(morality_bad, morality_good))

# as data is not normally distributed, a comparison between the two series should be done using Wilcoxon test
wilcox.test(morality_bad, morality_good, paired = F, alternative = "less", exact = F)

# 2.2 Empathy
# from the dataframe, extract empathy for good and bad
empathy_good <- good_bad %>% 
  filter(condition == "good") %>% 
  select(all_of("empathy")) %>% 
  unlist()

empathy_bad <- good_bad %>% 
  filter(condition == "bad") %>% 
  select(all_of("empathy")) %>% 
  unlist()

shapiro.test(c(empathy_bad, empathy_good))

# as data is not normally distributed, a comparison between the two series should be done using Wilcoxon test
wilcox.test(empathy_bad, empathy_good, paired = F, alternative = "less", exact = F)

# 3. Alternative approach: correlation analysis

# instead of comparing two conditions as separated (students who read the "Good" or "Bad" version), try to see if there is any connection between their evaluation of morality and of empathy 
# first of all, explore this by visualizing the relationship between morality and empathy
my_plot <- ggplot(good_bad, aes(x = morality, y = empathy)) +
  geom_count() +
  geom_smooth(method = 'lm')
my_plot

# to test the significance of the relationship, we use a correlation test
cor.test(good_bad$morality, good_bad$empathy)
