package server

import (
	"something-technical/v1/pkg/persistence"
)

// Server struct acts as the main struct for the
// service that implements the DB (persistence)
// layer and allows for the associated handlerFunc
// methods to resolve route logic
type Server struct {
	DB persistence.IProductDB
}
