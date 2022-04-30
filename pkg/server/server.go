package server

import (
	"Something-Technical/v1/pkg/internal/helpers/httphelpers"
	"net/http"
	routemodels "something-technical/v1/pkg/internal/route-models"
)

func (s *Server) GetProduct(w http.ResponseWriter, r *http.Request) {
	// grab id
	reqID := ""

	resp, err := s.DB.GetProduct(reqID)
	if err != nil {
		httphelpers.SendErrorHeader(http.StatusBadRequest,
			routemodels.InternalError{
				Code:    routemodels.INCORRECT_PRODUCT_CODE_CODE,
				Message: routemodels.INCORRECT_PRODUCT_CODE_MSG,
			})
	}

	httphelpers.SendSuccessHeader(resp)
}
