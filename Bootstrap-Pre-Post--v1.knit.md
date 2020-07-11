
<!-- rnb-text-begin -->

---
title: "Bootstrap"
output: html_notebook
---


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeSh0aWR5dmVyc2UpXG5gYGAifQ== -->

```r
library(tidyverse)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZmFjZXMgPC0gcmVhZF9jc3YoJy4uL0RhdGEvY2xlYW5lZF9GQUNFU19kYXRhLmNzdicsIGNvbF90eXBlcyA9IGMoJ2ZmZmZkZicpKVxuYGBgIn0= -->

```r
faces <- read_csv('../Data/cleaned_FACES_data.csv', col_types = c('ffffdf'))
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Bootstrap:

1. Filter data down that we want to bootstrap (not really apart of the bootstrap process)

2. Non-parameteric Bootstrap:

We pull from our samples for non-parameteric bootstrap. Typically, we calculate some parameter. I calculate the mean for 50,000 participants :)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuI2hvdyBtYW55IGRpZmZlcmVudCBuIHRvIHRlc3Rcbm0gPC0gc2VxKGZyb209NSwgdG89NjAsIGJ5PTUpXG4jcG93ZXIgZGF0YWZyYW1lIGZvciBub24tcGFyYW1ldHJpY1xucG93ZXJfZGF0YSA8LSBkYXRhLmZyYW1lKCdGQUNFUycgPSBudW1lcmljKGxlbmd0aChtKSksICdBS1MnID0gbnVtZXJpYyhsZW5ndGgobSkpLCBcbiAgICAgICAgICAgICAgICAgICAgICAgICAnRkVTJyA9IG51bWVyaWMobGVuZ3RoKG0pKSwgJ1NDUycgPSBudW1lcmljKGxlbmd0aChtKSksIFxuICAgICAgICAgICAgICAgICAgICAgICAgICdGUFBTJyA9IG51bWVyaWMobGVuZ3RoKG0pKSwgJ1NFQVMnID0gbnVtZXJpYyhsZW5ndGgobSkpKVxuXG5cbiNwb3dlciBkYXRhZnJhbWUgZm9yIHBhcmFtZXRyaWMgZ3JvdXBcbnBvd2VyX25vcm0gPC0gZGF0YS5mcmFtZSgnRkFDRVMnID0gbnVtZXJpYyhsZW5ndGgobSkpLCAnQUtTJyA9IG51bWVyaWMobGVuZ3RoKG0pKSwgXG4gICAgICAgICAgICAgICAgICAgICAgICAgJ0ZFUycgPSBudW1lcmljKGxlbmd0aChtKSksICdTQ1MnID0gbnVtZXJpYyhsZW5ndGgobSkpLCBcbiAgICAgICAgICAgICAgICAgICAgICAgICAnRlBQUycgPSBudW1lcmljKGxlbmd0aChtKSksICdTRUFTJyA9IG51bWVyaWMobGVuZ3RoKG0pKSlcbmBgYCJ9 -->

```r
#how many different n to test
m <- seq(from=5, to=60, by=5)
#power dataframe for non-parametric
power_data <- data.frame('FACES' = numeric(length(m)), 'AKS' = numeric(length(m)), 
                         'FES' = numeric(length(m)), 'SCS' = numeric(length(m)), 
                         'FPPS' = numeric(length(m)), 'SEAS' = numeric(length(m)))


#power dataframe for parametric group
power_norm <- data.frame('FACES' = numeric(length(m)), 'AKS' = numeric(length(m)), 
                         'FES' = numeric(length(m)), 'SCS' = numeric(length(m)), 
                         'FPPS' = numeric(length(m)), 'SEAS' = numeric(length(m)))
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZm9yIChuIGluIG0pIHtcbiAgIyBOdW1iZXIgb2YgdGltZXMgdG8gYm9vdHN0cmFwXG4gIEIgPC0gMWU0XG4gICNzdXJ2ZXkgY2F0ZWdvcmllc1xuICBzdXJ2ZXlzIDwtIGFzLmNoYXJhY3Rlcih1bmlxdWUoZmFjZXMkU3VydmV5KSlcbiAgI2RhdGFmcmFtZSB0byBob2xkIHNpbXVsYXRpb24gcmVzdWx0c1xuICBwcmUuZXhwIDwtIGRhdGEuZnJhbWUoJ0ZBQ0VTJyA9IG51bWVyaWMoQiksICdBS1MnID0gbnVtZXJpYyhCKSwgJ0ZFUycgPSBudW1lcmljKEIpLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAnU0NTJyA9IG51bWVyaWMoQiksICdGUFBTJyA9IG51bWVyaWMoQiksICdTRUFTJyA9IG51bWVyaWMoQikpXG4gIHBvc3QuZXhwIDwtIGRhdGEuZnJhbWUoJ0ZBQ0VTJyA9IG51bWVyaWMoQiksICdBS1MnID0gbnVtZXJpYyhCKSwgJ0ZFUycgPSBudW1lcmljKEIpLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAnU0NTJyA9IG51bWVyaWMoQiksICdGUFBTJyA9IG51bWVyaWMoQiksICdTRUFTJyA9IG51bWVyaWMoQikpXG4gIFxuICBmb3IgKGogaW4gMTo2KSB7XG4gICAgc2FtcGxlX2ZhY2VzX3ByZSA8LSBmYWNlcyAlPiVcbiAgICAgIGZpbHRlcihUaW1lID09ICdQcmUnLCBcbiAgICAgICAgICAgICBHcm91cCA9PSAnRXhwZXJpbWVudGFsJyxcbiAgICAgICAgICAgICBTdXJ2ZXkgPT0gc3VydmV5c1tqXSkgJT4lXG4gICAgICBncm91cF9ieShgUGFydGljaXBhbnQgI2ApICU+JVxuICAgICAgc3VtbWFyaXNlKFRvdGFsID0gc3VtKFJlc3BvbnNlKSkgJT4lXG4gICAgICB1bmdyb3VwKClcbiAgICBcbiAgICBzYW1wbGVfZmFjZXNfcG9zdCA8LSBmYWNlcyAlPiVcbiAgICAgIGZpbHRlcihUaW1lID09ICdQb3N0JywgXG4gICAgICAgICAgICAgR3JvdXAgPT0gJ0V4cGVyaW1lbnRhbCcsXG4gICAgICAgICAgICAgU3VydmV5ID09IHN1cnZleXNbal0pICU+JVxuICAgICAgZ3JvdXBfYnkoYFBhcnRpY2lwYW50ICNgKSAlPiVcbiAgICAgIHN1bW1hcmlzZShUb3RhbCA9IHN1bShSZXNwb25zZSkpICU+JVxuICAgICAgdW5ncm91cCgpXG4gIFxuICAgICMgVmVjdG9yIHRvIHN0b3JlIG1lYW5zXG4gICAgbTFkIDwtIG51bWVyaWMoKVxuICAgIG0xbiA8LSBudW1lcmljKClcbiAgICBcbiAgICAjcHJlIHNhbXBsZSBtZWFuIGFuZCBzZFxuICAgIHByZV9tZWFuIDwtIG1lYW4oc2FtcGxlX2ZhY2VzX3ByZSRUb3RhbClcbiAgICBwcmVfc2QgPC0gc2Qoc2FtcGxlX2ZhY2VzX3ByZSRUb3RhbClcbiAgICBcbiAgICBmb3IgKGkgaW4gMTpCKSB7XG4gICAgICBkaXN0IDwtIHNhbXBsZShzYW1wbGVfZmFjZXNfcHJlJFRvdGFsLCBzaXplID0gbiwgcmVwbGFjZSA9IFQpXG4gICAgICBtMWRbaV0gPC0gbWVhbihkaXN0KVxuICAgICAgZGlzdCA8LSBybm9ybShuLCBtZWFuPXByZV9tZWFuLCBzZD1wcmVfc2QpXG4gICAgICBtMW5baV0gPC0gbWVhbihkaXN0KVxuICAgIH1cbiAgICBcbiAgICAjdmVjdG9yIHRvIHN0b3JlIHBvc3QgbWVhbnNcbiAgICBtMmQgPC0gbnVtZXJpYygpXG4gICAgbTJuIDwtIG51bWVyaWMoKVxuICAgIFxuICAgICNwb3N0IHNhbXBsZSBtZWFuIGFuZCBzZFxuICAgIHBvc3RfbWVhbiA8LSBtZWFuKHNhbXBsZV9mYWNlc19wb3N0JFRvdGFsKVxuICAgIHBvc3Rfc2QgPC0gc2Qoc2FtcGxlX2ZhY2VzX3Bvc3QkVG90YWwpXG4gICAgXG4gICAgZm9yIChpIGluIDE6Qikge1xuICAgICAgZGlzdCA8LSBzYW1wbGUoc2FtcGxlX2ZhY2VzX3Bvc3QkVG90YWwsIHNpemUgPSBuLCByZXBsYWNlID0gVClcbiAgICAgIG0yZFtpXSA8LSBtZWFuKGRpc3QpXG4gICAgICBkaXN0IDwtIHJub3JtKG4sIG1lYW49cG9zdF9tZWFuLCBzZD1wb3N0X3NkKVxuICAgICAgbTJuW2ldIDwtIG1lYW4oZGlzdClcbiAgICB9XG4gICAgXG4gICAgcG93ZXJfZGF0YVtuIC8gNSwgal0gPC0gbWVhbihtMmQgPiBtMWQpXG4gICAgcG93ZXJfbm9ybVtuIC8gNSwgal0gPC0gbWVhbihtMm4gPiBtMW4pXG4gIH1cbn1cbmBgYCJ9 -->

```r
for (n in m) {
  # Number of times to bootstrap
  B <- 1e4
  #survey categories
  surveys <- as.character(unique(faces$Survey))
  #dataframe to hold simulation results
  pre.exp <- data.frame('FACES' = numeric(B), 'AKS' = numeric(B), 'FES' = numeric(B),
                          'SCS' = numeric(B), 'FPPS' = numeric(B), 'SEAS' = numeric(B))
  post.exp <- data.frame('FACES' = numeric(B), 'AKS' = numeric(B), 'FES' = numeric(B),
                          'SCS' = numeric(B), 'FPPS' = numeric(B), 'SEAS' = numeric(B))
  
  for (j in 1:6) {
    sample_faces_pre <- faces %>%
      filter(Time == 'Pre', 
             Group == 'Experimental',
             Survey == surveys[j]) %>%
      group_by(`Participant #`) %>%
      summarise(Total = sum(Response)) %>%
      ungroup()
    
    sample_faces_post <- faces %>%
      filter(Time == 'Post', 
             Group == 'Experimental',
             Survey == surveys[j]) %>%
      group_by(`Participant #`) %>%
      summarise(Total = sum(Response)) %>%
      ungroup()
  
    # Vector to store means
    m1d <- numeric()
    m1n <- numeric()
    
    #pre sample mean and sd
    pre_mean <- mean(sample_faces_pre$Total)
    pre_sd <- sd(sample_faces_pre$Total)
    
    for (i in 1:B) {
      dist <- sample(sample_faces_pre$Total, size = n, replace = T)
      m1d[i] <- mean(dist)
      dist <- rnorm(n, mean=pre_mean, sd=pre_sd)
      m1n[i] <- mean(dist)
    }
    
    #vector to store post means
    m2d <- numeric()
    m2n <- numeric()
    
    #post sample mean and sd
    post_mean <- mean(sample_faces_post$Total)
    post_sd <- sd(sample_faces_post$Total)
    
    for (i in 1:B) {
      dist <- sample(sample_faces_post$Total, size = n, replace = T)
      m2d[i] <- mean(dist)
      dist <- rnorm(n, mean=post_mean, sd=post_sd)
      m2n[i] <- mean(dist)
    }
    
    power_data[n / 5, j] <- mean(m2d > m1d)
    power_norm[n / 5, j] <- mean(m2n > m1n)
  }
}
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-plot-begin eyJjb25kaXRpb25zIjpbXSwiaGVpZ2h0Ijo0MzIuNjMyOSwic2l6ZV9iZWhhdmlvciI6MCwid2lkdGgiOjcwMH0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



Comparing Pre and Post mean distributions:


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGlzdCA8LSB0aWJibGUoVGltZSA9IGMocmVwKCdQcmUnLCBsZW5ndGgobTEpKSwgcmVwKCdQb3N0JywgbGVuZ3RoKG0yKSkpLFxuICAgICAgICAgICAgICAgRGlzdCA9IGMobTEsIG0yKSkgJT4lXG4gIG11dGF0ZShUaW1lID0gZmFjdG9yKFRpbWUpKVxuZGlzdCAlPiVcbiAgZ2dwbG90KCkgK1xuICBnZW9tX2RlbnNpdHkoYWVzKHggPSBEaXN0LCBmaWxsID0gVGltZSksIGFscGhhID0gMC43KVxuYGBgIn0= -->

```r
dist <- tibble(Time = c(rep('Pre', length(m1)), rep('Post', length(m2))),
               Dist = c(m1, m2)) %>%
  mutate(Time = factor(Time))
dist %>%
  ggplot() +
  geom_density(aes(x = Dist, fill = Time), alpha = 0.7)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->

