#' Parse Pastec image search results
#'
#' These functions access the different components of the response to a successful Pastec image query.
#'
#' @param pastec_response The list returned by \link{search_image}.
#' @name pastec_response
NULL

#' @describeIn pastec_response A data.frame with the bounding box dimensions and origin for the match.
#' @export
bounding_rects <- function(pastec_response) {
  pastec_response$bounding_rects
}

#' @describeIn pastec_response A vector of returned IDs.
#' @export
image_ids <- function(pastec_response) {
  pastec_response$image_ids
}

#' @describeIn pastec_response A vector of similarity scores.
#' @export
scores <- function(pastec_response) {
  pastec_response$scores
}

#' @describeIn pastec_response A vector of tags.
#' @export
tags <- function(pastec_response) {
  pastec_response$tags
}

#' @describeIn pastec_response A data.frame with one row per search result:
#' \describe{
#'   \item{\code{height}}{integer. The height of the bounding box in the matched image.}
#'   \item{\code{width}}{integer. The width of the bounding box in the matched image.}
#'   \item{\code{x}}{integer. The origin the bounding box in the matched image.}
#'   \item{\code{y}}{integer. The origin of the bounding box in the matched image.}
#' }
#' @export
results_as_data_frame <- function(pastec_response) {
  rdf <- bounding_rects(pastec_response)
  rdf$image_id <- image_ids(pastec_response)
  rdf$scores <- scores(pastec_response)
  rdf$tags <- tags(pastec_response)
  return(rdf)
}
