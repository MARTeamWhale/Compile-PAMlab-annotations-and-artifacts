#Merge artifacts with annotations
if (!require("data.table")) install.packages("data.table")
if (!require("here")) install.packages("here")
if (!require("purrr")) install.packages("purrr") 

#Merge artifacts csvs into one master csv
library(data.table)
library(dplyr)
library(readr)
library(tidyverse)
library(tibble)
library(stringr)
library(readr)
library(here)
library("purrr")

#
data_all <- list.files(path = "R:/Science/CetaceanOPPNoise/CetaceanOPPNoise_3/Other_PAM_Studies/2023 Fin Whale HF Notes Review_MMurphy/Files to merge",  # Identify all CSV files
                       pattern = "*.csv", full.names = TRUE) %>% 
  lapply(read_csv) %>%                              # Store all files in list
  bind_rows                                         # Combine data sets into one data set 
data_all

data_join <- list.files(path = "R:/Science/CetaceanOPPNoise/CetaceanOPPNoise_3/Other_PAM_Studies/2023 Fin Whale HF Notes Review_MMurphy/Files to merge", # Identify all CSV files
                        pattern = "*.csv", full.names = TRUE) %>% 
  lapply(read_csv) %>%                              # Store all files in list
  reduce(full_join, by = "Relative.Start.Time")                      # Full-join data sets into one data set 
data_join                                           # Print data to RStudio console

write_csv(data_join, "Merged files2.csv")
