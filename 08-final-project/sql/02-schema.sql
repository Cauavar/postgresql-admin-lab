-- ==========================================
-- PostgreSQL Admin Lab - Final Project
-- Schema and Main Table
-- ==========================================

-- Connect to the company database before executing
-- the commands below.

-- Default schema used by the project
CREATE SCHEMA IF NOT EXISTS public;

-- Main table used in the administration experiments
CREATE TABLE IF NOT EXISTS public.tb_product (
    product_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL,

    CONSTRAINT products_pkey PRIMARY KEY (product_id),
    CONSTRAINT products_name_not_null CHECK (name <> ''),
    CONSTRAINT products_price_positive CHECK (price >= 0)
);

-- Sequence used to generate product identifiers
CREATE SEQUENCE IF NOT EXISTS public.product_product_id_seq
    AS INTEGER
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- Associate the sequence with the product ID column
ALTER SEQUENCE public.product_product_id_seq
    OWNED BY public.tb_product.product_id;

ALTER TABLE public.tb_product
    ALTER COLUMN product_id
    SET DEFAULT nextval('public.product_product_id_seq');