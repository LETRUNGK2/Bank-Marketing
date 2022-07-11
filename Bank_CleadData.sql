--Phase 1: Explore dataset
select *from dbo.bank
select day, count(day) from bank
group by day order by 1,2
select contact, count(contact) from (select job from dbo.bank where job = 'admin.')
group by contact
select poutcome,count(poutcome) from dbo.bank
group by poutcome
select deposit,count(deposit) from dbo.bank
group by deposit
select previous,count(previous)from bank group by previous order by previous desc

--Phase 2: Clean Data
--Remove unneeded "." in job column 
	
update bank
set job = replace(job,'.','') from bank

--Join day and month into 1 column called ContactedDate and converted to date format

alter table bank
add ContactedDate Varchar(50);

update bank
set ContactedDate = concat('2020','-',month,'-',day) from bank;

update bank
set ContactedDate = try_convert(date,ContactedDate) from bank

--Remove unneeded column: 
alter table bank
drop column day,month,pdays;
 
--Create Age threshold for our dataset and update 

Alter table bank
add AgeGroup varchar(50)

Update bank
Set AgeGroup = 
 case 
	when age > 18 and age <=25 then '18 to 25'
	when age > 25 and age <=35 then '25 to 35'
	when age > 35 and age <=45 then '35 to 45' 
	when age > 45 and age <=55 then '35 to 55'
	else 'above 50' 
	End  
from bank
where Agegroup is null
--For aggregation purpose, update outcome from yes to '1',no to '0' and convert type 
update bank
set outcome =
case 
when outcome = 'yes' then 1
when outcome = 'no' then 0 
end;
select * From bank

update bank
set outcome = TRY_CONVERT(int,outcome) from bank

alter table Bankmkt
alter column outcome int

-- Rename and change column by using  Object Explorer
-- Drop unneccessary column 

alter table bank
drop column poutcome,previous

-- Phase 3:Analytic questions.

-- 3.1 Let's start by grouping successful outcomes by 
-- 3.1 Cstomer demographic (age,job,marital status and education background)

select agegroup,count(agegroup) as deposit 
from bank
where outcome = '1'  
group by agegroup
order by 2 desc

--3.2 Occupations
with dep1 as 
(select job,count(job) as deposit from bank 
where outcome ='1'
group by job)

select dep1.job,dep1.deposit from dep1 
where dep1.deposit > 500
order by dep1.deposit desc
--Occupation with more than 500 successful term-deposit: Management,technician,blue-collar,admin and retire 

--Marital Status
Select Marital,count(marital) as deposit 
from bank
where outcome = '1'
group by marital
order by 2 desc
--Married customers are more likely to agree on term-deposit 
Select Education, count(Education) as deposit 
from bank
where outcome = '1'
group by Education
order by 2 desc
--Secondary & Tertiary are more likely to make deposit 

--In what month customer likely to agree on term deposit ?
With top10 as (

select month(contacteddate) as Month, count(outcome) as frequency 
from bank	
where outcome = '1'
group by contacteddate
) 
select top10.month,sum(top10.frequency) as top10frequency from top10 
group by top10.month
order by top10frequency desc
-- April to August

--3.2 Customer's Financial Status
--What is the average income, loan status and credit card application of deposit customer?
select housing,loan,credit,count(outcome) as Total from bank
where outcome = '1'
group by loan,credit,housing
order by total desc
