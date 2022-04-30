package persistence

import routemodels "something-technical/v1/pkg/internal/route-models"

type IProductDB interface {
	GetProduct(string) (routemodels.GetProductResponse, error)
}
