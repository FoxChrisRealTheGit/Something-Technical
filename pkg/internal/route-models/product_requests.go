package routemodels

// GetProductResponse is the response returned on a
// GET request for a single product
type GetProductResponse struct {
	ID      string         `json:"Id" db:"id"`
	Cost    float32        `json:"cost" db:"cost"`
	Product string         `json:"product" db:"product"`
	Details ProductDetails `json:"details"`
}

// ProductDetails is a generic struct to hold a standard
// struct for the details of a single product
type ProductDetails struct {
	Type   string `json:"type" db:"type"`
	Vendor string `json:"vendor" db:"vendor"`
}
