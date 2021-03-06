% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/verbose.R
\name{detect.verbose}
\alias{detect.verbose}
\title{determine a verbosity level}
\usage{
detect.verbose()
}
\value{
usually logical or integer, but depends on what user
set previously using verbose=... or setOption("verbose", ...)
}
\description{
Verbosity can be set via assignments like verbose=TRUE or verbose=2.
If such variables are not set anywhere, the last resort is to look in the options()
}
