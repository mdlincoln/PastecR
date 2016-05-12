context("Hosted Pastec API")

# Get image paths
nightwatch <- system.file("img", "SK-C-5.jpg", package = "PastecR")
erasmus1 <- system.file("img", "RP-P-1906-1485.jpg", package = "PastecR")
erasmus2 <- system.file("img", "RP-P-1906-1486.jpg", package = "PastecR")
erasmus3 <- system.file("img", "RP-P-1906-1487.jpg", package = "PastecR")

load("hosted_keys.rda")

hps <- hosted_pastec_server(test_index_id, test_auth_key)

test_that("Clear index", {
  expect_equivalent(clear_index(hps)$type, "INDEX_CLEARED")
})

test_that("Add images to hosted Pastec server", {
  res_e1 <- add_image(erasmus1, 1, hps)
  expect_equal(res_e1$image_id, 1)
  expect_equal(res_e1$type, "IMAGE_ADDED")

  res_e2 <- add_image(erasmus2, 2, hps)
  expect_equal(res_e2$image_id, 2)
  expect_equal(res_e2$type, "IMAGE_ADDED")

  res_e3 <- add_image(erasmus3, 3, hps)
  expect_equal(res_e3$image_id, 3)
  expect_equal(res_e3$type, "IMAGE_ADDED")

  res_nw <- add_image(nightwatch, 4, hps)
  expect_equal(res_nw$image_id, 4)
  expect_equal(res_nw$type, "IMAGE_ADDED")

  expect_error(add_image("null", 5, hps))
  expect_error(add_image(nightwatch, "a", hps))
})

test_that("Unimplemented functions for the hosted API return an error", {
  expect_error(save_index("dummypath", hps))
  expect_error(load_index("dummypath", hps))
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
  search_e1 <- search_image(erasmus1, hps)
  expect_equivalent(results_as_data_frame(search_e1), results_e1)
  expect_equivalent(bounding_rects(search_e1), results_e1[,1:4])
  expect_equivalent(image_ids(search_e1), results_e1$image_id)
  expect_equivalent(scores(search_e1), results_e1$scores)
  expect_equivalent(tags(search_e1), results_e1$tags)

  search_nw <- search_image(nightwatch, hps)
  expect_equivalent(results_as_data_frame(search_nw), results_nw)
})

test_that("Remove images from hosted Pastec server", {
  expect_equal(remove_image(4, hps)$type, "IMAGE_REMOVED")
  search_nw <- search_image(nightwatch, hps)
  expect_null(image_ids(search_nw))
})
