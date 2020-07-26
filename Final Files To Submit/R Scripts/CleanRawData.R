# Clean Data Script
# Date: July 2020
# Author: Joseph Oliveira 
# Questions? Contact me at jolivei@ncsu.edu
library(tidyverse)

# MAKE SURE TO LOAD FUNCTIONS FROM THIS SCRIPT
source('FACES_fns.R')

# Multiple ways to load data:
  
# first way, specify data
# fpath <- read_csv('../Data/FACES_data_Spring_2019_AllData.csv')
# format_FACES(data = fpath)

# second way, specify path
# format_FACES(path = '../Data/FACES_data_Spring_2019_AllData.csv') # merged cells?

# third way, just call the fucntion
faces <- format_FACES()

# ------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------

## Identifying missing data

(missing_sum <- faces %>%
    filter(is.na(Response)) %>%
    group_by(`Participant #`, Time, Group, Survey) %>%
    summarise(missing_data = sum(is.na(Response))) %>%
    arrange(missing_data) %>% 
    ungroup())

missing_sum$missing_data
obs <- faces %>%
  filter(!is.na(Response)) %>%
  group_by(`Participant #`, Time, Group, Survey) %>%
  summarise(obs = n()) %>% 
  ungroup() %>%
  pull(obs) %>%
  sum()

# ------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------

# ### Splitting the missing data  
# - Rule: If a participant is missing 2 or less responses, then we keep the participant; 
# - else: we remove the participant from the affected surveys.
# - The `distinct` function removes instances where the participant is missing more than 2 responses for both a `pre` and `post` time survey response. One instance in either `Pre` or `Post` is enough to get the record removed. 

keepers <- missing_sum %>%
  filter(missing_data <= 2)

throwers <- missing_sum %>%
  distinct(`Participant #`, Group, Survey, .keep_all = T) %>% # added to removed Pre and Post
  filter(missing_data > 2)

# ------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------

# ### Removing `throwers` from the overall dataset  
# - Right join filters out records
# - Right join by `Participant #`, `Group`, and `Survey` allows the participant records from `Pre` and `Post` to be matched up. 
# - The resulting data set is a list of records that needs to be removed from the original data set

(data_to_remove <- faces %>% 
    right_join(throwers, by = c('Participant #', 'Group', 'Survey'),
               suffix = c('', '_mis')))

# Records removed below: 
(faces_clean <-  setdiff(x = faces, y = select(data_to_remove, -Time_mis, -missing_data)))

# Check that we only took the rows we intended to
nrow(faces_clean) == nrow(faces) - nrow(data_to_remove)

# Check for missing data
anyNA(faces_clean)

# ------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------

### Imputing the data:  
# - Right join filters out records, again
# - Right join by `Participant #`, `Group`, `Survey`, and `Time` because we only want to impute for that particular missing value
# - Filter down to missing responses, because all questions for each survey category was matched
# - The resulting data set is a list of records that needs to be imputed

(data_to_impute <- faces %>%
    right_join(keepers, by = c('Participant #', 'Group', 'Survey', 'Time'),
               suffix = c('', '_kp')) %>%
    filter(is.na(Response)))

faces_clean2 <- faces_clean %>%
  group_by(Time, Group, Survey, Question) %>%
  mutate(Response = ifelse(is.na(Response), mean(Response, na.rm = T), Response)) %>%
  ungroup()

# ------------------------------------------------------------------------------------------------------------------------
# Quick check

# To visulize what we changed
data_to_impute %>%
  left_join(faces_clean2, by = c('Participant #', 'Time', 'Group', 'Survey', 'Question'),
            suffix = c('_mis', '_fill'))

# Should be true
nrow(faces_clean2) == nrow(faces_clean)

# Should be false
anyNA(faces_clean2)

# Saving data
# write_csv(faces_clean2, path = '../Cleaned Data File/cleaned_FACES_data.csv')