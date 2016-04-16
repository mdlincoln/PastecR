PastecR
=======

Wrapper for the [Pastec](http://pastec.io/) image search and recognition engine API.

[Directions for building and running Pastec can be found here.](http://pastec.io/doc#setup)
(Note that if you are trying to install Pastec on OS X or Ubuntu, you may find that [this fork does better at locating the necessary libraries.](https://github.com/mdlincoln/pastec/tree/libjson_fix))

Once you have an instance of Pastec running, you can start interacting with it using PastecR.

## Installation

```r
# install.packages("devtools")
devtools::install_github("mdlincoln/PastecR")
library(PastecR)
```

## Usage

Set the location of the Pastec server

```r
ps <- pastec_server(url = "localhost", port = 4212)
```

Add and remove images.

```r
# Add an image to the Pastec index
add_image("image1.jpg", image_id = 1, server = ps)

# Remove an image from the Pastec index
remove_image(image_id = 1, server = ps)
```

Search the index for similar images.

```r
# Fuzzy match an image
match_results <- search_image("image2.jpg", server = ps)

results_as_data_frame(match_results)

#   height width  x   y image_id score tags
# 1    476   631 52  53    81815    81   NA
# 2    416   637 46 108   195962    59   NA
```

---
[Matthew Lincoln](http://matthewlincoln.net)
