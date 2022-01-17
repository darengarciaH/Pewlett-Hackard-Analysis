# Pewlett-Hackard-Analysis
## Overview
Pewlett Hackard is facing an upcoming "silver tsunami" of employees who are retiring and need to make sure that there are enough retirement-ready employees who can mentor younger and newer generations of PH employees. In this analysis, we obtained lists of retirees per job title and identified employees who would be able to participate in a mentorship program as large numbers of retirees are expected. 
## Results
Here are some of the main results from our analysis:
* The employee data has several caveats: there are duplicate records for the same employee when they are promoted or transfer to a different position within PH. Current employees have a "to date" in the year 9999 to denote this.
* Senior engineers and senior staff make up more than 50,000 of those that are set to retire, which are the positions that will seemingly be affected the most.
* Those currently eligible for the mentorship program are those currently employed and born in 1965.
* Senior engineers and senior staff also seem to make up a considerable portion for the mentorship program, but there seem to be very few eligible compared to those who are about to retire.

![Screen Shot 2022-01-17 at 12 36 28 PM](https://user-images.githubusercontent.com/92702922/149822543-b1892267-5c77-4ef0-b60e-6a7aff9ac9b4.png)

![Screen Shot 2022-01-17 at 12 39 28 PM](https://user-images.githubusercontent.com/92702922/149822846-5581153d-1ef9-47c2-aae9-b8777e2758b4.png)

## Summary
### Silver Tsunami: What This Means for Employment Gaps
According to our query that returns the number of retirement-eligible employees, there are 72,458 employees who are eligible to do so, ranging from senior engineers and senior staff for the most part, but also including engineers, staff, technique leadrs, assistant engineers, and managers. This is likely to cause an employment gap that will be difficult to fill. To ease this sudden burden on PH, it may be best to suggest an option for part-time mentorship positions to these retirement-eligible employees who can mentor younger generations while still enjoying a lighter workload and their well-earned retirement perks.
### Mentorship Eligibility Program: Are There Enough Mentors?
As of now, there seem to be very little mentorship-eligible employees who can train new generations of employees Our query only returns employees who are born in 1965, which totals up to about 1,500 employees: however, they shouldn't be the only cohort ready to train newer employees. This query can be expanded to include employees born after the retirement eligibility period and before 1965 (the retirement eligiblity cutoff) and ranging up to 1965 to get a larger number of available mentors that would still have considerable experience to train younger cohorts. This is what this expanded mentorship eligibility query would look like:
```
-- Mentorship Eligibility, 1956-1965
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
    e.birth_date,
	de.from_date,
	de.to_date,
	tt.title
-- INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS tt
ON (e.emp_no = tt.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1956-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
```
Another query that can give us further insight into the shortcomings from the "silver tsunami" would include current employees who were hired at least 10 years ago, who would also be valuable resources and mentors for younger generations. This slightly younger cohort would have adequate experience to function in mentorship roles and can help younger generations ease into their positions, while also being further away from being retirement-eligible. We can modify our query above to look include employees hired up until 2011:
```
-- Mentorship Eligibility Table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
    e.birth_date,
	de.from_date,
	de.to_date,
	tt.title
-- INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS tt
ON (e.emp_no = tt.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (de.from_date BETWEEN '1980-01-01' AND '2011-12-31')
ORDER BY e.emp_no;
```
