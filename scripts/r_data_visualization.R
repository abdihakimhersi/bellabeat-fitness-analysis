# BELLABEAT FITNESS DATA ANALYSIS
# Google Data Analytics Certificate Case Study
# R visualizations created in Posit Cloud
#---------------------------loading packages------------------------------------
intall.packages("tidyverse")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("lubridate")
install.packages("scales")
install.packages("viridis")
install.packages("gridExtra")
library(tidyverse)
library(ggplot2)
library(dplyr)
library(lubridate)
library(scales)
library(viridis)
library(gridExtra)
#----------------------------checking packages----------------------------------
print('packages loaded sucessfuly')
#----------------------------uploading the data---------------------------------
user_segmentation <- read.csv("data/USER SEGMENTATION - ACTIVITY LEVELS.csv")
weekly_patterns <- read.csv("data/Weekly Activity Pattern.csv")
hourly_activity <- read_csv("data/Hourly Activity Pattern.csv")
usage_consistency <- read_csv("data/Device Usage Frequency.csv")
sleep_analysis <- read_csv("data/sleep pattern analysis.csv")
heart_rate <- read_csv("data/HEART RATE MONITORING USAGE.csv")
#-----------------------check to see if data uploaded---------------------------
print("user segementation data")
glimpse(user_segmentation)
head(user_segmentation)

print("weekly activity pattern data")
glimpse(weekly_patterns)
head(weekly_patterns)
# --------------------core visualizations---------------------------------------
#Visulization1: User segmentation
p1 <- ggplot(user_segmentation,
             aes(x = reorder(activity_segment,-number_of_users),
                 y = number_of_users,
                 fill = activity_segment)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = number_of_users), vjust = -0.5, size = 4) +
  labs(title = "BELLABEAT INSIGHT: User Activity Segmentation",
       x = "Activity Level",
       y = "Number of Users",
       caption = "Data shows oppertunities for Bellabeat to target different user segment") +
  theme_minimal() +
  scale_fill_viridis_d() +
  theme(plot.title = element_text(face = "bold", size = 14),
        axis.text.x = element_text(angle = 45, hjust = 1))
print(p1)

# Visualization2: weekly activity
p2 <- ggplot(weekly_patterns,
             aes(x = factor(day_of_the_week,
                            levels = c('Sunday','Monday','Tuesday','Wednesday',
                                       'Thursday','Friday','Saturday')),
                 y = avg_steps,
                 group = 1))+
  geom_line(colour = "#00A8E8", linewidth = 1.5) +
  geom_point(colour = "#00A8E8", size = 3) +
  geom_area(fill = "#00A8E8", alpha = 0.2) +
  labs(title = "BELLABEAT INSIGHT: Weekly Activity Patterns",
       x = "Mid-week peak on Wednesdays - perfect for workplace wellness campaigns",
       x = "Day Of The Week",
       y = "Average Steps") +
  theme_minimal()
print(p2)

# Visualization3: Usage Consistency
p3 <- ggplot(usage_consistency,
             aes(x = reorder(usage_frequency, -user_count),
                 y = user_count,
                 fill = usage_frequency)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = user_count), vjust = -0.5, size = 4) +
  labs(title = "BELLABEAT INSIGHT: Device Usage Consistency",
       subtitle = "Most users wear devices regularly - focus on retention features",
       x = "Usage Frequency",
       y = "Number of Users") +
  theme_minimal() +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(p3)

# VISUALIZATION 4: Hourly Activity Patterns
p4 <- ggplot(hourly_activity, 
             aes(x = hour_of_day, y = avg_steps)) +
  geom_col(fill = "#FF6B6B", alpha = 0.8) +
  geom_smooth(method = "loess", color = "#4ECDC4", se = FALSE, size = 1.2) +
  labs(title = "BELLABEAT INSIGHT: Daily Activity Peaks",
       subtitle = "Peak activity at 6-7 PM - perfect for evening reminder campaigns",
       x = "Hour of Day (24-hour)",
       y = "Average Steps") +
  theme_minimal() +
  scale_x_continuous(breaks = seq(0, 23, by = 3))

print(p4)

# 5. CREATE A DASHBOARD VIEW --------------------------------------------------
cat("Creating combined dashboard view...\n")

dashboard <- grid.arrange(p1, p2, p3, p4, ncol = 2,
                          top = "BELLABEAT FITNESS DATA ANALYSIS - Key Insights for Marketing Strategy")

print(dashboard)

# 5. CREATE A DASHBOARD VIEW --------------------------------------------------

dashboard <- grid.arrange(p1, p2, p3, p4, ncol = 2,
                          top = "BELLABEAT FITNESS DATA ANALYSIS - Key Insights for Marketing Strategy")
print(dashboard)

#------------------saving visualizations----------------------------------------
ggsave("bellabeat_user_segmentation.png", p1, width = 10, height = 6, dpi = 300)
ggsave("bellabeat_weekly_patterns.png", p2, width = 10, height = 6, dpi = 300)
ggsave("bellabeat_usage_consistency.png", p3, width = 10, height = 6, dpi = 300)
ggsave("bellabeat_hourly_activity.png", p4, width = 10, height = 6, dpi = 300)
ggsave("bellabeat_dashboard.png", dashboard, width = 12, height = 8, dpi = 300)
