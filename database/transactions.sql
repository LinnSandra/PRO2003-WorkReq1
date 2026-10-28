-- Run after schema.sql and data.sql.
-- The test data uses project 7 (Brand Strategy) and service 4 (Branding).
-- Expected starting state: planned, with no assigned services.

-- Run Tests 1 and 2 first.
-- Run Test 3 statement by statement; it contains an intentional error.
-- After the error, execute ROLLBACK before the verification query.

-- Test 1: Make two related changes, then undo both.
BEGIN;

INSERT INTO public.project_service (project_id, service_id, price)
VALUES (7, 4, 15000);

UPDATE public.project
SET status = 'active'
WHERE project_id = 7;

ROLLBACK;

-- Expected result: Brand Strategy | planned | NULL | NULL
SELECT project.name AS project_name,
       project.status,
       service.name AS service_name,
       project_service.price
FROM public.project
LEFT JOIN public.project_service
    ON project.project_id = project_service.project_id
LEFT JOIN public.service
    ON project_service.service_id = service.service_id
WHERE project.project_id = 7;

-- Test 2: Make the same changes and save both.
BEGIN;

INSERT INTO public.project_service (project_id, service_id, price)
VALUES (7, 4, 15000);

UPDATE public.project
SET status = 'active'
WHERE project_id = 7;

COMMIT;

-- Expected result: Brand Strategy | active | Branding | 15000.00
SELECT project.name AS project_name,
       project.status,
       service.name AS service_name,
       project_service.price
FROM public.project
LEFT JOIN public.project_service
    ON project.project_id = project_service.project_id
LEFT JOIN public.service
    ON project_service.service_id = service.service_id
WHERE project.project_id = 7;

-- Test 3: A constraint error prevents partial changes from being saved.
-- Run after Test 2, with the project active and the price at 15000.
-- Execute each statement separately in the same connection.

BEGIN;

UPDATE public.project
SET status = 'completed'
WHERE project_id = 7;

-- Expected error: violates project_service_price_check.
UPDATE public.project_service
SET price = -100
WHERE project_id = 7
  AND service_id = 4;

-- Run after the expected error.
ROLLBACK;

-- Expected result: Brand Strategy | active | 15000.00
SELECT p.name,
       p.status,
       ps.price
FROM public.project p
JOIN public.project_service ps
    ON p.project_id = ps.project_id
WHERE p.project_id = 7
  AND ps.service_id = 4;