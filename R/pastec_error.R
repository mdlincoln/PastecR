# Evaluate rsponse types and throw warnings or errors as needed
response_handler <- function(response) {
  fun <- switch(
    response$type,
    # add_image
    "IMAGE_ADDED" = invisible,
    "IMAGE_NOT_DECODED" = pastec_error,
    "IMAGE_SIZE_TOO_BIG" = pastec_error,
    "IMAGE_SIZE_TOO_SMALL" = pastec_error,
    # remove_image
    "IMAGE_REMOVED" = invisible,
    "IMAGE_NOT_FOUND" = pastec_error,
    # search_image
    "SEARCH_RESULTS" = invisible,
    # other possible results covered above
    # clear_index
    "INDEX_CLEARED" = invisible,
    # load_index
    "INDEX_LOADED" = invisible,
    "INDEX_NOT_FOUND" = pastec_error,
    # save_index
    "INDEX_WRITTEN" = invisible,
    "INDEX_NOT_WRITTEN" = pastec_error,
    # Generic error
    "MALFORMED_REQUEST" = pastec_error,
    pastec_error)
  fun(response)
}

pastec_error <- function(response) {
  stop("Pastec server error: ", response$type)
}
