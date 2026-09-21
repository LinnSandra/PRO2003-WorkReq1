# PRO2003 - Work Requirement 1

PostgreSQL database design and implementation for Work Requirement 1.

## Domain

This database is designed for a small web and design studio. It is used to manage clients, their projects, and the services included in each project.

## Database Design

The database consists of four tables:

- `client` stores information about the studio's clients.
- `project` stores projects and connects each project to a client.
- `service` stores the services offered by the studio.
- `project_service` connects projects and services.

## Relationships

There is a one-to-many relationship between `client` and `project`. One client can have multiple projects, while each project belongs to one client.

There is a many-to-many relationship between `project` and `service`. A project can include multiple services, and the same service can be included in multiple projects.

This many-to-many relationship is resolved through the `project_service` table. Each record in `project_service` connects one project to one service, creating two one-to-many relationships: `project` to `project_service` and `service` to `project_service`.

## Design Decisions

The `client`, `project`, and `service` tables use automatically generated integer primary keys. This provides each record with a unique identifier without requiring IDs to be assigned manually.

The price is stored in `project_service` rather than `service`, because the price of a service may vary between projects.

The combination of `project_id` and `service_id` is used as a composite primary key to prevent the same service from being added to the same project more than once.

## ER Diagram

The ER diagram shows the structure of the database and the relationships between the four tables. Crow's Foot notation is used to represent the one-to-many and many-to-many relationships.

![ER Diagram](docs/er_diagram.png)

## How to Run

A running PostgreSQL server and a database client such as DBeaver are required.

1. Connect to PostgreSQL.
2. Open an SQL editor connected to an empty database.
3. Open or copy the contents of `schema.sql` into the editor.
4. Execute the complete script.
5. Refresh `Schemas → public → Tables` to verify that the four tables have been created.

## Setup and Testing

The database was created using PostgreSQL running in Docker and tested through DBeaver. The `schema.sql` script was executed successfully to verify that all tables and relationships were created correctly.