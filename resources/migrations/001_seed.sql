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
    display_name VARCHAR(256) NOT NULL, 
    -- should move this to details
    cost INTEGER NOT NULL DEFAULT 0,
    created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    meta JSON DEFAULT '{}',
    archived TIMESTAMP
);

CREATE TABLE product_details(
    vendor UUID NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,
    product UUID NOT NULL REFERENCES product(id) ON DELETE CASCADE,
    product_type VARCHAR(32) NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    meta JSON DEFAULT '{}',
    archived TIMESTAMP,
    PRIMARY KEY (vendor, product)
);


-- +migrate Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE IF EXISTS vendors CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS product_details CASCADE;