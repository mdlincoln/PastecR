#' Link to a self-run Pastec server
#'
#' @param url Defaults to \code{localhost://}
#' @param port Pastec default port is 4212
#'
#' @return A list with the attributes of the server connection
#'
#' @seealso \link{hosted_pastec_server}
#'
#' @export
open_pastec_server <- function(url = "localhost", port = 4212) {
  list(type = "open", url = url, port = port)
}

# Construct the root url for an open Pastec server
open_pastec_server_url <- function(pastec_server) {
  stopifnot(pastec_server$type == "open")
  paste0("http://", pastec_server$url, ":", pastec_server$port)
}

#' Link to a hosted Pastec server
#'
#' Your \code{index_id} and \code{auth_key} can be found at
#' \url{https://api.pastec.io/manager/apiPage} once you make an account.
#'
#' @param index_id Character. ID string of the index hosted at
#'   \url{https://api.pastec.io}.
#' @param auth_key Character. Authentication key string for your account at
#'   \url{https://api.pastec.io}.
#'
#' @return A list with the attributes of the server connection
#'
#' @seealso \likn{open_pastec_server}
#'
#' @export
hosted_pastec_server <- function(index_id, auth_key) {
  stopifnot(nchar(index_id) == 20)
  stopifnot(nchar(auth_key) == 20)

  list(type = "hosted", index_id = index_id, auth_key = auth_key)
}

# Construct the root url for a hosted Pastec server
hosted_pastec_server_url <- function(pastec_server) {
  stopifnot(pastec_server$type == "hosted")
  server <- paste0("https://api.pastec.io/indexes/", pastec_server$index_id)
  attr(server, "auth_key") <- pastec_server$auth_key
  return(server)
}
