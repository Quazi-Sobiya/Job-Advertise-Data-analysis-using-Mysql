-- [String Functions]
-- a. Write a query to display the job_id, job_title, salary_estimate_min, salary_estimate_max
-- b. Repeat your last query, only this time display only the job adverts where salary_estimate_max is less than 105,000

use job_adverts;

select job_id, job_title, salary_estimate_min, salary_estimate_max
from jobs;

select job_id, job_title,salary_estimate_min, salary_estimate_max
from jobs
where salary_estimate_max< 105000;


-- Write a query to display the company_name, company_rank, company_size_min, and company_size_max
-- for companies with more than 60 employees and less than 120 employees

select distinct company_name, company_rank, company_size_min, company_size_max
from jobs
where company_size_min > 60 and company_size_max < 120;

-- there is employee string in column company size min and max so to remove it we have to use replace

select distinct company_name, company_rank, company_size_min, company_size_max
from jobs
where replace(company_size_min, "Employees",'') > 60 and replace(company_size_max,"Employees",'') < 120;

-- Write a query to display the :
-- a. job_id
-- b. job_title in uppercase
-- c. company_name in lowercase

select job_id, upper(job_title), lower(company_name)
from jobs;

-- Write a query to display the:
-- a. job_id, company_name, headquarters_of_company
-- b. first letter of company_name
-- c. first letter of headquarters_of_company

select job_id, company_name, headquarters_of_company, substring(company_name,1 ,1),
substring(headquarters_of_company,1,1)
from jobs;


-- Write a query to display the :
-- a. job_id
-- b. company_name
-- c. headquarters_of_company
-- d. company_code - a new column containing a concatenation of: the first letter of company_name and the first letter of headquarters_of_company
-- For example : for Google located in Austin, the company_code would be: GA

select job_id, company_name, headquarters_of_company, concat(substring(company_name,1,1),substring(headquarters_of_company,1,1)) as Company_code
from jobs;

-- Repeat your last query, only this time display the company_code in lowercase

select job_id, company_name, headquarters_of_company,lower( concat(substring(company_name,1,1),substring(headquarters_of_company,1,1))) as Company_code
from jobs;

-- Write a query to display the job titles with length greater than 29

select job_title
from jobs
where length(job_title)>29;

-- Write a query to display the:
-- a. company_name
-- b. company_rank
-- c. company_market_value
-- d. company_market_value rounded using ROUND function with precision of 2 digits
-- e. company_market_value rounded down using FLOOR
-- f. company_market_value rounded up using CEIL

select company_name, company_rank, company_market_value, round(company_market_value,2),
floor(company_market_value), ceil(company_market_value)
from jobs;


                                                              -- Part 2

-- Write a query to display the job_id, job_title, published_date, and removed_date for all jobs that were published on 2016

select job_id, job_title, published_date, removed_date
from jobs
where year(published_date)="2016";

-- Which job adverts were posted during January 2017 ? Display columns you consider relevant

select job_id, job_title, published_date, removed_date
from jobs
where year(published_date)="2017"  and month(published_date)="01";

-- Which job adverts were removed after a single day ?

select job_id, job_title, published_date, removed_date
from jobs
where datediff(removed_date,published_date)=1 ;

-- Which job adverts were posted on the same day and month as the current date ?
-- For example, if today is February 11th 2021, which jobs were published on February 11th (regardless the year) ?

select job_id, job_title, published_date, removed_date
from jobs
where month(published_date)=month(curdate()) and day(published_date)=day(curdate());

-- In a few job adverts, the value of published_date is greater than the removed_date,  those rows represent invalid data.

select job_id, job_title , published_date, removed_date
from jobs
where
removed_date<published_date;

-- List the job adverts where at least one of the following conditions is met:
-- a. The row does not contain a value in removed_date
-- b. The row does not contain a value in company_name
-- c. The row does not contain a value in headquarters_of_company

select job_id , job_title, removed_date,  headquarters_of_company
from jobs
where removed_date is null
or company_name is null
or headquarters_of_company is null;

-- Take your previous report and instead of the NULL values:
-- a. Display the current date instead of NULL values in removed_date
-- b. Display the company_state instead of NULL values in headquarters_of_company
-- c. Display 'Not Available' instead of NULL values in company_name

select job_id, job_title,
ifnull(removed_date, curdate()) as removed_date,
ifnull(headquarters_of_company, state_of_company) as headquarters_of_company ,
ifnull(company_name, "Not Available") as company_name
from jobs;


-- Write a query to display the company_name, company_market_value, and a new column : company_market_value_rank, based on the following logic:
-- a. For companies with market_value in the range of 0-300 provide the rank : 'low range'
-- b. For companies with market_value in the range of 301-600 provide the rank : 'mid range'
-- c. For companies with market_value in the range of 601-900 provide the rank : 'high range'
-- d. For any other range provide the rank : 'other range'

select company_name, company_market_value,
case
when company_market_value between 0 and 300 then "low range"
when company_market_value between 301 and 600 then "mid range"
when company_market_value between 601 and 900 then "high range"
else "other range"
end as company_market_value_rank
from jobs;

-- Write a query to display the job_title, company_name, company_size_min, company_size_max, and a new column - company_size, based on the following logic:
-- a. For companies with up to 60 employees, provide the value: ‘Small Company’
-- b. For companies with up to 120 employees, provide the value: ‘Medium Company’
-- c. For companies with up to 180 employees, provide the value: ‘ Large Company’
-- d. For any other range 'Unknown'

select job_title, company_name, company_size_min, company_size_max,
case 
when company_size_max <= 60 then "small company"
when company_size_max <= 120 then "medium company"
when company_size_max <=  180 then "large company"
else "Unkown"
end as company_size
from jobs; 

select company_size_min, replace(company_size_min, ' Employees','') as company_size
from jobs;


