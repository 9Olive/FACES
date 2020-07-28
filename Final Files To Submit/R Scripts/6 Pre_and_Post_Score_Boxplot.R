source('FACES_fns.R')
library(tidyverse)
faces <- read_csv("../../Data/cleaned_FACES_data.csv")

theme_set(theme_bw())

faces %>% 
  mutate(Survey = factor(Survey)) %>%
  group_by(`Participant #`, Time, Group, Survey) %>%
  summarise(Total_Score = sum(Response),
            Total_Questions = length(unique(Question))) %>%
  ungroup() %>%
  mutate(Time     = factor(Time, levels = c('Pre', 'Post')), 
         Group    = factor(Group),
         Survey   = factor(Survey)) %>%
  pivot_wider(id_cols = c('Participant #', 'Group', 'Survey'),
              names_from = 'Time',
              values_from = 'Total_Score') %>%
  mutate(Diff_Pct = (Post - Pre)/Pre,
         Diff = (Post - Pre)) %>%
  ggplot() +
  geom_boxplot(aes(x = Group, y = Diff, fill = Group)) +
  facet_wrap(Survey~., scales = 'free_y') +
  labs(title = 'Distribution of Differences between Pre and Post Total Scores', 
       x = '',
       y = 'Difference',
       caption = 'Calculation: Post - Pre Difference
       in response score per Participant + Survey + Group.') +
  scale_y_continuous(#labels = scales::percent_format(accuracy = 1),
    breaks = scales::pretty_breaks(7)) +
  theme(text = element_text(size = 17))
ggsave(filename = 'post_vs_pre.png', width = 16, height = 9, units = 'in')