-- +migrate Up
-- SQL in section 'Up' is executed when this migration is applied

-- +migrate StatementBegin
CREATE OR REPLACE FUNCTION inject_uuid() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.id IS NULL THEN
        NEW.id := gen_random_uuid();
    END IF;
	RETURN NEW;
END;$$ LANGUAGE plpgsql;
-- +migrate StatementEnd


CREATE TRIGGER new_vendor_id
BEFORE INSERT ON vendors
FOR EACH ROW EXECUTE PROCEDURE inject_uuid();


CREATE TRIGGER new_product_id
BEFORE INSERT ON products
FOR EACH ROW EXECUTE PROCEDURE inject_uuid();


-- +migrate Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP FUNCTION inject_uuid CASCADE;

DROP TRIGGER IF EXISTS new_vendor_id ON vendors;
DROP TRIGGER IF EXISTS new_product_id ON products;