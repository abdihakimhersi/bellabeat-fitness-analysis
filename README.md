# bellabeat-fitness-analysis
Case study for Google Data Analytics Certificate - Analysing Fitbit data to provide marketing insights for Bellabeat
# Bellabeat Fitness Data Analysis

## Case Study for Google Data Analytics Certificate

### Business Task
Analyze Fitbit smart device usage data to identify trends and provide marketing strategy recommendations for Bellabeat's products.

### Data Sources
- **FitBit Fitness Tracker Data** (Kaggle)
- 33 users, March-April 2016
- Includes: daily activity, sleep, heart rate, steps

### Data Cleaning & Processing
- SQL queries in BigQuery for data aggregation
- Date/time parsing for consistent formatting
- Data joins for comprehensive analysis

### Key Insights

#### 1. User Activity Segmentation
![User Segmentation](visualizations/bellabeat_user_segmentation.png)
- **Finding**: The largest user segment are sedentary 
- **Implication**: Marketing should target the everyday woman who wants to improve her wellness gradually

#### 2. Weekly Activity Patterns  
![Weekly Patterns](visualizations/bellabeat_weekly_patterns.png)
- **Finding**: Peak activity on Wednesdays
- **Implication**: Ideal for mid-week wellness campaigns

#### 3. Device Usage Consistency
![Usage Consistency](visualizations/bellabeat_usage_consistency.png)
- **Finding**: Majority of the users use there device regularly
- **Implication**: Focus on retention features

### 4. Hourly Activity Patterns
![Hourly Activity](visualizations/bellabeat_hourly_activity.png)
- **Finding**: Activity peaks around 6-7pm
- **Implication**: Develop evening-focused wellness content

## 5. Dashboard
![bellabeat Dashboard](visualization/bellabeat_dashboard.png)

### Recommendations for Bellabeat
1. **Target mid-week engagement** with Wednesday wellness challenges
2. **Focus on sedentary users** with tailored messaging
3. **Leverage peak hours** (6-7 PM) for reminder notifications
4. **Emphasize sleep tracking** as a key differentiator

### Tools Used
- **SQL**: BigQuery for data analysis
- **R**: ggplot2 for visualizations
- **GitHub**: Portfolio presentation

### Files
- [`scripts/sql_queries.sql`](scripts/sql_analysis_queries.sql): Complete analysis queries
- [`scripts/r_analysis.R`](scripts/r_data_visualization.R) Visualization code
- [`data/`](data/): Processed datasets
- [`visualizations/`](visualizations/) All charts and graphs
