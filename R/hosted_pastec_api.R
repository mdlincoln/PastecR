hosted_add_image <- function(image_path, image_id, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/images/", image_id)

  # Execute call
  jsonify(httr::PUT(url = destination, body = httr::upload_file(image_path)))
}

hosted_remove_image <- function(image_id, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/images/", image_id)

  # Execute call
  jsonify(httr::DELETE(url = destination))
}

hosted_clear_index <- function(server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/io")

  # Execute call
  jsonify(httr::POST(url = destination, body = '{"type":"CLEAR"}'))
}

hosted_load_index <- function(index_path, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/io")

  # Execute call
  jsonify(httr::POST(url = destination, body = paste0('{"type":"LOAD", "index_path":', index_path, '}')))
}

hosted_save_index <- function(index_path, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/io")

  # Execute call
  jsonify(httr::POST(url = destination, body = paste0('{"type":"WRITE", "index_path":', index_path, '}')))
}

hosted_search_image <- function(image_path, server) {

  # Format url
  destination <- paste0(hosted_pastec_server_url(server), "/index/searcher")

  # Execute call
  jsonify(httr::POST(url = destination, body = httr::upload_file(image_path)))
}
