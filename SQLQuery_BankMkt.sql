--Phase 1: Explore dataset

select *from dbo.bankmkt 

select day, count(day) from dbo.bankmkt
group by day order by 1,2
select contact, count(contact) from (select job from dbo.bankmkt where job = 'admin.')
group by contact
select poutcome,count(poutcome) from dbo.bankmkt
group by poutcome
select deposit,count(deposit) from dbo.bankmkt
group by deposit
select previous,count(previous)from bankmkt group by previous order by previous desc

--Phase 2: Clean Data
--1. Remove unneeded "." in job column 
	
update bankmkt
set job = replace(job,'.','') from bankmkt;

--2. Join day and month into 1 column called ContactedDate and converted to date format

alter table bankmkt
add ContactedDate Varchar(50)

update bankmkt 
set ContactedDate = concat('2020','-',month,'-',day) from bankmkt

update bankmkt
set ContactedDate = try_convert(date,ContactedDate) from bankmkt

--Remove unneeded column: 
alter table bankmkt
drop column day,month,pdays
 
--4. Create customer id into dataset by add random value 
alter table bankmkt
add ID int

update bankmkt
set ID = abs(checksum(NewId()) % 10000)
where ID IS NULL
select count(ID) FROM bankmkt

--5.Create Age Threshold for our dataset and update 

Alter table bankmkt 
add AgeGroup varchar(50)

Update bankmkt
Set AgeGroup = 
 case 
	when age > 18 and age <=25 then '18 to 25'
	when age > 25 and age <=35 then '25 to 35'
	when age > 35 and age <=45 then '35 to 45' 
	when age > 45 and age <=55 then '35 to 55'
	else 'above 50' 
	End  
from bankmkt 
where Agegroup is null

-- Rename and change column by using  Object Explorer
-- Drop unneccessary column 

alter table bankmkt 
drop column age

-- Phase 3:Analytic questions.

-- 3.1 Let's start by grouping successful outcomes by 
-- 3.1 uCstomer demographic (age,job,marital status and education background)

select agegroup,count(agegroup) as deposit 
from bankmkt 
where outcome = 'yes'  
group by agegroup
order by 2 desc
--Agegroup 25 to 35 and 35 to 45 are more likely to agree on term deposit 

--Occupations
with dep1 as 
(select job,count(job) as deposit from bankmkt 
where outcome ='yes'
group by job)

select dep1.job,dep1.deposit from dep1 
where dep1.deposit > 500
order by dep1.deposit desc
--Occupation with more than 500 successful term-deposit: Management,technician,blue-collar,admin and retire 

--Marital Status
Select Marital, count(marital) as deposit 
from bankmkt
where outcome = 'yes'
group by marital
order by 2 desc
--Married users are more likely to agree on term-deposit 

--Education background 
Select Education, count(Education) as deposit 
from bankmkt
where outcome = 'yes'
group by Education
order by 2 desc
--Secondary & Tertiary are more likely to make deposit 

--In what month customer likely to agree on term deposit ?
With top10 as (

select month(contacteddate) as Month, count(outcome) as frequency 
from bankmkt	
where outcome = 'yes'
group by contacteddate
) 
select top10.month,sum(top10.frequency) as top10frequency from top10 
group by top10.month
order by top10frequency desc
-- April to August

--3.2 Customer's Financial Status
--What is the average income, loan status and credit card application of deposit customer?
select housing,loan,credit,avg(balance) as avgbal from bankmkt 
where outcome = 'yes'
group by loan,credit,housing
order by avgbal desc

--3.3 Retarget effort: call duration, number of attempts

select avg(NumberofCalls_PCmp) Avg_Retarget_Call,count(outcomes_pcamp) as Retarget_Success
from bankmkt
where outcome = 'yes' and Outcomes_PCamp ='success'


