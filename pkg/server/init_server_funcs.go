package server

import (
	"fmt"
	"log"
	"something-technical/v1/pkg/persistence"
	"something-technical/v1/resources/config"

	migrate "github.com/rubenv/sql-migrate"
)

func NewServer(cfg config.Config) *Server {

	db, err := persistence.NewPersistence(cfg.Database.Dialect(), cfg.Database.Connection())
	if err != nil {
		log.Fatal("Couldn't Make DB Connection")
	}

	return &Server{
		DB: db,
	}
}

// MigrateDBUP runs the migration files up
func (s *Server) MigrateDBUP() error {
	// run the migrate here
	migrations := &migrate.FileMigrationSource{
		Dir: "../resources/migrations",
	}
	n, err := migrate.Exec(s.DB.Postgres.DB, "postgres", migrations, migrate.Up)
	if err != nil {
		// Handle errors!
		log.Println(err)
	}

	fmt.Printf("Applied %d migrations!\n", n)
	return nil
}

//MigrateDBDown runs the migration files down
func (s *Server) MigrateDBDown() error {
	// run the migrate here
	migrations := &migrate.FileMigrationSource{
		Dir: "../resources/migrations",
	}
	n, err := migrate.Exec(s.DB.Postgres.DB, "postgres", migrations, migrate.Down)
	if err != nil {
		// Handle errors!
		log.Println(err)
	}

	fmt.Printf("Applied %d migrations!\n", n)
	return nil
}
