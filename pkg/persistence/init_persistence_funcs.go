package persistence

import (
	"log"

	"github.com/jmoiron/sqlx"
)

func NewPersistence(dialect, connectionInfo string) (*ProductDB, error) {
	db, err := sqlx.Open(dialect, connectionInfo)
	if err != nil {
		log.Println("Error connecting to DB")
		log.Println(err)
		return nil, err
	}

	return &ProductDB{
		Postgres: db,
	}, nil
}
