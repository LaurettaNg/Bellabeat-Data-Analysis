# Analysis of Fitbit data in R

```
title: "Bellabeat Case Study"
author: "Lauretta Ngere"
date: "2023-02-13"
output: html_document
```

---


## Setting up my environment
Note: Setting up my R environment by loading the necessary packages

```{r}
install.packages("tidyverse")
library(tidyverse)
install.packages("skimr")
library(skimr)
install.packages("ggplot2")
library(ggplot2)
install.packages("janitor")
library(janitor)
library(lubridate)
```
## Importing the merged dataset
Note : Activity, Sleep and Weight data were merged (Wellness_data) using sql

```{r}
Wellness <- read.csv("C:\\Users\\Owner\\Documents\\Courses\\Coursera\\Google Data Analytics Professional Certrificate\\Capstone Projects\\CASE STUDIES\\Case Study 2\\DATA\\Wellness_data.csv")
```

## An overview of the dataset

```{r }
View(Wellness)
head (Wellness)
n_distinct(Wellness$Id)
colnames(Wellness)
str(Wellness)
```

## Summary statistics of the dataset
Note : Summary statistics of various categories of the dataset

### Total Steps and Distance

```{r }
Wellness %>%  
  select(TotalSteps, TotalDistance) %>%
  summary()
```

### Distance Intensity

```{r}
Wellness %>%  
  select(VeryActiveDistance, ModeratelyActiveDistance, LightActiveDistance, SedentaryActiveDistance)%>%
  summary()
```

### Time

```{r}
Wellness %>%  
  select(VeryActiveMinutes , FairlyActiveMinutes , LightlyActiveMinutes, SedentaryMinutes)%>%
  summary()
```

### Calories

```{r}
Wellness %>%  
  select(Calories)%>%
  summary()
```

### Sleep

```{r}
Wellness %>%  
  select(TotalMinutesAsleep,TotalTimeInBed)%>%
  summary()
```

### Weight and BMI

```{r}
Wellness %>%  
  select(WeightKg ,BMI )%>%
  summary()
```

## Visualizations

Note : Relationships between variables were explored using plots

### Plot of TotalSteps and TotalDistance

```{r}
ggplot(data = Wellness) + geom_point(mapping = aes(x = TotalSteps, y = TotalDistance))+
geom_smooth(mapping = aes(x = TotalSteps, y = TotalDistance))+
labs(title = "Fitbit Fitness Tracker Data", subtitle = "TotalSteps vs TotalDistance")
```

A positive correlation was seen between the TotalSteps and TotalDistance as expected.    

###  Plot of TotalSteps vs Calories

```{r}
ggplot(data = Wellness) + geom_point(mapping = aes(x = TotalSteps, y = Calories))+ 
geom_smooth(mapping = aes(x = TotalSteps, y = Calories))+
labs(title = "Fitbit Fitness Tracker Data", subtitle = "TotalSteps vs Calories")
```

A positive correlation was seen between TotalSteps and Calories. It is expected that the more active individuals are, the more calories they shopuld burn. 
### Plot of TotalDistance vs Calories

```{r}
ggplot(data = Wellness) + geom_point(mapping = aes(x = TotalDistance, y = Calories)) + geom_smooth(mapping = aes(x = TotalDistance, y = Calories))+
labs(title = "Fitbit Fitness Tracker Data", subtitle = "TotalDistance vs Calories")
```



