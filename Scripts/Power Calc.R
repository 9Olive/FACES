faces_avg <- faces %>%
  group_by(Group, `Participant #`, Time, Survey) %>%
  summarise(avg_resp = mean(Response)) %>%
  ungroup()

faces_sum <- faces %>%
  group_by(Group, `Participant #`, Time, Survey) %>%
  summarise(avg_resp = sum(Response)) %>%
  ungroup()

#histograms of the faces pre data
surveys <- unique(faces_sum$Survey)
par(mfrow=c(2,2))
for (i in 1:2) {
  hist((faces_avg %>% filter(Time == 'Pre', Survey==surveys[i]))$avg_resp,
        main=paste('Histogram for ', surveys[i]),
        breaks=10
  )
  hist((faces_sum %>% filter(Time == 'Pre', Survey==surveys[i]))$avg_resp,
        main=paste('Histogram for ', surveys[i]),
        breaks=10
  )
  
}

par(mfrow=c(3,2))
for (i in 3:5) {
  hist((faces_avg %>% filter(Time == 'Pre', Survey==surveys[i]))$avg_resp,
       main=paste('Histogram for ', surveys[i]),
       breaks=10
  )
  hist((faces_sum %>% filter(Time == 'Pre', Survey==surveys[i]))$avg_resp,
       main=paste('Histogram for ', surveys[i]),
       breaks=10
  )
  
}

#histograms of the faces experimental data (diff between pre and post)
wider <- faces %>% 
  pivot_wider(id_cols = c('Participant #', 'Survey', 'Group'), 
              names_from = contains(c('Time')),
              values_from = c(avg_resp)) %>%
              filter(Group == 'Experimental')

#Plot differences in histogram and qq plot
#we're hoping for roughly normal
diff <- wider$Post-wider$Pre
par(mfrow=c(1,1))
hist(diff,
     main='Histogram of Differences Between Pre and Post',
     breaks=10)

#Some normality issues in the upper tail. clearly a little bit right skewed
require(car)
qqp(diff)


#I think we can probably assume normality and ttests may not be outrageous either
#for now here is the power output
require(WMWssp)
sampleSize <- c()
for (i in 1:6) {
  temp <- wider %>% filter(Survey==surveys[i])
  sampleSize[i] <- WMWssp(temp$Pre, temp$Post, alpha = 0.05, power = 0.8)[6]
}
sampleSize <- t(sampleSize)
colnames(sampleSize) <- surveys
sampleSize


#calculate these for the t-test
require(pwr)
ttestSample <- c()
for (i in 1:6) {
  temp <- wider %>% filter(Survey==surveys[i])
  diff <- mean(temp$Post) - mean(temp$Pre)
  poolVar <- ((sd(temp$Post)^2 + sd(temp$Pre)^2)/2)^0.5
  ttestSample[i] <- pwr.t.test(d=diff/poolVar, power=0.80, 
                            sig.level=0.05, type="paired", alternative='greater')[1]
}
ttestSample <- t(ttestSample)
colnames(ttestSample) <- surveys
ttestSample

