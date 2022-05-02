-- +migrate Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE EXTENSION IF NOT EXISTS pgcrypto;

SET TIME ZONE 'UTC';

CREATE TABLE vendors(
    id UUID PRIMARY KEY,
    display_name VARCHAR(256) NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    meta JSON DEFAULT '{}',
    archived TIMESTAMP
);

CREATE TABLE products(
    id UUID PRIMARY KEY, 
    vendor UUID NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,  
    cost INTEGER NOT NULL DEFAULT 0,
    display_name VARCHAR(256) NOT NULL, 
    product_type VARCHAR(32) NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    meta JSON DEFAULT '{}',
    archived TIMESTAMP
);


-- +migrate Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE IF EXISTS vendors CASCADE;
DROP TABLE IF EXISTS products CASCADE;