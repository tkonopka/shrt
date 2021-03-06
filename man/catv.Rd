% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{catv}
\alias{catv}
\title{Write a message to the console, but only if in verbose mode}
\usage{
catv(..., verbose = detect.verbose())
}
\arguments{
\item{...}{arguments to write out}

\item{verbose}{logical or NA, logical values turn verbose mode
on and off; a value of NA implies that verbose mode is inferred
from a "verbose" variable in a parent environment or from global
options.}
}
\description{
The name is short for: (cat) when in (v)erbose mode
}
