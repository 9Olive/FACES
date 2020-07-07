faces_avg <- faces %>%
  group_by(Group, `Participant #`, Time, Survey) %>%
  summarise(avg_resp = mean(Response)) %>%
  ungroup()

faces_sum <- faces %>%
  group_by(Group, `Participant #`, Time, Survey) %>%
  summarise(avg_resp = sum(Response)) %>%
  ungroup()

#histograms of the faces experimental data (diff between pre and post)
wider_sum <- faces_sum %>% 
  pivot_wider(id_cols = c('Participant #', 'Survey', 'Group'), 
              names_from = contains(c('Time')),
              values_from = c(avg_resp)) %>%
  filter(Group == 'Experimental')

#histograms of the faces experimental data (diff between pre and post)
wider_avg <- faces_avg %>% 
  pivot_wider(id_cols = c('Participant #', 'Survey', 'Group'), 
              names_from = contains(c('Time')),
              values_from = c(avg_resp)) %>%
  filter(Group == 'Experimental')

#histograms of the faces pre data
surveys <- unique(faces_sum$Survey)
avgTest <- c()
sumTest <- c()
for (i in 1:6) {
  temp <- wider_avg %>% filter(Survey==surveys[i])
  avgTest[i] <- t.test(temp$Pre, temp$Post, paired=TRUE)[3]
  temp <- wider_sum %>% filter(Survey==surveys[i])
  sumTest[i] <- t.test(temp$Pre, temp$Post, paired=TRUE)[3]
  
}

avgTest <- t(avgTest)
sumTest <- t(sumTest)
colnames(avgTest) <- surveys
colnames(sumTest) <- surveys
avgTest
sumTest