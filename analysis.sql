/*
Project: Exploring Trends in American Baby Names (DataCamp)
*/

-- ============================================================
-- 1) name_types
-- ============================================================

/*
Goal:
List the first five names in alphabetical order and find out if each name is "Classic" or "Trendy."

Output:
- first_name
- total_births
- popularity_type
*/

SELECT first_name,
	SUM(num) AS total_births,
	CASE
		WHEN COUNT(year) > 50 THEN 'Classic'
		ELSE 'Trendy'
		END AS popularity_type
FROM baby_names
GROUP BY first_name
ORDER BY first_name
LIMIT 5;

-- ============================================================
-- 2) top_20
-- ============================================================

/*
Goal:
Identify the top 20 male names overall and analyze how the name Paul ranks.

Output:
- name_rank
- first_name
- total_births
*/

SELECT
	RANK() OVER (ORDER BY SUM(num) DESC) AS name_rank,
	first_name,
	SUM(num) AS total_births
FROM baby_names
WHERE sex = 'M'
GROUP BY first_name
ORDER BY name_rank
LIMIT 20;

-- ============================================================
-- 3) a_names
-- ============================================================

/*
Goal:
Identify which female names appeared in both 1920 and 2020.

Output:
- first_name
- total_occurrences
*/

SELECT a.first_name,
	(a.num + b.num) AS total_occurrences
FROM baby_names AS a
INNER JOIN baby_names AS b
ON a.first_name = b.first_name
WHERE a.year = 1920 AND a.sex = 'F'
	AND b.year = 2020 AND b.sex = 'F'
ORDER BY first_name;
