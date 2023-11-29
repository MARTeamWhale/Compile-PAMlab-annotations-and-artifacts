# M. Murphy November 2023 (based on script by P. Emery and G. Macklin)

# Script to merge annotations log files into a master annotations csv

# install required packages
if (!require("data.table")) install.packages("data.table")
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("here")) install.packages("here")

# load required packages
library(data.table)
library(tidyverse)
library(here)

# load files
file_path <- r"(R:\Science\CetaceanOPPNoise\CetaceanOPPNoise_3\Other_PAM_Studies\2023 Fin Whale HF Notes Review_MMurphy\HF note files\annotations)" #copy file path to annotations folder within recording folder, paste inside r"( )"

file_list <- list.files(file_path, pattern = ".log", full.names = TRUE)

# merge them together into a single dataframe
annomerge <- rbindlist(sapply(file_list, fread, simplify = FALSE, USE.NAMES = TRUE, fill=TRUE), fill= TRUE)%>%
  mutate(filename = str_extract(Soundfile, "[^\\\\]*$"), .after=Soundfile)

# export csv file
output_file = paste0("FW HF NOTES",".csv")

write_csv(annomerge, here("data", output_file))
