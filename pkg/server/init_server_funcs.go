package server

import (
	"log"
	"something-technical/v1/pkg/persistence"
	"something-technical/v1/resources/config"
)

func NewServer(cfg config.Config) *Server {

	db, err := persistence.NewPersistence(cfg.Database.Dialect(), cfg.Database.Connection())
	if err != nil {
		log.Fatal("Couldn't Make DB Connection")
	}

	return &Server{
		Persistence: db,
	}
}
