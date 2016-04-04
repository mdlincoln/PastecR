#' Link to a Pastec server
#'
#' @param url Defaults to \code{localhost://}
#' @param port Pastec default port is 4212
#'
#' @export
#' @return Path to the Pastec server
pastec_server <- function(url = "localhost", port = 4212) {
  server <- paste0("http://", url, ":", port)
  check_pastec_server(server)
  return(server)
}

#' Add image to Pastec index
#'
#' @param image_path Path to the image file
#' @param image_id Integer. Unique image id.
#' @param server Pastec server
#'
#' @export
#' @return On successful addition, silently returns list with the image id and response type.
add_image <- function(image_path, image_id, server = pastec_server()) {

  # Validate image_path and image_id
  stopifnot(file.exists(image_path))
  stopifnot(is.wholenumber(image_id))

  # Format url
  destination <- paste0(server, "/index/images/", image_id)

  response <- httr::PUT(url = destination, body = httr::upload_file(image_path))

  # Invisibly return the response
  invisible(jsonify(response))
}

#' Remove image from Pastec index

#' Clear an index
#'
#' Directs Pastec to clear the image index.
#'
#' @param server Pastec server.
#'
#' @return Returns TRUE on success, returns false (with a warning) on failure
#' @export
clear_index <- function(server = pastec_server()) {

  # Format url
  destination <- paste0(server, "/index/io")

  response <- jsonify(httr::POST(url = destination, body = '{"type":"CLEAR"}'))
  if(response$type == "INDEX_CLEARED") {
    message("Pastec index cleared.")
    return(TRUE)
  } else {
    warning("Index clear failed.")
    return(FALSE)
  }
}

#' Load an index
#'
#' Directs Pastec to load an image index from disk.
#'
#' @param index_path File contianing a Pastec index.
#' @param server Pastec server.
#'
#' @return Returns TRUE on success, returns false (with a warning) on failure
#' @export
load_index <- function(index_path, server = pastec_server()) {

  # Validate index_path
  stopifnot(file.exists(index_path))

  # Format url
  destination <- paste0(server, "/index/io")

  response <- jsonify(httr::POST(url = destination, body = paste0('{"type":"LOAD", "index_path":', index_path, '}')))
  if(response$type == "INDEX_LOADED") {
    message("Pastec index loaded.")
    return(TRUE)
  } else {
    warning("Index load failed.")
    return(FALSE)
  }
}

#' Save an index
#'
#' Directs Pastec to save its image index to a file on disk.
#'
#' @param index_path File the Pastec index will be saved to. (File ending should be ".dat")
#' @param server Pastec server.
#'
#' @return Returns TRUE on success, returns false (with a warning) on failure
#' @export
save_index <- function(index_path, server = pastec_server()) {

  destination <- paste0(server, "/index/io")

  response <- jsonify(httr::POST(url = destination, body = paste0('{"type":"WRITE", "index_path":', index_path, '}')))
  if(response$type == "INDEX_WRITTEN") {
    message("Pastec index saved to disk.")
    return(TRUE)
  } else {
    warning("Index save failed.")
    return(FALSE)
  }
}

#' Search Pastec index by image
#'
#' Upload an image to the Pastec server to search the index for similar images.
#'
#' @param image_path Path to an image to upload.
#' @param server Pastec server.
#'
#' @return On a successful search, returns
#'
#' @export
search_image <- function(image_path, server = pastec_server()) {
  # Validate image_path and image_id
  stopifnot(file.exists(image_path))

  # Format url
  destination <- paste0(server, "/index/searcher")

  response <- httr::POST(url = destination, body = httr::upload_file(image_path))
  jsonify(response)
}

