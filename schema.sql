CREATE TABLE client (
    client_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE project (
    project_id INTEGER PRIMARY KEY,
    client_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    status VARCHAR(20) NOT NULL,
    start_date DATE,
    FOREIGN KEY (client_id) REFERENCES client(client_id)
);

CREATE TABLE service (
    service_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE project_service (
    project_id INTEGER,
    service_id INTEGER,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    PRIMARY KEY (project_id, service_id),
    FOREIGN KEY (project_id) REFERENCES project(project_id),
    FOREIGN KEY (service_id) REFERENCES service(service_id)
);