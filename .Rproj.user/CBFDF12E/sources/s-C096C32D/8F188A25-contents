# Clean data script
# Run this script to clean the survey data on your computer
# Download and save in the your local dir: FACES_fns.R

source('Data/FACES_fns.R') # Change as needed


readr::write_csv(
  clean_faces_1(readr::read_csv('Data/FACES_data_Spring_2019_AllData.csv')),
  path = paste0(getwd(), 'Data/Clean_All_Data.csv')
)


