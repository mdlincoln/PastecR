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
  stopifnot(is.integer(image_id))

  # Format url
  destination <- paste0(server, "/index/images/", image_id)

  response <- httr::PUT(url = destination, body = httr::upload_file(image_path))

  # Invisibly return the response
  invisible(jsonify(response))
}

#' Remove image from Pastec index

#' Clear an index

#' Load an index

#' Save an index

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

