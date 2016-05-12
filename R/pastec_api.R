#' Add image to Pastec index
#'
#' @param image_path Path to the image file
#' @param image_id Integer. Unique image id.
#' @param server Pastec server
#'
#' @export
#' @return On successful addition, silently returns list with server response.
#'
#' @examples
#' \dontrun{
#'
#' erasmus1 <- system.file("img", "RP-P-1906-1485.jpg", package = "PastecR")
#' ps <- open_pastec_server()
#' str(add_image(erasmus1, 1, ps))
#' #> List of 3
#' #>  $ image_id             : int 1
#' #>  $ nb_features_extracted: int 1721
#' #>  $ type                 : chr "IMAGE_ADDED"
#' }
add_image <- function(image_path, image_id, server) {

  # Validate image_path and image_id
  stopifnot(file.exists(image_path))
  stopifnot(is.wholenumber(image_id))

  # Choose handler based on server type
  handler <- switch(server$type,
         "open" = open_add_image,
         "hosted" = hosted_add_image)

  response <- handler(image_path, image_id, server)
  response_handler(response)
}

#' Remove image from Pastec index
#'
#' Remove a specific image from the Pastec index.
#'
#' @param image_id Integer. An image id in the Pastec index.
#' @param server Pastec server.
#'
#' @return On successful addition, silently returns list with server response.
#'
#' @export
#' @examples
#' \dontrun{
#' erasmus1 <- system.file("img", "RP-P-1906-1485.jpg", package = "PastecR")
#' ps <- open_pastec_server()
#' add_image(erasmus1, 1, ps)
#' str(remove_image(1, ps))
#' #> List of 2
#' #>  $ image_id: int 1
#' #>  $ type    : chr "IMAGE_REMOVED"
#' }
remove_image <- function(image_id, server) {
  # Validate image_id
  stopifnot(is.wholenumber(image_id))

  # Choose handler based on server type
  handler <- switch(server$type,
                    "open" = open_remove_image,
                    "hosted" = hosted_remove_image)

  response <- handler(image_id, server)
  response_handler(response)
}

#' Clear an index
#'
#' Directs Pastec to clear the image index.
#'
#' @param server Pastec server.
#'
#' @return On successful addition, silently returns list with server response.
#'
#' @export
#' @examples
#' \dontrun{
#' ps <- open_pastec_server()
#' clear_index(ps)
#' #> Pastec index cleared.
#' #> [1] TRUE
#' }
clear_index <- function(server) {

  # Choose handler based on server type
  handler <- switch(server$type,
                    "open" = open_clear_index,
                    "hosted" = hosted_clear_index)

  response <- handler(server)
  response_handler(response)
}

#' Load an index
#'
#' Directs Pastec to load an image index from disk.
#'
#' @param index_path File contianing a Pastec index.
#' @param server Pastec server.
#'
#' @return On successful addition, silently returns list with server response.
#'
#' @export
#' @examples
#' \dontrun{
#' ps <- open_pastec_server()
#' load_index("index.dat", ps)
#' #> Pastec index loaded
#' #> [1] TRUE
#' }
load_index <- function(index_path, server) {

  # Validate index_path
  stopifnot(file.exists(index_path))

  # Format url
  destination <- paste0(server, "/index/io")

  # Choose handler based on server type
  handler <- switch(server$type,
                    "open" = open_load_index,
                    "hosted" = hosted_load_index)

  response <- handler(index_path, server)
  response_handler(response)
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
save_index <- function(index_path, server) {

  # Choose handler based on server type
  handler <- switch(server$type,
                    "open" = open_save_index,
                    "hosted" = hosted_save_index)

  response <- handler(index_path, server)
  response_handler(response)
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
search_image <- function(image_path, server) {
  # Validate image_path and image_id
  stopifnot(file.exists(image_path))

  # Choose handler based on server type
  handler <- switch(server$type,
                    "open" = open_search_image,
                    "hosted" = hosted_search_image)

  response <- handler(image_path, server)
  withVisible(response_handler(response))$value
}
