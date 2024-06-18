SELECT * FROM bank_loan_data;
SELECT COUNT(id) AS Total_loan_applications
FROM   bank_loan_data;

SELECT COUNT(id) AS MTD_Total_loan_applications
FROM   bank_loan_data

WHERE (MONTH(issue_date) = 12) AND (YEAR(issue_date) = 2021)
SELECT COUNT(id) AS PMTD_MTD_Total_loan_applications
FROM   bank_loan_data

WHERE (MONTH(issue_date) = 11) AND (YEAR(issue_date) = 2021)
SELECT SUM(loan_amount) AS MTD__Total_funded_amount
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 12) AND (YEAR(issue_date) = 2021)

SELECT SUM(loan_amount) AS PMTD_MTD_Total_funded_amount
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 11) AND (YEAR(issue_date) = 2021)

SELECT SUM(total_payment) AS Total_Amount_received
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 12) AND (YEAR(issue_date) = 2021)
-- 
SELECT FORMAT(ROUND(AVG(int_rate), 2) ,'P') AS Avg_interest_rate
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 12) AND (YEAR(issue_date) = 2021)


SELECT FORMAT(ROUND(AVG(int_rate), 2) ,'P') AS Prev_Avg_interest_rate  FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--Lenders prefer less than 35% it is debt to income ratio
/* */
SELECT FORMAT(ROUND(AVG(dti), 2) ,'P') AS Avg_dti
FROM   bank_loan_data
WHERE (MONTH(issue_date) = 12) AND (YEAR(issue_date) = 2021)

SELECT FORMAT(ROUND(AVG(dti), 2) ,'P') AS PMTD_Avg_dti  FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

SELECT loan_status, 
COUNT(id) AS Total_loan_applications,
SUM(total_payment) AS Total_Amount_Received, 
SUM(loan_amount) AS Total_Funded_Amount,
FORMAT(AVG(int_rate ) ,'P')AS Interest_Rate, 
FORMAT(AVG(dti ),'P') AS DTI
FROM   bank_loan_data
GROUP BY loan_status;

-- based on months performance
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