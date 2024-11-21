# Load necessary libraries
library(tidyverse)
library(ggplot2)
library(dplyr)

# Step 1: Load the dataset
file_path <- "original/unemployment-rate-1.csv" # Replace with the path to your dataset
data <- read.csv(file_path)

# Step 2: Data Cleaning
# Ensure column names are consistent and remove rows with missing values
cleaned_data <- data %>%
    rename_all(tolower) %>%
    filter(complete.cases(.))

# Convert relevant columns to appropriate data types
cleaned_data$city <- as.factor(cleaned_data$city)
cleaned_data$state <- as.factor(cleaned_data$state)
cleaned_data$year <- as.numeric(cleaned_data$year)
cleaned_data$unemployment_rate <- as.numeric(cleaned_data$unemployment_rate)

# View cleaned data
print("Cleaned Data Sample:")
print(head(cleaned_data))
