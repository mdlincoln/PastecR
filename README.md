PastecR
=======

[![Travis-CI Build Status](https://travis-ci.org/mdlincoln/PastecR.svg?branch=master)](https://travis-ci.org/mdlincoln/PastecR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/mdlincoln/PastecR?branch=master&svg=true)](https://ci.appveyor.com/project/mdlincoln/PastecR)

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

[Pastec](http://pastec.io/) is an [open-source](https://github.com/Visu4link/Pastec) image matching engine that does Google-images-esque fuzzy searching of a database of images that you compile.
It is very good at finding close-but-not-exact matches, such as different versions of a photograph, or rotated, cropped, or resized versions of images.

PastecR provides a wrapper around the Pastec API, which can be particularly useful when parsing the results returned by an image search request.

## Self-hosted or Saas?

You can [compile and run](http://pastec.io/doc/oss/) Pastec yourself, however there is also a hosted version available with both a free and a paid option at <https://api.pastec.io>.
PastecR supports both options:


```r
library(PastecR)

# open_pastec_server defaults to the same port defaults as Pastec
ops <- open_pastec_server(url = "localhost", port = 4212)

# You can find the index_id and auth_key for your api.pastec.io account at
# <https://api.pastec.io/manager/apiPage>
hps <- hosted_pastec_server(index_id = "XXXXXXXXXXXXXXXXXXXX", auth_key = "XXXXXXXXXXXXXXXXXXXX")
```

## Load images and search

We'll be using a number of artowrks for this example, including three different versions of a print.

![Portret van Desiderius Erasmus, Philips Galle, Hans Holbein (II), Benedictus Arias Montanus, 1572](http://www.rijksmuseum.nl/media/assets/RP-P-1906-1485&200x200)
![Portret van Desiderius Erasmus, Philips Galle, Hans Holbein (II), Janus Vitalis, 1604 - 1608](http://www.rijksmuseum.nl/media/assets/RP-P-1906-1486&200x200)
![Portret van Desiderius Erasmus, Philips Galle, Hans Holbein (II), Benedictus Arias Montanus, 1572](http://www.rijksmuseum.nl/media/assets/RP-P-1906-1487&200x200)
![Militia Company of District II under the Command of Captain Frans Banninck Cocq, Known as the 'Night Watch', Rembrandt Harmensz. van Rijn, 1642](http://www.rijksmuseum.nl/media/assets/SK-C-5&200x200)

Once you have established either your own instance of Pastec, or an account at <https://api.pastec.io>, you may add images with the `add_image()` command.
You must set an integer `image_id` when adding.


```r
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
```

Once your index is loaded, you can search for similar images, and parse the results with a number of helper commands.


```r
search_result <- search_image(erasmus1, ops)
results_as_data_frame(search_result)
```

```
##   height width  x   y image_id scores tags
## 1    827   592 53 142        1    964   NA
## 2    803   567 64 159        3     62   NA
## 3    796   575 56 173        2     59   NA
```

See `?pastec_response` for other parsing functions.

## Index operations

To clear the index, use `clear_index(server)`.
On the open, self-hosted version of Pastec, you can also save and load index files to disk by using `save_index()` and `load_index()`.
At the moment, these commands are not available for the SaaS version of pasted, and will throw an error.

---
[Matthew Lincoln](http://matthewlincoln.net)
