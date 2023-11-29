# Install packages
if (!require("data.table")) install.packages("data.table")
if (!require("here")) install.packages("here")

#Merge artifacts csvs into one master csv
library(data.table)
library(dplyr)
library(readr)
library(tidyverse)
library(tibble)
library(stringr)
library(readr)
library(here)

#read individual artifacts csvs, mutating row into filename
# original CSV:

Artifactsfile <- 'R:/Science/CetaceanOPPNoise/CetaceanOPPNoise_3/Other_PAM_Studies/2023 Fin Whale HF Notes Review_MMurphy/HF note files/Results/Artifacts CSVs/Artifacts141.csv'

original_data <- read.csv(Artifactsfile, as.is=T, header= FALSE, row.names= NULL) 
filename = str_extract(original_data[2,1],"[^\\\\\\\\]*$")

new_data <- read.csv(Artifactsfile, as.is=T, skip = 2, header = T, row.names= NULL)%>%
  mutate(filename=c(filename),
         .before=Absolute.Start.Time)

#write master csv file into same folder location

write.csv(new_data,Artifactsfile)

#combine all artifacts csvs into a master csv

df <- list.files(path='R:/Science/CetaceanOPPNoise/CetaceanOPPNoise_3/Other_PAM_Studies/2023 Fin Whale HF Notes Review_MMurphy/HF note files/Results/Artifacts CSVs', pattern = '.csv') %>% 
  lapply(read.csv, as.is=T, row.names= NULL) %>% 
  bind_rows 

write_csv(df, "Master Artifacts.csv")
