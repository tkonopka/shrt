% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/projects.R
\name{reqvars}
\alias{reqvars}
\title{Check that variables are defined}
\usage{
reqvars(varnames, halt = TRUE)
}
\arguments{
\item{varnames}{vector with variable names}

\item{halt}{logical determines whether stop() is called (stop is reserved)}
}
\value{
logical vector, indicates whether each variable in vars
is defined
}
\description{
The name is short for: (req)uire (var)iable(s)
}
