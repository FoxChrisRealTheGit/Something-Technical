package persistence

import routemodels "something-technical/v1/pkg/internal/route-models"

func (db *ProductPersistence) CreateProduct(req routemodels.CreateProductRequest) (*routemodels.CreateProductResponse, error) {
	var result string

	SQL := `
	INSERT INTO products
	(vendor, cost, display_name, product_type)
	VALUES
	($1, $2, $3, $4)
	RETURNING id
	`

	args := []interface{}{
		req.VendorID,
		req.Cost,
		req.Product,
		req.Details.Type,
	}

	// Make the appropiate SQL Call
	if err := db.Postgres.QueryRow(SQL, args...).Scan(result); err != nil {
		// handle err
		return nil, err
	}

	return &routemodels.CreateProductResponse{
		ID: result,
	}, nil
}

func (db *ProductPersistence) GetProductByID(id string) (*routemodels.GetProductResponse, error) {
	var result routemodels.GetProductResponse

	SQL := `
	SELECT
		products.id AS id,
		products.display_name AS product,
		products.cost AS cost,
		products.product_type AS type,
		vendors.display_name AS vendor
	FROM products
	JOIN vendors ON vendors.id = products.vendor
	WHERE products.id = $1
	`

	// Make the appropiate SQL Call
	if err := db.Postgres.Get(&result, SQL, id); err != nil {
		// handle err
		return nil, err
	}

	return &result, nil
}
