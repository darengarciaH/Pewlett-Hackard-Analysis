-- Retirement Titles
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    tt.title, 
	tt.from_date,
	tt.to_date	
INTO retirement_titles
FROM employees as e
RIGHT JOIN titles as tt
ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

-- Current Retirement Titles
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt 
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no ASC, rt.to_date DESC;

-- Retiring Title Count
SELECT COUNT(ut.title)
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title)

-- Mentorship Eligibility Table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
    e.birth_date,
	de.from_date,
	de.to_date
	tt.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS tt
ON (e.emp_no = tt.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');
ORDER BY e.emp_no


