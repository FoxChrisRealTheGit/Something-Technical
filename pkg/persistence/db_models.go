package persistence

import (
	routemodels "something-technical/v1/pkg/internal/route-models"

	"github.com/jmoiron/sqlx"
)

type ProductDB struct {
	Postgres *sqlx.DB
	IProductDB
}

type IProductDB interface {
	CreateProduct(routemodels.CreateProductRequest) (routemodels.CreateProductResponse, error)
	GetProduct(string) (routemodels.GetProductResponse, error)
}
