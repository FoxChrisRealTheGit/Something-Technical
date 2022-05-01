package routemodels

const (
	INCORRECT_PRODUCT_CODE = 5
	INCORRECT_PRODUCT_MSG  = "Incorrect Product Code"
)

type InternalError struct {
	Code    int    `json:"code"`
	Message string `json:"msg"`
}
