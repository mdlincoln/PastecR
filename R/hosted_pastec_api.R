hosted_add_image <- function(image_path, image_id, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/images/", image_id)

  # Execute call
  jsonify(httr::PUT(url = destination, body = httr::upload_file(image_path), httr::add_headers(AuthKey = server$auth_key)))
}

hosted_remove_image <- function(image_id, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/images/", image_id)

  # Execute call
  jsonify(httr::DELETE(url = destination, httr::add_headers(AuthKey = server$auth_key)))
}

hosted_clear_index <- function(server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/io")

  # Execute call
  jsonify(httr::POST(url = destination, body = '{"type":"CLEAR"}', httr::add_headers(AuthKey = server$auth_key)))
}

hosted_load_index <- function(index_path, server) {
  stop("load_index is not currently implemented for the hosted version of the Pastec API")
}

hosted_save_index <- function(index_path, server) {
  stop("save_index is not currently implemented for the hosted version of the Pastec API")
}

hosted_search_image <- function(image_path, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/searcher")

  # Execute call
  jsonify(httr::POST(url = destination, body = httr::upload_file(image_path), httr::add_headers(AuthKey = server$auth_key)))
}
