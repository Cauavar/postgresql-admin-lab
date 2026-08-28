# PostgreSQL Fundamentals

## Objective

This document records the fundamental PostgreSQL concepts studied during the administration laboratory.

The objective is to understand the PostgreSQL architecture, its main components, administration tools, and basic commands used to interact with the database server.

## What is PostgreSQL?

PostgreSQL is an open-source object-relational database management system (ORDBMS).

It supports SQL and provides features for data storage, querying, transactions, security, indexing, backup and recovery, maintenance, and database administration.

In this project, PostgreSQL is used as the main database management system for the administration laboratory.

## PostgreSQL Architecture

The main concepts used in the project are:

```text
PostgreSQL Server
       |
       +---- Instance
       |
       +---- Database
               |
               +---- Schema
                       |
                       +---- Tables
                       +---- Views
                       +---- Sequences
                       +---- Functions
                       +---- Other objects
Server

The PostgreSQL server is the environment responsible for managing database connections, queries, transactions, storage, and other database operations.

Instance

A PostgreSQL instance represents a running PostgreSQL server process and its associated data directory.

It can manage one or more databases.

Database

A database is an isolated logical environment containing database objects such as schemas, tables, views, sequences, and functions.

The main database used in this project is:

company
Schema

A schema is a namespace used to organize database objects.

The default schema used in this project is:

public

The main table is:

public.tb_product
Basic PostgreSQL Commands

The following commands were used to inspect the PostgreSQL environment.

PostgreSQL Version
SELECT version();

Displays the PostgreSQL server version and compilation information.

Current User
SELECT current_user;

Displays the user currently connected to PostgreSQL.

Current Database
SELECT current_database();

Displays the database currently being used.

List Databases

Inside psql:

\l

Lists the databases available on the PostgreSQL server.

Connect to a Database
\c company

Changes the current database connection to company.

List Tables
\dt

Lists the tables available in the current schema.

List Roles
\du

Lists PostgreSQL roles and users.

Administration Tools

The laboratory uses different tools for PostgreSQL administration.

psql

psql is the PostgreSQL command-line client.

It allows administrators and developers to execute SQL commands and PostgreSQL administrative commands directly from the terminal.

pgAdmin

pgAdmin is a graphical administration tool for PostgreSQL.

It can be used to manage databases, tables, users, roles, permissions, queries, and other PostgreSQL objects.

Git Bash

Git Bash is used as the command-line environment for the project.

It is also used to execute Windows batch scripts and manage the Git repository.

Environment

The practical environment used in this laboratory includes:

Operating System: Windows
Database Management System: PostgreSQL 18.4
Command-line client: psql
Administration tool: pgAdmin
Terminal: Git Bash
Version Control: Git
Repository: GitHub
Relationship With the Administration Project

The concepts documented in this section provide the foundation for the other stages of the project.

The laboratory progressively applies PostgreSQL administration concepts in the following areas:

Fundamentals
     |
     v
SQL
     |
     v
Query Performance
     |
     v
Security
     |
     v
Backup and Recovery
     |
     v
Maintenance
     |
     v
Automation
     |
     v
Final Administration Project
Key Concepts

The main concepts learned in this stage are:

PostgreSQL server
PostgreSQL instance
Database
Schema
Tables
SQL
psql
pgAdmin
PostgreSQL roles
Database connections
Basic database inspection

These concepts form the foundation for the administration practices implemented throughout this repository.