# Compile Pamlab annotations into a csv, for high frequency notes

# M. Murphy 2023 (based on script by P. Emery and G. Macklin)

# Download and install packages if not already installed: data.table, tidyverse, here

if (!require("data.table")) install.packages("data.table")
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("here")) install.packages("here")

# Then open the packages

library(data.table)
library(tidyverse)
library(here)


### EDIT THESE:
file_path <- r"(R:\Science\CetaceanOPPNoise\CetaceanOPPNoise_3\Other_PAM_Studies\2023 Fin Whale HF Notes Review_MMurphy\HF note files\annotations)" #copy file path to annotations folder within recording folder, paste inside r"( )"


### RUN THESE:
deployment_code <- "HF"
AnalysisCode <- "DPA" #input analysis code here
SpeciesCode <- "MB" # input species code here

file_list <- list.files(file_path, pattern = ".log", full.names = TRUE)


# Then merge them together into a single dataframe

annomerge <- rbindlist(sapply(file_list, fread, simplify = FALSE, USE.NAMES = TRUE, fill=TRUE), fill= TRUE)%>%
  mutate(filename = str_extract(Soundfile, "[^\\\\]*$"), .after=Soundfile)


# Export csv file
output_file = paste0("FW HF NOTES",".csv")
write_csv(annomerge, here("data", output_file))
