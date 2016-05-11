hosted_add_image <- function(image_path, image_id, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/images/", image_id)

  # Execute call
  jsonify(httr::PUT(url = destination, body = httr::upload_file(image_path), httr::add_headers(AuthKey = server$auth_key)))
}

hosted_remove_image <- function(image_id, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/images/", image_id)

  # Execute call
  jsonify(httr::DELETE(url = destination), httr::add_headers(AuthKey = server$auth_key))
}

hosted_clear_index <- function(server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/io")

  # Execute call
  jsonify(httr::POST(url = destination, body = '{"type":"CLEAR"}', httr::add_headers(AuthKey = server$auth_key)))
}

hosted_load_index <- function(index_path, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/io")

  # Execute call
  jsonify(httr::POST(url = destination, body = paste0('{"type":"LOAD", "index_path":', index_path, '}'), httr::add_headers(AuthKey = server$auth_key)))
}

hosted_save_index <- function(index_path, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/io")

  # Execute call
  jsonify(httr::POST(url = destination, body = paste0('{"type":"WRITE", "index_path":', index_path, '}'), httr::add_headers(AuthKey = server$auth_key)))
}

hosted_search_image <- function(image_path, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/searcher")

  # Execute call
  jsonify(httr::POST(url = destination, body = httr::upload_file(image_path), httr::add_headers(AuthKey = server$auth_key)))
}
