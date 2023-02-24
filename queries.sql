-- Check the number of users in each dataset
SELECT 
    COUNT(DISTINCT Id) AS Num_of_Id
FROM `wellness-case-study-377401.Wellness_data.Activity`;
--33

SELECT 
    COUNT(DISTINCT Id) AS Num_of_Id
FROM `wellness-case-study-377401.Wellness_data.Sleep` ;
--24

SELECT 
    COUNT(DISTINCT Id) AS Num_of_Id
FROM `wellness-case-study-377401.Wellness_data.Weight` 
--8


-- Query to join the 3 tables
CREATE OR REPLACE TABLE `wellness-case-study-377401.Wellness_data.WellnessDataMerged` AS
SELECT 
    Activity.*,
    Sleep.TotalMinutesAsleep, 
    Sleep.TotalTimeInBed,
    Weight.WeightKg,
    Weight.WeightPounds,
    Weight.BMI
FROM `wellness-case-study-377401.Wellness_data.Activity` AS Activity
LEFT JOIN `wellness-case-study-377401.Wellness_data.Sleep` AS Sleep
ON Activity.Id = Sleep.Id
AND Activity.ActivityDate = Sleep.SleepDay
LEFT JOIN `wellness-case-study-377401.Wellness_data.Weight` AS Weight
ON Activity.Id = Weight.Id
AND Activity.ActivityDate = Weight.Date


-- Check the merged dataset against the individual datasets
SELECT 
    count(BMI) 
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` ;

SELECT 
    count(BMI)  
FROM `wellness-case-study-377401.Wellness_data.Weight` ;

SELECT 
    avg(TotalMinutesAsleep)  
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` ;

SELECT 
    avg(TotalMinutesAsleep)  
FROM `wellness-case-study-377401.Wellness_data.Sleep` ;

SELECT 
    count(TotalTimeInBed)  
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 

SELECT 
    count(TotalTimeInBed)  
FROM `wellness-case-study-377401.Wellness_data.Sleep` ;

SELECT
     avg(WeightPounds)  
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 

SELECT 
    avg(WeightPounds)  
FROM `wellness-case-study-377401.Wellness_data.Weight`;

SELECT 
    avg(WeightKg)  
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 

SELECT
     avg(WeightKg)  
FROM `wellness-case-study-377401.Wellness_data.Weight`;

SELECT 
    count(distinct BMI)  
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` ;

SELECT 
    count(distinct BMI)  
FROM `wellness-case-study-377401.Wellness_data.Weight` ;

SELECT 
    count(distinct TotalMinutesAsleep)  
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 

SELECT 
    count(distinct TotalMinutesAsleep)  
FROM `wellness-case-study-377401.Wellness_data.Sleep` ;

SELECT 
    count(distinct TotalTimeInBed)  
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 

SELECT 
    count(distinct TotalTimeInBed)  
FROM `wellness-case-study-377401.Wellness_data.Sleep` ;

SELECT 
    count(distinct WeightPounds)  
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` ;

SELECT
     count(distinct WeightPounds)  
FROM `wellness-case-study-377401.Wellness_data.Weight`;

SELECT 
    count (distinct WeightKg)  
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` ;

SELECT 
    count ( distinct WeightKg)  
FROM `wellness-case-study-377401.Wellness_data.Weight`;


--How many day entries did individual’s sleep for longer than 8 hours (480 mins)
SELECT * 
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 
WHERE TotalMinutesAsleep > 480
--115 days


--How many day entries did individual’s sleep for less than 5 hours (300 mins)
SELECT * 
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 
WHERE TotalMinutesAsleep < 300
--50 days


--How many day entries did individual’s sleep for between 5 and 8 hours?
SELECT *
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 
WHERE TotalMinutesAsleep between 300 and 480
--248 days, 530 had no total sleep entries


--Is the sum of the individual distance categories equal to the Total Distance?
--i.e Total Distance = VeryActiveDistance + ModeratelyActiveDistance + LightActiveDistance + SedentaryActiveDistance 
SELECT 
    TotalDistance, VeryActiveDistance, ModeratelyActiveDistance,
    LightActiveDistance, SedentaryActiveDistance, 
    (VeryActiveDistance + ModeratelyActiveDistance + LightActiveDistance + SedentaryActiveDistance) AS SumDistance
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 
WHERE TotalDistance - (VeryActiveDistance + ModeratelyActiveDistance + LightActiveDistance + SedentaryActiveDistance) > 1
--13 entries where the sum of the distance categories was greater than the recorded TotalDistance


--What is the ratio of TimeAsleep to TotalTimeInBed i.e what percentage of time spent in bed was the individual in sleep mode?
--i.e what percentage of time spent in bed was the individual in sleep mode?
SELECT 
    Id, ActivityDate, TotalMinutesAsleep, TotalTimeInBed, 
    (TotalMinutesAsleep/TotalTimeInBed) AS SleepBedRatio
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 
--	Individuals recorded 50% to 99% of their TotalTimeInBed in Sleep mode. 


-- What percentage of the BMI entries is in the healthy range?
SELECT 
    Id, ActivityDate, WeightKg, BMI
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 
WHERE BMI between 18.5 and 24.9 
--34 entries out of 68 which is 50%


--What percentage of the BMI entries is considered underweight ( i.e below 18.5)?
SELECT 
    Id, ActivityDate, WeightKg, BMI
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 
WHERE BMI < 18.5
--0


--What percentage of the BMI entries is considered overweight (i.e above 24.9)?
SELECT 
    Id, ActivityDate, WeightKg, BMI
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 
WHERE BMI > 24.9
-- 33 entries out of 68 which is 50%


--Is the sum of the individual time categories equal to the Total Time?
--Note that the total time recorded should not exceed 1440 mins (24 hours) for a day
SELECT 
    Id, ActivityDate, VeryActiveMinutes, FairlyActiveMinutes,
    LightlyActiveMinutes, SedentaryMinutes, TotalTimeInBed,
    (TotalTimeInBed + VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes) AS TotalTime
FROM `wellness-case-study-377401.Wellness_data.WellnessDataMerged` 
WHERE TotalTimeInBed + VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes > 1440
--157 entries exceeded 24 hours


