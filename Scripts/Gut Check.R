faces_avg <- faces %>%
  group_by(Group, `Participant #`, Time, Survey) %>%
  summarise(avg_resp = mean(Response)) %>%
  ungroup()

faces_sum <- faces %>%
  group_by(Group, `Participant #`, Time, Survey) %>%
  summarise(avg_resp = sum(Response)) %>%
  ungroup()


#Assuming the faces data is cleaned correctly. can be verified elswhere.
#starting w/ base faces data
prePostExp <- faces_sum %>%
  filter(Group == 'Experimental') %>% 
  mutate(Survey = factor(Survey))

surveys <- unique(prePostExp$Survey)
pValppExp <- c()

for (i in 1:6) {
  pValppExp[i] <- wilcox.test(avg_resp ~ Time, 
                              paired = TRUE,
                              alternative="less",
                              data = filter(prePostExp, Survey == surveys[i]))[3]
}
pValppExp <- t(pValppExp)
colnames(pValppExp) <- surveys
pValppExp        


prePostCon <- faces_sum %>%
  filter(Group == 'Control') %>% 
  mutate(Survey = factor(Survey))

pValppCon <- c()

for (i in 1:6) {
  pValppCon[i] <- wilcox.test(avg_resp ~ Time, 
                              paired = TRUE,
                              alternative="less",
                              data = filter(prePostCon, Survey == surveys[i]))[3]
}
pValppCon <- t(pValppCon)
colnames(pValppCon) <- surveys
pValppCon  


#-------------------------------
  
  

tcPre <- faces_sum %>%
  filter(Time == 'Pre') %>% 
  mutate(Survey = factor(Survey), factor(Group))

pValTCPre <- c()

for (i in 1:6) {
  pValTCPre[i] <- wilcox.test(avg_resp ~ Group, 
                              paired = FALSE,
                              alternative="two.sided",
                              data = filter(tcPre, Survey == surveys[i]))[3]
}
pValTCPre <- t(pValTCPre)
colnames(pValTCPre) <- surveys
pValTCPre        


tcPost <- faces_sum %>%
  filter(Time == 'Post') %>% 
  mutate(Survey = factor(Survey), factor(Group))

pValTCPost <- c()

for (i in 1:6) {
  pValTCPost[i] <- wilcox.test(avg_resp ~ Group, 
                               paired = FALSE,
                               alternative="two.sided",
                               data = filter(tcPost, Survey == surveys[i]))[3]
}
pValTCPost <- t(pValTCPost)
colnames(pValTCPost) <- surveys
pValTCPost