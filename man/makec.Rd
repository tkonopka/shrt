% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cache.R
\name{makec}
\alias{makec}
\title{Make an object using a function and record in cache}
\usage{
makec(x, constructor, ...)
}
\arguments{
\item{x}{character, name of target object; a side effect
of the function is to add data into an object with this name}

\item{constructor}{function, used to generate object x}

\item{...}{additional arguments passed on to constructor}
}
\value{
integer code:
3 when object generated using contructor
2 when make aborted because object already exists
1 when object loaded from cache
0 (should not happen)
}
\description{
Similar logic to assignc(x), but
}
