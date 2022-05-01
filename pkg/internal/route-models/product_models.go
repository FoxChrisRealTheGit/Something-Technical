package routemodels

// BasicProductInformation is a generic struct to hold a
// standard struct for the near total information of a
// single product
type BasicProductInformation struct {
	ID string `json:"Id" db:"id"`
	SlimProductInformation
}

// BasicProductInformation is a generic struct to hold a
// standard struct for the near total information of a
// single product
type SlimProductInformation struct {
	Cost    float32        `json:"cost" db:"cost"`
	Product string         `json:"product" db:"product"`
	Details ProductDetails `json:"details"`
}

// ProductDetails is a generic struct to hold a standard
// struct for the specific details of a single product
type ProductDetails struct {
	Type   string `json:"type" db:"type"`
	Vendor string `json:"vendor" db:"vendor"`
}
