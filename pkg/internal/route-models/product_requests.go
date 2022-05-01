package routemodels

// CreateProductRequest is the request desired to
// create a single product
type CreateProductRequest struct {
	SlimProductInformation
}

// CreateProductResponse is the response returned on a
// POST request for creating a single product
type CreateProductResponse struct {
	ID string `json:"Id" db:"id"`
}

// GetProductResponse is the response returned on a
// GET request for a single product
type GetProductResponse struct {
	BasicProductInformation
}
