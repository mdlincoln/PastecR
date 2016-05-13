## ----setup, include=FALSE------------------------------------------------
NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")
NOT_TRAVIS <- !identical(Sys.getenv("TRAVIS"), "true")
NOT_APPVEYOR <- !identical(Sys.getenv("APPVEYOR"), "True")
RUN_CHUNK <- all(NOT_CRAN, NOT_TRAVIS, NOT_APPVEYOR)

## ----pastec_server-------------------------------------------------------
library(PastecR)

# open_pastec_server defaults to the same port defaults as Pastec
ops <- open_pastec_server(url = "localhost", port = 4212)

# You can find the index_id and auth_key for your api.pastec.io account at
# <https://api.pastec.io/manager/apiPage>
hps <- hosted_pastec_server(index_id = "XXXXXXXXXXXXXXXXXXXX", auth_key = "XXXXXXXXXXXXXXXXXXXX")

## ----add_image, eval=RUN_CHUNK, purl=RUN_CHUNK---------------------------
# Get image paths
erasmus1 <- system.file("img", "RP-P-1906-1485.jpg", package = "PastecR")
erasmus2 <- system.file("img", "RP-P-1906-1486.jpg", package = "PastecR")
erasmus3 <- system.file("img", "RP-P-1906-1487.jpg", package = "PastecR")
nightwatch <- system.file("img", "SK-C-5.jpg", package = "PastecR")

add_image(erasmus1, 1, ops)
add_image(erasmus2, 2, ops)
add_image(erasmus3, 3, ops)
add_image(nightwatch, 4, ops)

# Images can also be removed by index
remove_image(4, ops)

## ----search_image, eval=RUN_CHUNK, purl=RUN_CHUNK------------------------
search_result <- search_image(erasmus1, ops)
results_as_data_frame(search_result)

