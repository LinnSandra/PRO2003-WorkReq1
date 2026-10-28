-- Run as an administrator against the assignment database.
-- Create this role once per PostgreSQL server.
CREATE ROLE studio_reader NOLOGIN;

-- Allow access to the schema and reading the four tables.
GRANT USAGE ON SCHEMA public TO studio_reader;

GRANT SELECT ON TABLE
    public.client,
    public.project,
    public.service,
    public.project_service
TO studio_reader;

-- Test reading with the limited role.
SET ROLE studio_reader;

SELECT current_user AS active_role,
       project_id,
       name,
       status
FROM public.project
ORDER BY project_id;

-- Run this statement separately.
-- Expected: ERROR: permission denied for table project
UPDATE public.project
SET status = status
WHERE project_id = 7;

-- Run separately after the expected error.
-- Restore the original role.
RESET ROLE;

SELECT current_user;