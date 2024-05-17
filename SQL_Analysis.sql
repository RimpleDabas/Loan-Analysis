--Check if all data imported
SELECT * FROM bank_loan_data;
-- Total loan applications count the ids basically
SELECT COUNT(id) AS Total_loan_applications
FROM   bank_loan_data

-- To make this dynamic add max function
SELECT COUNT(id) AS MTD_Total_loan_applications
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 12) AND (YEAR(issue_date) = 2021)

SELECT COUNT(id) AS PMTD_MTD_Total_loan_applications
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 11) AND (YEAR(issue_date) = 2021)

--(MTD-PMTD)/PMTD

-- loan amount in last month
SELECT SUM(loan_amount) AS MTD_MTD_Total_funded_amount
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 12) AND (YEAR(issue_date) = 2021)

SELECT SUM(loan_amount) AS PMTD_MTD_Total_funded_amount
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 11) AND (YEAR(issue_date) = 2021)

SELECT SUM(total_payment) AS Total_Amount_received
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 12) AND (YEAR(issue_date) = 2021)
-- 
SELECT ROUND(AVG(int_rate), 4) * 100 AS Avg_interest_rate
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 12) AND (YEAR(issue_date) = 2021)


SELECT ROUND(AVG(int_rate),4) * 100 AS Prev_Avg_interest_rate  FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--Lenders prefer less than 35% it is debt to income ratio
/* */
SELECT ROUND(AVG(dti), 4) * 100 AS Avg_dti
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 12) AND (YEAR(issue_date) = 2021)

SELECT ROUND(AVG(dti),4) * 100 AS PMTD_Avg_dti  FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


-- Good loan percentages

SELECT COUNT(CASE WHEN loan_status = 'Fully Paid' OR
             loan_status = 'Current' THEN id END) * 100 / COUNT(id) AS Good_loan_percentage
FROM   bank_loan_data

-- good loan total

SELECT COUNT(id) AS Good_loan_applications
FROM   bank_loan_data
WHERE (loan_status = 'Fully Paid') OR
             (loan_status = 'Current')


--good loan funded amount
SELECT SUM(loan_amount) AS Good_loan_funded
FROM   bank_loan_data
WHERE (loan_status = 'Fully Paid') OR
             (loan_status = 'Current')


SELECT SUM(total_payment) AS Good_loan_amount_received
FROM   bank_loan_data
WHERE (loan_status = 'Fully Paid') OR
             (loan_status = 'Current')


-- Bad loans analysis

SELECT COUNT(CASE WHEN loan_status = 'Charged Off' 
	THEN id END) * 100 / COUNT(id) AS Bad_loan_percentage
FROM   bank_loan_data



SELECT COUNT(id) AS bad_loan_applications
FROM   bank_loan_data
WHERE (loan_status = 'Charged Off') 
             

--bad loan funded amount
SELECT SUM(loan_amount) AS bad_loan_funded
FROM   bank_loan_data
WHERE (loan_status = 'Charged Off') 
            
-- Amount received
SELECT SUM(total_payment) AS bad_loan_amount_received
FROM   bank_loan_data
WHERE (loan_status = 'Charged Off') 


-- getting the grids

SELECT loan_status, COUNT(id) AS Total_loan_applications, SUM(total_payment) AS Total_Amount_Received, SUM(loan_amount) AS Total_Funded_Amount, AVG(int_rate * 100) AS Interest_Rate, AVG(dti * 100) AS DTI
FROM   bank_loan_data
GROUP BY loan_status;



SELECT loan_status,  SUM(total_payment) AS MTD_Total_Amount_Received, SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM   bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;
-- based on months performence
SELECT
	MONTH(issue_date) AS Month_Number,
	DATENAME(MONTH, issue_date) AS Month_Name,
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_funded_amount, 
	SUM(total_payment) AS Total_Received_amount
FROM   bank_loan_data
GROUP BY MONTH(issue_date),DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

-- based on address state

SELECT
	address_state,
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_funded_amount, 
	SUM(total_payment) AS Total_Received_amount
FROM   bank_loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC;

--based on term

SELECT
	term,
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_funded_amount, 
	SUM(total_payment) AS Total_Received_amount
FROM   bank_loan_data
GROUP BY term
ORDER BY term;


--based on the emp length (how much time has the person been working in the company)

SELECT
	emp_length,
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_funded_amount, 
	SUM(total_payment) AS Total_Received_amount
FROM   bank_loan_data
GROUP BY emp_length
ORDER BY COUNT(id) DESC;

--based on the purpose

SELECT
	purpose,
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_funded_amount, 
	SUM(total_payment) AS Total_Received_amount
FROM   bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC;

--based on the home ownership

SELECT
	home_ownership,
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_funded_amount, 
	SUM(total_payment) AS Total_Received_amount
FROM   bank_loan_data
WHERE grade = 'A' AND address_state = 'CA'
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;

