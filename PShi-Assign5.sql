# Question 1 
SELECT quantityOnHand
FROM item
WHERE itemDescription = 'bottle of antibiotics';

# Question 2 
SELECT volunteerName
FROM volunteer
WHERE volunteerTelephone NOT LIKE '2%'
AND volunteerName NOT LIKE '% Jones';

# Question 3
SELECT DISTINCT v.volunteerName
FROM volunteer v
JOIN assignment a ON v.volunteerId = a.volunteerId
JOIN task t ON a.taskCode = t.taskCode
JOIN task_type tt ON t.taskTypeId = tt.taskTypeId
WHERE tt.taskTypeName = 'transporting';

# Question 4
SELECT t.taskDescription
FROM task t
LEFT JOIN assignment a ON t.taskCode = a.taskCode
WHERE a.taskCode IS NULL;

# Question 5 
SELECT DISTINCT pt.packageTypeName
FROM package_type pt
JOIN package p ON pt.packageTypeId = p.packageTypeId
JOIN package_contents pc ON p.packageId = pc.packageId
JOIN item i ON pc.itemId = i.itemId
WHERE i.itemDescription LIKE '%bottle%';

# Question 6
SELECT i.itemDescription
FROM item i
LEFT JOIN package_contents pc ON i.itemId = pc.itemId
WHERE pc.itemId IS NULL;

# Question 7
SELECT DISTINCT t.taskDescription
FROM task t
JOIN assignment a ON t.taskCode = a.taskCode
JOIN volunteer v ON a.volunteerId = v.volunteerId
WHERE v.volunteerAddress LIKE '%NJ%';

# Question 8
SELECT DISTINCT v.volunteerName
FROM volunteer v
JOIN assignment a ON v.volunteerId = a.volunteerId
WHERE a.startDateTime >= '2021-01-01'
AND a.startDateTime < '2021-07-01';

# Question 9
SELECT DISTINCT v.volunteerName
FROM volunteer v
JOIN assignment a ON v.volunteerId = a.volunteerId
JOIN task t ON a.taskCode = t.taskCode
JOIN package p ON t.taskCode = p.taskCode
JOIN package_contents pc ON p.packageId = pc.packageId
JOIN item i ON pc.itemId = i.itemId
WHERE i.itemDescription = 'can of spam';

# Question 10
SELECT DISTINCT i.itemDescription
FROM item i
JOIN package_contents pc ON i.itemId = pc.itemId
WHERE (i.itemValue * pc.itemQuantity) = 100;

# Question 11
SELECT ts.taskStatusName,
COUNT(DISTINCT a.volunteerId) AS numVolunteers
FROM task_status ts
JOIN task t ON ts.taskStatusId = t.taskStatusId
JOIN assignment a ON t.taskCode = a.taskCode
GROUP BY ts.taskStatusName
ORDER BY numVolunteers DESC;

# Question 12
SELECT p.taskCode,
SUM(p.packageWeight) AS totalWeight
FROM package p
GROUP BY p.taskCode
ORDER BY totalWeight DESC
LIMIT 1;

# Question 13
SELECT COUNT(*) AS numTasks
FROM task t
JOIN task_type tt ON t.taskTypeId = tt.taskTypeId
WHERE tt.taskTypeName <> 'packing';

# Question 14
SELECT DISTINCT i.itemDescription
FROM item i
JOIN package_contents pc ON i.itemId = pc.itemId
JOIN package p ON pc.packageId = p.packageId
JOIN assignment a1 ON p.taskCode = a1.taskCode
LEFT JOIN assignment a2 
  ON p.taskCode = a2.taskCode AND a2.volunteerId <> a1.volunteerId
LEFT JOIN assignment a3 
  ON p.taskCode = a3.taskCode 
     AND a3.volunteerId <> a1.volunteerId 
     AND a3.volunteerId <> a2.volunteerId

# Question 15
SELECT *
FROM (
    SELECT pc.packageId,
           SUM(i.itemValue * pc.itemQuantity) AS totalValue
    FROM package_contents pc
    JOIN item i ON pc.itemId = i.itemId
    GROUP BY pc.packageId
) t
WHERE totalValue > 100
ORDER BY totalValue ASC;







