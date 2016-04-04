#' Helper function to read JSON response from
jsonify <- function(httr_response) {
  jsonlite::fromJSON(httr::content(httr_response, as = "text", encoding = "UTF-8"))
}

#' Check the pastec server ping response
check_pastec_server <- function(server = pastec_server()) {
  ping_response <- httr::POST(url = server, body = '{"type":"PING"}')
  stopifnot(jsonify(ping_response)$type == "PONG")
}
