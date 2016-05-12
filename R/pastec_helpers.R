# Helper function to read JSON response from
jsonify <- function(httr_response) {
  jsonlite::fromJSON(httr::content(httr_response, as = "text", encoding = "UTF-8"))
}

# Check if submitted IDs are whole numbers
is.wholenumber <- function(x, tol = .Machine$double.eps^0.5) {
  abs(x - round(x)) < tol
}
