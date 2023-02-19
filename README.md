# Bellabeat-Data-Analysis
Analysis of Fitbit data to gain insights into consumer usage and make recommendations to Bellabeat


## Case study – How Can a Wellness Company Play It Smart?
Company – Bellabeat: a high-tech manufacturer of health-focused products for women. They are a successful small company but have potential to become a larger player in the global smart device market

My Role – Junior Data Analyst (Joined 6 months ago) on the marketing analyst team

Task – Focus on one of Bellabeat’s products and Analyanalyze smart device data to gain insight into how customers are using their smart devices

Present analysis and high-level recommendations to the executive team

## Summary of Business Task
Bellabeat is a high-tech manufacturing company, founded in 2013 that manufactures health-focused smart products.  The company seeks more opportunities for growth and expansion. The task is to use existing data (Fitbit Fitness Tracker Data) on the use of smart devices and gain insight into consumer usage. These insights are then to be applied to one of Bellabeat products in order to provide high-level recommendations to improve their market strategy
Stakeholders
•	Urška Sršen - Bellabeat cofounder and Chief Creative Officer
•	Sando Mur - Bellabeat cofounder and key member of Bellabeat executive team
•	Bellabeat Marketing Analytics team


### Data source

The dataset (Fitbit Fitness Tracker Data) used for this analysis is a public dataset made available through [Mobius](https://www.kaggle.com/datasets/arashnic/fitbit) on Kaggle 
We were provided with 18 data sets in csv files. These data were collected from thirty-three eligible fitbit users, from 12th April 2016 to 12th May 2016. Three of the datasets (Daily_activity_merged), SleepDay_merged, Weightinfo were used for analysis. These files were stored in a folder on the computer 
The data may not be free of bias as the sample size (thirty-three) may not be a good representation of the population of women who use fitbit. Also, the data does not give information on the demographics of the participants such as Age and Ethnicity
Considering the limitations of the dataset, additional datasets may be needed for better analysis and inference towards improving the market strategy of Bellabeat

### Data Cleaning and Manipulation

First, copies of the original datasets to work on were made, instead of editing the original. This way, the original copies remain in their format and can be available for reference. Files were renamed to desired names following standard naming conventions.
For the entire project, three tools were used - Google sheets, SQL and R 

### GoogleSheet

Considering the small size of the dataset, it was easy checking and cleaning up the data using google sheet. At this stage, data types were checked for correctness, white spaces were also checked using the TRIM function. Date and time columns were changed into date columns as for analysis

The 3 datasets that used are:
-	SleepDay_merged
-	WeightLoginfo_merged
-	dailyActivity_merged

Each column was checked for errors 
-	Columns D (Total Distance) and Column E (Tracker Distance) should be the same values, but this is not the case for 15 entries from 2 individuals. This may have to do with manual entry of data or a bug with the tracker
-	TotalDistance (column D) should be the sum of columns H, I, J, K. This is correct for all entries but incorrect when compared with the tracker distance (column E) for the 2 flagged IDs ( 6962181067 and 7007744171). As such, Total Distance and not TrackerDistance was used for the analysis
-	We expected that if active distance is zero, active minutes should at least be a few minutes. There are cases of very active minutes of 46, 33, 58, 102 with the active distance is zero, meaning movement without distance? This may just have to do with the set up and configuration or interpretation of the device. It triggers several questions with clarifications needed on how the app works

### SQL

3 datasets were uploaded into big query for merging. Schema for each table was automatically detected. 
Number of users in each dataset was checked
The datasets were joined to create a new dataset called WellnessDataMerged

#### SQL query to merge datasets
 ![image](https://github.com/LaurettaNg/Bellabeat-Data-Analysis/blob/main/images/SQL%20Query%20to%20Merge%20datasets.jpg?raw=true)

#### Schema of the merged dataset
![image](https://github.com/LaurettaNg/Bellabeat-Data-Analysis/blob/main/images/Merged_Data%20Schema.jpg?raw=true)

All SQL queries used in the analysis can be found [here](https://github.com/LaurettaNg/Bellabeat-Data-Analysis/blob/main/queries.sql)

Merged dataset was then checked against against the individual dataset to ensure data was correctly merged 

Dataset was further explored for more insights, giving answers to the following questions:

1.	How many day entries did individual’s sleep for longer than 8 hours (480 mins)
2.	How many day entries did individual’s sleep for less than 5 hours (300 mins)
3.	How many day entries did individual’s sleep for between 5 and 8 hours?
4.	Is the sum of the individual distance categories equal to the Total Distance?
5.	What is the ratio of TimeAsleep to TotalTimeInBed i.e what percentage of time spent in bed was the individual in sleep mode?
6.	Based on CDC interpretation,
    ![image](https://github.com/LaurettaNg/Bellabeat-Data-Analysis/blob/main/images/BMI%20.jpg?raw=true)
    - What percentage of the BMI entries is in the healthy range?
    - What percentage of the BMI entries is considered underweight (i.e below 18.5)?
    - What percentage of the BMI entries is considered overweight (i.e above 24.9)?
7.	 Is the sum of the individual time categories equal to the Total   Time? Note that the total time recorded should not exceed 1440 mins (24 hours) for a day

### R

Merged data was then loaded into R for summary statistics and visualization

#### Relationship between TotalSteps and TotalDistance
![image](https://github.com/LaurettaNg/Bellabeat-Data-Analysis/blob/main/images/TotalSteps%20vs%20TotalDistance.png?raw=true)

#### Relationship between TotalSteps and Calories
![image](https://github.com/LaurettaNg/Bellabeat-Data-Analysis/blob/main/images/TotalSteps%20vs%20Calories.png?raw=true)

#### Relationship between TotalDistance and Calories
![image](https://github.com/LaurettaNg/Bellabeat-Data-Analysis/blob/main/images/TotalDistance%20vs%20Calories.png?raw=true)

---

### Summary
 Average total steps per day was 7,652
 Average total distance covered daily was 5.5km
 The average longest distance was covered in the 'light active' category
 The longest distance was covered in the 'very active' category
 Average time spent being sedentary was 1,057 minutes
 Maximum estimated energy expenditure was 4,900kcal with an average of 2,308kcal
 Time range for sleep daily was 1 hr to 13.3 hrs
 Individuals record 50% to 99% of their TotalTimeInBed in Sleep mode
 Minimum and Maximum recorded weight in kg were 52.60 and 133.50 respectively, with an average of 72.04
 BMI (Body Mass Index) ranged from 21.45 to 47.54. According to CDC, 50% of the BMI entries would be considered  healthy weight (18.5 - 24.9) while 50% would be considered overweight (25.0 - 29.9)

 ### Questions/Concerns on data
 Ideally, the sum of TotalTimeInBed, VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes and SedentaryMinutes  should be 1440mins (24 hours). However,the sum of time for 157 entries exceeded 1440 mins  
 There seems to be a bug in app, or data entered manually incorrectly,Where sedentary minutes is 1440 mins (a whole day), but records quite high calories burnt  
 
 We expected that if active distance is zero, active minutes should at least be a few minutes. There are cases of very active minutes of 46, 33, 58, 102 with the active distance is zero, meaning movement without distance? This may just have to do with the set up and configuration or interpretation of the device. It triggers several questions with clarifications needed on how the app works

 ### Recommendations for Bellabeat
Upon exploring and analyzing the Fitbit tracker data, the major recommendation would be that Bellabeat devices and app be programmed in such a way that very accurate data is collected. The more accurate the data, the more insights users can draw from their lifestyle habits and make necessary improvements if required. Bad data will always lead to bad/incorrect conclusions. In the light of this, the following are suggested:
Demographics: It would be great for the Bellabeat app to take record of specific demographics of the users such as Gender, Age, Ethnicity, Worklife etc. This will form a better basis for interpreting data and avoiding some level of bias. 
Device Sync: It is very important that the Bellabeat devices have seamless sync with the Bellabeat app. This would ensure accuracy of data compilations and storage. We would also suggest working this out in such a way to avoid manual data entry by users to reduce human error.

Goal setting: Considering that the main goal of the Bellabeat app and devices is to help users develop more healthy lifestyle habits for better health, users could have the opportunity to set target goals and measure how close or far they are from achieving set goals. It could also be beneficial to users to have threshold checks in place for when users exceed the healthy thresholds for their peculiar health and wellness status. 

Thank you for your interest in the Bellabeat case Study!
