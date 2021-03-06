% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/files.R
\name{wtht}
\alias{wtht}
\title{Write a table to disk}
\usage{
wtht(
  x,
  file,
  rowid.column = NULL,
  row.names = FALSE,
  col.names = TRUE,
  quote = FALSE,
  sep = "\\t",
  ...
)
}
\arguments{
\item{x}{data frame or matrix}

\item{file}{detstination file}

\item{rowid.column}{character, determines name of column that will hold
row names. Leave NULL to use R's standard system, i.e. header with one
fewer element than table body. Set to something, e.g. "rowname" to create
a new column called "rowname" with the actual row names}

\item{row.names}{logical, determines whether to write row names}

\item{col.names}{logical, determines whether to write column names}

\item{quote}{logical, determines quotation marks}

\item{sep}{character, separator for columns}

\item{...}{other parameters passed on to write.table}
}
\description{
A wrapper for write.table. By default this function:
with column names; no row names; no quotation marks; tab
separated columns.
}
\details{
The name is short for: (w)rite (t)able with (h)eader and (t)ab separated
}
