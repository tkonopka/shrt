% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{mtrx}
\alias{mtrx}
\title{Creates a matrix with row and column names}
\usage{
mtrx(
  data = NA,
  row.names = NULL,
  col.names = NULL,
  nrow = NULL,
  ncol = NULL,
  byrow = FALSE
)
}
\arguments{
\item{data}{data vector, contents of the matrix}

\item{row.names}{character vector, row names}

\item{col.names}{character vector, column names}

\item{nrow}{integer, number of rows}

\item{ncol}{integer, number of columns}

\item{byrow}{logical, determines fill direction}
}
\description{
Compared to matrix(), this function has simpler syntax
for creating a matrix with names, especially only 
column names.
}
\details{
The name mtrx is short for (m)a(tr)i(x).
}
