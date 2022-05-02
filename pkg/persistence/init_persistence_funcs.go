package persistence

import (
	"log"

	"github.com/jmoiron/sqlx"
)

func NewPersistence(dialect, connectionInfo string) (*ProductPersistence, error) {
	db, err := sqlx.Open(dialect, connectionInfo)
	if err != nil {
		log.Println("Error connecting to DB")
		log.Println(err)
		return nil, err
	}

	return &ProductPersistence{
		Postgres: db,
	}, nil
}
