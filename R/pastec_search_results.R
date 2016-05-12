eval_results <- function(results) {
  if(length(results) == 0) {
    return(NULL)
  } else {
    return(results)
  }
}

#' Parse Pastec image search results
#'
#' These functions access the different components of the response to a successful Pastec image query.
#'
#' @param pastec_response The list returned by \link{search_image}.
#' @name pastec_response
#' @examples
#' \dontrun{
#' nightwatch <- system.file("img", "SK-C-5.jpg", package = "PastecR")
#' erasmus1 <- system.file("img", "RP-P-1906-1485.jpg", package = "PastecR")
#' erasmus2 <- system.file("img", "RP-P-1906-1486.jpg", package = "PastecR")
#' erasmus3 <- system.file("img", "RP-P-1906-1487.jpg", package = "PastecR")
#'
#' ps <- open_pastec_server()
#' add_image(erasmus1, 1, ps)
#' add_image(erasmus2, 2, ps)
#' search_results <- search_image(erasmus1, ps)
#'
#' bounding_rects(search_results)
#' #>   height width  x   y
#' #> 1    827   592 53 142
#' #> 2    803   567 64 159
#' #> 3    796   575 56 173
#' image_ids(search_results)
#' #> [1] 1 3 2
#' scores(search_results)
#' #> [1] 964  62  59
#' tags(search_results)
#' #> [1] NA NA NA
#' #' results_as_data_frame(search_results)
#' #>   height width  x   y image_id scores tags
#' #> 1    827   592 53 142        1    964   NA
#' #> 2    803   567 64 159        3     62   NA
#' #> 3    796   575 56 173        2     59   NA
#' }
NULL

#' @describeIn pastec_response A data.frame with the bounding box dimensions and origin for the match.
#' @export
bounding_rects <- function(pastec_response) {
  eval_results(pastec_response$bounding_rects)
}

#' @describeIn pastec_response A vector of returned IDs.
#' @export
image_ids <- function(pastec_response) {
  eval_results(pastec_response$image_ids)
}

#' @describeIn pastec_response A vector of similarity scores.
#' @export
scores <- function(pastec_response) {
  eval_results(pastec_response$scores)
}

#' @describeIn pastec_response A vector of tags.
#' @export
tags <- function(pastec_response) {
  t <- eval_results(pastec_response$tags)
  ifelse(t == "", NA, t)
}

#' @describeIn pastec_response A data.frame with one row per search result:
#' \describe{
#'   \item{\code{height}}{integer. The height of the bounding box in the matched image.}
#'   \item{\code{width}}{integer. The width of the bounding box in the matched image.}
#'   \item{\code{x}}{integer. The origin the bounding box in the matched image.}
#'   \item{\code{y}}{integer. The origin of the bounding box in the matched image.}
#'   \item{\code{image_id}}{integer. The Pastec image IDs matched.}
#'   \item{\code{scores}}{integer. The image match score.}
#'   \item{\code{tags}}{list. A character list with any tags associated with the image.}
#' }
#' @export
results_as_data_frame <- function(pastec_response) {
  rdf <- bounding_rects(pastec_response)

  # If there are no results at all, return NULL
  if(is.null(rdf))
    return(NULL)
  rdf$image_id <- image_ids(pastec_response)
  rdf$scores <- scores(pastec_response)
  rdf$tags <- tags(pastec_response)
  return(rdf)
}
