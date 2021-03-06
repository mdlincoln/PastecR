% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pastec_api.R
\name{clear_index}
\alias{clear_index}
\title{Clear an index}
\usage{
clear_index(server)
}
\arguments{
\item{server}{Pastec server.}
}
\value{
On successful addition, silently returns list with server response.
}
\description{
Directs Pastec to clear the image index.
}
\examples{
\dontrun{
ps <- open_pastec_server()
clear_index(ps)
#> Pastec index cleared.
#> [1] TRUE
}
}

