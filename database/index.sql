-- Run against the assignment database after schema.sql and data.sql.
-- Remove this specific index so the comparison can be repeated.
DROP INDEX IF EXISTS public.idx_project_client_id;

-- Update the statistics before comparing query plans.
ANALYZE public.project;

-- Before adding the index
EXPLAIN ANALYZE
SELECT project_id, name, status, start_date
FROM public.project
WHERE client_id = 3;

-- Add an index for queries that filter projects by client.
CREATE INDEX idx_project_client_id
ON public.project (client_id);

-- After adding the index
EXPLAIN ANALYZE
SELECT project_id, name, status, start_date
FROM public.project
WHERE client_id = 3;