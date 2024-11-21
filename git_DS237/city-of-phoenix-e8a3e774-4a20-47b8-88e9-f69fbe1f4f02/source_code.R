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


# Step 3: Histogram with bell curve overlay for unemployment_rate
ggplot(cleaned_data, aes(x = unemployment_rate)) +
    geom_histogram(aes(y = ..density..), bins = 30, color = "black", fill = "lightblue") +
    stat_function(fun = dnorm, args = list(mean = mean(cleaned_data$unemployment_rate, na.rm = TRUE),
                                           sd = sd(cleaned_data$unemployment_rate, na.rm = TRUE)),
                  color = "red", size = 1) +
    labs(title = "Histogram of Unemployment Rate with Bell Curve Overlay",
         x = "Unemployment Rate",
         y = "Density") +
    theme_minimal()

# Step 4: Scatterplots for correlation
# Unemployment rate vs. City
ggplot(cleaned_data, aes(x = city, y = unemployment_rate)) +
    geom_boxplot() +
    labs(title = "Unemployment Rate by City",
         x = "City",
         y = "Unemployment Rate") +
    theme_minimal()

# Unemployment rate vs. State
ggplot(cleaned_data, aes(x = state, y = unemployment_rate)) + geom_point() + geom_smooth(method = "lm", color = "blue", se = FALSE)  +
    labs(title = "Unemployment Rate by State",
         x = "State",
         y = "Unemployment Rate")

# Unemployment rate vs. Year
ggplot(cleaned_data, aes(x = year, y = unemployment_rate)) +
    geom_point() +
    geom_smooth(method = "lm", color = "blue", se = FALSE) +
    labs(title = "Unemployment Rate by Year",
         x = "Year",
         y = "Unemployment Rate") +
    theme_minimal()

# Step 5: Calculate correlations
correlation <- cor(cleaned_data$unemployment_rate, as.numeric(cleaned_data$year), use = "complete.obs")
print(paste("Correlation between unemployment rate and year:", round(correlation, 2)))

# Hypothesis testing
# Run correlation test for numeric variable (year)
cor_test <- cor.test(cleaned_data$unemployment_rate, cleaned_data$year, method = "pearson")
print(cor_test)
