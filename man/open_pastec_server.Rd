% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pastec_servers.R
\name{open_pastec_server}
\alias{open_pastec_server}
\title{Link to a self-run Pastec server}
\usage{
open_pastec_server(url = "localhost", port = 4212)
}
\arguments{
\item{url}{Defaults to \code{localhost://}}

\item{port}{Pastec default port is 4212}
}
\value{
A list with the attributes of the server connection
}
\description{
Link to a self-run Pastec server
}
\seealso{
\link{hosted_pastec_server}
}

