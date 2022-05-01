package server

import (
	"encoding/json"
	"log"
	"net/http"
	helpers "something-technical/v1/pkg/internal/helpers"
	routemodels "something-technical/v1/pkg/internal/route-models"
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

	resp, err := s.DB.CreateProduct(form)
	if err != nil {
		helpers.SendErrorHeader(w, http.StatusBadRequest,
			routemodels.InternalError{
				Code:    routemodels.INCORRECT_PRODUCT_CODE,
				Message: routemodels.INCORRECT_PRODUCT_MSG,
			})
	}

	helpers.SendSuccessHeader(w, resp)
}

func (s *Server) GetProduct(w http.ResponseWriter, r *http.Request) {
	// grab id
	reqID := ""

	resp, err := s.DB.GetProduct(reqID)
	if err != nil {
		helpers.SendErrorHeader(w, http.StatusBadRequest,
			routemodels.InternalError{
				Code:    routemodels.INCORRECT_PRODUCT_CODE,
				Message: routemodels.INCORRECT_PRODUCT_MSG,
			})
	}

	helpers.SendSuccessHeader(w, resp)
}
