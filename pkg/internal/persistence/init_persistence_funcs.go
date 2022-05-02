package persistence

import (
	"fmt"
	"log"

	"github.com/jmoiron/sqlx"
	migrate "github.com/rubenv/sql-migrate"
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

// MigrateDBUP runs the migration files up
func (db *ProductPersistence) MigrateDBUP() error {
	// run the migrate here
	migrations := &migrate.FileMigrationSource{
		Dir: "../resources/migrations",
	}
	n, err := migrate.Exec(db.Postgres.DB, "postgres", migrations, migrate.Up)
	if err != nil {
		// Handle errors!
		log.Println(err)
	}

	fmt.Printf("Applied %d migrations!\n", n)
	return nil
}

//MigrateDBDown runs the migration files down
func (db *ProductPersistence) MigrateDBDown() error {
	// run the migrate here
	migrations := &migrate.FileMigrationSource{
		Dir: "../resources/migrations",
	}
	n, err := migrate.Exec(db.Postgres.DB, "postgres", migrations, migrate.Down)
	if err != nil {
		// Handle errors!
		log.Println(err)
	}

	fmt.Printf("Applied %d migrations!\n", n)
	return nil
}
