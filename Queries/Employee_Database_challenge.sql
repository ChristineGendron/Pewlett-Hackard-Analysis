--creating table showing titles of all employees eligible for retirement 

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
--INTO retirement_titles
FROM employees as e
	INNER JOIN titles as ti
	ON (e.emp_no = ti.emp_no)
		WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
		ORDER BY e.emp_no;

-- removing duplicate employees to show only the current title of each eligible employee

SELECT DISTINCT ON (emp_no)
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles 
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- get number of employees by their most recent job title who are about to retire

SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

--create a mentorship eligibility table

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility 
FROM employees AS e
	INNER JOIN dept_emp as de
		ON e.emp_no = de.emp_no
	INNER JOIN titles as ti
		ON e.emp_no = ti.emp_no
			WHERE de.to_date = '9999-01-01'
			and e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'			
ORDER BY e.emp_no;

--New Query #1 for Analysis - finding total number of retirees

SELECT SUM(count)
FROM retiring_titles

--New Query #2 for Analysis - creating table for count of mentorship roles


SELECT COUNT(title), title
INTO mentor_count
FROM mentorship_eligibility
GROUP BY title

