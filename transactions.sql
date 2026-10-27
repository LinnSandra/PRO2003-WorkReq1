-- Run after schema.sql and data.sql.
-- The test data uses project 7 (Brand Strategy) and service 4 (Branding).
-- Expected starting state: planned, with no assigned services.

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