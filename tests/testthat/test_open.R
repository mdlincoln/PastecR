context("Open Pastec API")

# Get image paths
nightwatch <- system.file("img", "SK-C-5.jpg", package = "PastecR")
erasmus1 <- system.file("img", "RP-P-1906-1485.jpg", package = "PastecR")
erasmus2 <- system.file("img", "RP-P-1906-1486.jpg", package = "PastecR")
erasmus3 <- system.file("img", "RP-P-1906-1487.jpg", package = "PastecR")

test_url = "localhost"
test_port = 4212

ops <- open_pastec_server(test_url, test_port)

test_that("Clear index", {
  skip_on_travis()
  skip_on_appveyor()

  expect_equivalent(clear_index(ops)$type, "INDEX_CLEARED")
})

test_that("Add images to hosted Pastec server", {
  skip_on_travis()
  skip_on_appveyor()
  skip_on_cran()

  res_e1 <- add_image(erasmus1, 1, ops)
  expect_equal(res_e1$image_id, 1)
  expect_equal(res_e1$type, "IMAGE_ADDED")

  res_e2 <- add_image(erasmus2, 2, ops)
  expect_equal(res_e2$image_id, 2)
  expect_equal(res_e2$type, "IMAGE_ADDED")

  res_e3 <- add_image(erasmus3, 3, ops)
  expect_equal(res_e3$image_id, 3)
  expect_equal(res_e3$type, "IMAGE_ADDED")

  res_nw <- add_image(nightwatch, 4, ops)
  expect_equal(res_nw$image_id, 4)
  expect_equal(res_nw$type, "IMAGE_ADDED")

  expect_error(add_image("null", 5, ops))
  expect_error(add_image(nightwatch, "a", ops))
})

results_e1 <- data.frame(
  height = c(827, 803, 796),
  width = c(592, 567, 575),
  x = c(53, 64, 56),
  y = c(142, 159, 173),
  image_id = c(1, 3, 2),
  scores = c(964, 62, 59),
  tags = c(NA, NA, NA),
  stringsAsFactors = FALSE)

results_nw <- data.frame(
  height = 440,
  wdith = 869,
  x = 97,
  y = 324,
  image_id = 4,
  scores = 788,
  tags = NA,
  stringsAsFactors = FALSE)

test_that("Search by image", {
  skip_on_travis()
  skip_on_appveyor()
  skip_on_cran()

  search_e1 <- search_image(erasmus1, ops)
  expect_equivalent(results_as_data_frame(search_e1), results_e1)
  expect_equivalent(bounding_rects(search_e1), results_e1[,1:4])
  expect_equivalent(image_ids(search_e1), results_e1$image_id)
  expect_equivalent(scores(search_e1), results_e1$scores)
  expect_equivalent(tags(search_e1), results_e1$tags)

  search_nw <- search_image(nightwatch, ops)
  expect_equivalent(results_as_data_frame(search_nw), results_nw)
})

test_that("Remove images from hosted Pastec server", {
  skip_on_travis()
  skip_on_appveyor()
  skip_on_cran()

  expect_equal(remove_image(4, ops)$type, "IMAGE_REMOVED")
  search_nw <- search_image(nightwatch, ops)
  expect_null(image_ids(search_nw))
})

test_that("Save and load index", {
  skip_on_travis()
  skip_on_appveyor()
  skip_on_cran()

  index_path <- paste0(getwd(), "/tempindex.dat")
  expect_equal(save_index(index_path, ops)$type, "INDEX_WRITTEN")
  clear_index(ops)
  expect_equal(load_index(index_path, ops)$type, "INDEX_LOADED")
  unlink(index_path)
  search_e1 <- search_image(erasmus1, ops)
  expect_equivalent(results_as_data_frame(search_e1), results_e1)
})
