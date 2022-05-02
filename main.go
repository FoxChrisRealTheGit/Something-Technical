package main

import (
	"fmt"
	"log"
	"net/http"
	"something-technical/v1/pkg/server"
	"something-technical/v1/resources/config"

	"github.com/gorilla/mux"
)

func main() {
	/**********************************************************************
	/
	/	Configuration
	/
	/**********************************************************************/

	cfg := config.LoadConfig()

	// define server
	svr := server.NewServer(cfg)

	if cfg.Env == "dev" {
		err := svr.Persistence.MigrateDBUP()
		if err != nil {
			// migrations couldn't happen
			log.Println(err)
		}
	}
	/**********************************************************************
	/
	/	Initialize router and middlesware
	/
	/**********************************************************************/

	r := mux.NewRouter()

	/**********************************************************************
	/
	/	Health Check & Container routes
	/
	/**********************************************************************/

	r.HandleFunc("/health", func(rw http.ResponseWriter, r *http.Request) { rw.WriteHeader(http.StatusOK) })

	/**********************************************************************
	/
	/	Product routes
	/
	/**********************************************************************/

	r.HandleFunc("/api/v1/product", svr.CreateProduct).Methods("POST")
	r.HandleFunc("/api/v1/product", svr.GetProduct).Methods("GET")

	// start server
	log.Println("Running local on port: ", cfg.Port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", cfg.Port), nil))
}
