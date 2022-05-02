package server

import (
	"something-technical/v1/pkg/internal/persistence"
)

// Server struct acts as the main struct for the
// service that implements the Persistence
// layer and allows for the associated handlerFunc
// methods to resolve route logic
type Server struct {
	Persistence *persistence.ProductPersistence
}
