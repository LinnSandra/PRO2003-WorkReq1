-- Add test clients to the database
INSERT INTO client (name, email, phone)
VALUES
    ('Luii Studio', 'hello@luiistudio.no', '91234567'),
    ('Fjord & Form', 'kontakt@fjordform.no', '92345678'),
    ('Eik Design', 'hei@eikdesign.no', '93456789'),
    ('Natur Bygg', 'post@naturbygg.no', '94567890');

    -- Add services offered by the studio
INSERT INTO service (name, description)
VALUES
    ('Web Design', 'Design of modern and user-friendly websites'),
    ('Web Development', 'Development of responsive websites'),
    ('UX/UI Design', 'User experience and interface design'),
    ('Branding', 'Visual identity and branding');

    -- Add projects for existing clients
INSERT INTO project (client_id, name, description, status, start_date)
VALUES
    (2, 'Portfolio Website', 'Design and development of a new portfolio website', 'active', '2026-08-15'),
    (2, 'Brand Refresh', 'Update of the existing visual identity', 'completed', '2026-05-10'),
    (3, 'Online Store', 'Design and development of an online store', 'active', '2026-09-01'),
    (3, 'UX Review', 'Review and improvement of the current user experience', 'completed', '2026-03-20'),
    (4, 'Booking Website', 'New website with an online booking experience', 'active', '2026-09-15'),
    (5, 'Company Website', 'New responsive website for the company', 'planned', '2026-11-01');

    -- Connect projects to services and set a price for each service
INSERT INTO project_service (project_id, service_id, price)
VALUES
    (1, 1, 12000.00),
    (1, 2, 18000.00),
    (1, 3, 8000.00),
    (2, 4, 15000.00),
    (3, 1, 14000.00),
    (3, 2, 25000.00),
    (3, 3, 10000.00),
    (4, 3, 9000.00),
    (5, 1, 13000.00),
    (5, 2, 20000.00),
    (6, 1, 11000.00),
    (6, 2, 17000.00);

    -- Update the status of a project when work has started
UPDATE project
SET status = 'active'
WHERE name = 'Company Website';

-- Add a temporary client to demonstrate deletion
INSERT INTO client (name, email, phone)
VALUES ('Test Client', 'test@example.com', '90000000');

-- Remove the temporary client from the database
DELETE FROM client
WHERE email = 'test@example.com';