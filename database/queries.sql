-- Query 1: Show active projects with their clients, oldest first
SELECT project.name AS project_name,
       client.name AS client_name,
       project.start_date
FROM project
JOIN client ON project.client_id = client.client_id
WHERE project.status = 'active'
ORDER BY project.start_date ASC, project.project_id;

-- Query 2: Show planned projects with their clients starting from November 2026
SELECT project.name AS project_name,
       client.name AS client_name,
       project.status,
       project.start_date
FROM project
JOIN client ON project.client_id = client.client_id
WHERE project.status = 'planned'
  AND project.start_date >= DATE '2026-11-01'
ORDER BY project.start_date ASC, project.project_id;

-- Query 3: Show each project with its client
SELECT project.name AS project_name, client.name AS client_name
FROM project
JOIN client ON project.client_id = client.client_id;

-- Query 4: Show the services used in each project and their prices
SELECT project.name AS project_name,
       service.name AS service_name,
       project_service.price
FROM project
JOIN project_service ON project.project_id = project_service.project_id
JOIN service ON project_service.service_id = service.service_id
ORDER BY project.name;

-- Query 5: Calculate the total cost and service count for projects with services
SELECT project.name AS project_name,
       SUM(project_service.price) AS total_cost,
       COUNT(project_service.service_id) AS service_count
FROM project
JOIN project_service ON project.project_id = project_service.project_id
GROUP BY project.project_id, project.name
ORDER BY total_cost DESC, project.project_id;

-- Query 6: Show clients that have more than one project
SELECT client.name AS client_name,
       COUNT(project.project_id) AS project_count
FROM client
JOIN project ON client.client_id = project.client_id
GROUP BY client.client_id, client.name
HAVING COUNT(project.project_id) > 1;

-- Query 7: Show service entries priced above the average
SELECT project.name AS project_name,
       service.name AS service_name,
       project_service.price
FROM project_service
JOIN project ON project_service.project_id = project.project_id
JOIN service ON project_service.service_id = service.service_id
WHERE project_service.price > (
    SELECT AVG(price)
    FROM project_service
)
ORDER BY project_service.price DESC;

-- Query 8: Show projects that have no services assigned
SELECT project.name AS project_name,
       client.name AS client_name,
       project.status
FROM project
JOIN client ON project.client_id = client.client_id
LEFT JOIN project_service
    ON project.project_id = project_service.project_id
WHERE project_service.project_id IS NULL
ORDER BY project.name, project.project_id;