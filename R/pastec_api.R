#' Add image to Pastec index
#'
#' @param image_path Path to the image file
#' @param image_id Integer. Unique image id.
#' @param server Pastec server
#'
#' @export
#' @return On successful addition, silently returns list with the image id and response type.
#'
#' @examples
#' \dontrun{
#' ps <- pastec_server(url = "localhost", port = 4212)
#' add_image("image.jpg", 1, server = ps)
#' }
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
#'
#' Remove a specific image from the Pastec index.
#'
#' @param image_id Integer. An image id in the Pastec index.
#' @param server Pastec server.
#'
#' @return Returns TRUE on success, returns FALSE with a warning when image_id is not found.
#'
#' @examples
#' \dontrun{
#' ps <- pastec_server(url = "localhost", port = 4212)
#' remove_image(1, server = ps)
#' }
remove_image <- function(image_id, server = pastec_server()) {
  # Validate image_id
  stopifnot(is.wholenumber(image_id))

  # Format url
  destination <- paste0(server, "/index/images/", image_id)

  response <- jsonify(httr::DELETE(url = destination))
  if(response$type == "IMAGE_REMOVED") {
    return(TRUE)
  } else if(response$type == "IMAGE_NOT_FOUND") {
    warning("Image ", image_id, " not found.")
    return(FALSE)
  } else {
    return(FALSE)
  }
}

#' Clear an index
#'
#' Directs Pastec to clear the image index.
#'
#' @param server Pastec server.
#'
#' @return Returns TRUE on success, returns false (with a warning) on failure
#' @export
#' @examples
#' \dontrun{
#' ps <- pastec_server(url = "localhost", port = 4212)
#' clear_index(server = ps)
#' #> Pastec index cleared.
#' #> [1] TRUE
#' }
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
#' @examples
#' \dontrun{
#' ps <- pastec_server(url = "localhost", port = 4212)
#' load_index("index.dat", server = ps)
#' #> Pastec index loaded
#' #> [1] TRUE
#' }
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
    print(response$type)
    stop("Index file ", index_path, " not found.")
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
#' @examples
#' \dontrun{
#' ps <- pastec_server(url = "localhost", port = 4212)
#' save_index("index.dat", server = ps)
#' #> Pastec index saved to disk.
#' #> [1] TRUE
#' }
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
#' @return On a successful search, returns a list generated from Pastec's JSON response.
#'
#' @export
#' @examples
#' \dontrun{
#' ps <- pastec_server(url = "localhost", port = 4212)
#' search_image("image.jpg", server = ps)
#' }
search_image <- function(image_path, server = pastec_server()) {
  # Validate image_path and image_id
  stopifnot(file.exists(image_path))

  # Format url
  destination <- paste0(server, "/index/searcher")

  response <- jsonify(httr::POST(url = destination, body = httr::upload_file(image_path)))

  if(response$type == "SEARCH_RESULTS") {
    return(response)
  } else if(response$type == "IMAGE_NOT_DECODED") {
    warning("Image ", image_path, " could not be decoded.")
    return(NULL)
  } else if(response$type == "IMAGE_SIZE_TOO_BIG") {
    warning("Image ", image_path, " is too big.")
    return(NULL)
  } else if(response$type == "IMAGE_SIZE_TOO_SMALL") {
    warning("Image ", image_path, " is too small.")
    return(NULL)
  } else {
    return(NULL)
  }
}
