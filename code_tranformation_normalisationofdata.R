# guppy boldness

guppy <- read.csv("~/NIAS_files/dataForAnalysis/guppyboldness.csv")

head(guppy)


hist(guppy$boldness.score)
any(is.na(guppy$boldness.score)) # if true remove NA

# Remove NAs before calculating mean and standard deviation
boldness_scores <- guppy$boldness.score[!is.na(guppy$boldness.score)]

mean_et <- mean(boldness_scores)  # Mean of non-NA data
sd_et <- sd(boldness_scores)  # Standard deviation of non-NA data

# Corrected z-score computation
guppy$boldness.score.z <- (guppy$boldness.score - mean_et) / sd_et

hist(guppy$boldness.score.z)

hist(guppy$boldness.score.z, breaks = "Sturges", main = "Histogram of Z-Transformed Boldness Score", xlab = "Boldness Score (Z)")


# Load necessary libraries
library(dplyr)

# Set a random seed for reproducibility
set.seed(123)

# Total number of fish
total_fish <- 80

# Number of fish with emergence time capped at 600
capped_fish <- 30

# Number of fish with random emergence times between 0 and 600
random_fish <- total_fish - capped_fish

# Create a data frame for the dataset
fish_data <- data.frame(
        Fish_ID = 1:total_fish,  # Unique identifier for each fish
        Emergence_Time = c(
                rep(600, capped_fish),  # Capped emergence times for non-emerging fish
                runif(random_fish, 0, 600)  # Random times for emerging fish
        )
)

# Randomize the order to mix the data
fish_data <- fish_data[sample(nrow(fish_data)), ]

# Display the head of the generated dataset
head(fish_data)

hist(fish_data$Emergence_Time)

# Min-Max Scaling function
min_max_scaling <- function(x) {
        (x - min(x)) / (max(x) - min(x))
}

# Apply Min-Max Scaling to the dataset
fish_data$Emergence_Time_MinMax <- min_max_scaling(fish_data$Emergence_Time)

# Check the first few rows of the scaled data
head(fish_data)
hist(fish_data$Emergence_Time_MinMax)

# Z-Score Normalization function
z_score_normalization <- function(x) {
        (x - mean(x)) / sd(x)
}

# Apply Z-Score Normalization to the dataset
fish_data$Emergence_Time_Z <- z_score_normalization(fish_data$Emergence_Time)

# Check the first few rows of the normalized data
head(fish_data)

hist(fish_data$Emergence_Time_Z)

# Find the scaling factor
scaling_factor <- 10^ceiling(log10(max(fish_data$Emergence_Time)))

# Apply Decimal Scaling to the dataset
fish_data$Emergence_Time_Decimal <- fish_data$Emergence_Time / scaling_factor

# Check the first few rows of the scaled data
head(fish_data)

hist(fish_data$Emergence_Time_Decimal)

min(fish_data$Emergence_Time_MinMax)  # Should be close to 0
max(fish_data$Emergence_Time_MinMax)  # Should be close to 1

qqnorm(fish_data$Emergence_Time_Z)
qqline(fish_data$Emergence_Time_Z, col = "red")