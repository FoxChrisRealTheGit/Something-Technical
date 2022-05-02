package server

import (
	"encoding/json"
	"log"
	"net/http"
	helpers "something-technical/v1/pkg/internal/helpers"
	routemodels "something-technical/v1/pkg/internal/route-models"

	"github.com/gorilla/mux"
)

// CreateProduct will parse the json request and create the desired
// product in the DB, returning the created ID
func (s *Server) CreateProduct(w http.ResponseWriter, r *http.Request) {
	var form routemodels.CreateProductRequest
	if err := json.NewDecoder(r.Body).Decode(&form); err != nil {
		log.Println(err)
		// send error msg
		return
	}

	resp, err := s.Persistence.CreateProduct(form)
	if err != nil {
		helpers.SendErrorHeader(w, http.StatusBadRequest,
			routemodels.InternalError{
				Code:    routemodels.INCORRECT_PRODUCT_CODE,
				Message: routemodels.INCORRECT_PRODUCT_MSG,
			})
		return
	}

	helpers.SendSuccessHeader(w, resp)
}

func (s *Server) GetProduct(w http.ResponseWriter, r *http.Request) {
	reqID := mux.Vars(r)["id"]
	if reqID == "" {
		helpers.SendErrorHeader(w, http.StatusBadRequest,
			routemodels.InternalError{
				Code:    routemodels.NO_PRODUCT_CODE,
				Message: routemodels.NO_PRODUCT_MSG,
			})
		return
	}

	resp, err := s.Persistence.GetProduct(reqID)
	if err != nil {
		helpers.SendErrorHeader(w, http.StatusBadRequest,
			routemodels.InternalError{
				Code:    routemodels.INCORRECT_PRODUCT_CODE,
				Message: routemodels.INCORRECT_PRODUCT_MSG,
			})
		return
	}

	helpers.SendSuccessHeader(w, resp)
}
