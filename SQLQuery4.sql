--To find out number of Products according to Dosage form of particular Company
select DF, COUNT(DF) as Number_of_products
from Main$ 
where Applicant_Full_Name = 'SUN PHARMACEUTICAL INDUSTRIES INC'
group by DF

--To find out which company has most number of Tablet as dosage form
select top 20 Applicant_Full_Name,(COUNT(DF))as Total_no_of_tablet 
from Main$
where Type='RX' or Type='OTC' and DF ='TABLET'
group by Applicant_Full_Name
order by Total_no_of_tablet DESC 

--How many drug tablets have a "New Drug Application" status?
select top 20 Applicant_Full_Name, (COUNT(DF))as Total_no_of_tablet 
from Main$
where NOT Type='DISCN'and DF ='TABLET' and Appl_Type='N'
group by Applicant_Full_Name
order by Total_no_of_tablet DESC 

--What are the most common dosage forms for approved drugs?
Select top 25  DF, COUNT(DF) as Total_
from Main$
where NOT Type='DISCN'
group by DF
order by Total_ DESC

--What are the various type of Sub dosage forms for approved Tablets
Select top 25  DF_SUB1 as Tablet_Type, COUNT(DF_SUB1) as Total_
from Main$
where NOT Type='DISCN' and DF = 'TABLET' and DF_SUB1 is NOT NULL
group by DF_SUB1
order by Total_ DESC 

--Year vs Number of Approved products which are prescription or OTC
select Year(Approval_Date) as Year, COUNT(Type) as Approved_products
from Date_of_approval$
where NOT Type='DISCN'
group by Year(Approval_Date)
order by Year

--Which company has highest number of approved products for 2023?
select Year(Date_of_approval$.Approval_Date) as Year, COUNT(Date_of_approval$.Type) as Approved_products, Main$.Applicant
from Date_of_approval$ 
inner join Main$
on Main$.ID = Date_of_approval$.ID
where NOT Date_of_approval$.Type='DISCN' and Year(Date_of_approval$.Approval_Date)=2023
group by Year(Date_of_approval$.Approval_Date) , Main$.Applicant
order by Year, Approved_products DESC

--Which company has filled most number of new drug application?
select Main$.Appl_Type, COUNT(Main$.Appl_Type) as Application_count , Main$.Applicant
from Main$
where NOT Main$.Type='DISCN' and Main$.Appl_Type='N'
group by Main$.Appl_Type, Main$.Applicant
order by Application_count DESC

--What Count of each route of approved dosage form?
select	Main$.Route, COUNT(Main$.Route)
from Main$
group by Main$.Route
order by COUNT(Main$.Route) desc

--Which month got most of application?
select Month(Date_of_approval$.Approval_Date) as Month_Name, COUNT(Date_of_approval$.Approval_Date) as DF_Approved
from Date_of_approval$
inner join Main$
on Date_of_approval$.ID = Main$.ID
group by Month(Date_of_approval$.Approval_Date)
order by Month(Date_of_approval$.Approval_Date)

--which month has highest number of FDA application in 2023? 
select Month(Date_of_approval$.Approval_Date) as Month_Name, COUNT(Date_of_approval$.Approval_Date) as DF_Approved
from Date_of_approval$
inner join Main$
on Date_of_approval$.ID = Main$.ID
where YEAR(Date_of_approval$.Approval_Date)=2023
group by Month(Date_of_approval$.Approval_Date)
order by Month(Date_of_approval$.Approval_Date)

--which month a specific company filled most FDA application?
select Month(Date_of_approval$.Approval_Date) as Month_Name, COUNT(Date_of_approval$.Approval_Date) as DF_Approved
from Date_of_approval$
inner join Main$
on Date_of_approval$.ID = Main$.ID
where Main$.Applicant like 'AUROBI%'
group by Month(Date_of_approval$.Approval_Date)
order by Month(Date_of_approval$.Approval_Date)

--Which Products have exclusivity end date in upcoming years?
select YEAR(FDAExclusivity_Date.Exclusivity_Date), COUNT(FDAExclusivity_Date.Appl_No) as Num_of_Products
from FDAExclusivity_Date
inner join Main$
on Main$.Appl_No=FDAExclusivity_Date.Appl_No
where YEAR(FDAExclusivity_Date.Exclusivity_Date) is not null
group by YEAR(FDAExclusivity_Date.Exclusivity_Date)
order by YEAR(FDAExclusivity_Date.Exclusivity_Date)

--Which month has most number of products exculsivity ending in 2023?
select Month(FDAExclusivity_Date.Exclusivity_Date), COUNT(FDAExclusivity_Date.Appl_No) as Num_of_Products
from FDAExclusivity_Date
inner join Main$
on Main$.Appl_No=FDAExclusivity_Date.Appl_No
where Month(FDAExclusivity_Date.Exclusivity_Date) is not null and YEAR(FDAExclusivity_Date.Exclusivity_Date)=2023
group by Month(FDAExclusivity_Date.Exclusivity_Date)
order by Month(FDAExclusivity_Date.Exclusivity_Date)

--Product Number V/s Exclusivity_Code
select Top(50) Count(FDAExclusivity_Date.Appl_No) as Total , FDAExclusivity_Date.Exclusivity_Code
from FDAExclusivity_Date
Where Exclusivity_Code is not null
group by FDAExclusivity_Date.Exclusivity_Code
order by Count(FDAExclusivity_Date.Appl_No) DESC
