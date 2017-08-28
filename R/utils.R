## Collection of functions with short names - general purpose
##
##


##' Pattern matching 
##'
##' This is a wrapper for grep. By default it returns the matching
##' values as opposed to the indeces where the hits occur.
##'
##' The name is short for: (grep) returning (v)alues.
##' 
##' @param pattern character, pattern to look for
##' @param x character vector, object wherein to look for the pattern
##' @param value logical, set to T to return the values in that
##' match the pattern
##' @param ... parameters passed on to grep
##'
##' @export
grepv = function(pattern, x, value=T, ...) {
  base::grep(pattern, x, value=value, ...)
}




##' Creates a matrix with row and column names
##'
##' Compared to matrix(), this function has simpler syntax
##' for creating a matrix with names, especially only 
##' column names.
##'
##' The name mtrx is short for (m)a(tr)i(x).
##'
##' @param data data vector, contents of the matrix
##' @param row.names character vector, row names
##' @param col.names character vector, column names
##' @param nrow integer, number of rows
##' @param ncol integer, number of columns
##' @param byrow logical, determines fill direction
##'
##' @export
mtrx = function(data=NA, row.names=NULL, col.names=NULL, 
  nrow=NULL, ncol=NULL, byrow=FALSE) {

  if (!is.null(nrow) & !is.null(row.names)) {
    if (length(row.names)!=nrow) {
      stop("mtrx: number of rows do not match\n")
    }
  }
  if (!is.null(ncol) & !is.null(col.names)) {
    if (length(col.names)!=ncol) {
      stop("mtrx: number of cols do not match\n")
    }
  }

  if (is.null(ncol)) {
    ncol = length(col.names)
  }
  if (is.null(nrow)) {
    nrow = length(row.names)
  }
  
  ans = matrix(data, nrow=nrow, ncol=ncol, byrow=byrow)
  colnames(ans) = col.names
  rownames(ans) = row.names
  
  ans
}




##' Create new empty object
##'
##' This is a wrapper for vector() followed by setting names
##'
##' The name is short for: (new) (v)ector 
##' 
##' @param mode character, specifies what kind of vector to create
##' @param length integer, length of vector to create
##' @param names character, vector of names to create
##'
##' @export
newv = function(mode="list", length=0, names=NULL) {

  ## handle length and names parameters
  if (!is.null(names)) {
    if (length==0) {
      length = length(names)
    } else {
      if (length!=length(names)) {
        stop("newv: specified length and names are not consistent\n")
      }
    }
  }

  ## create the object
  ans = base::vector(mode, length)
  
  ## possibly name the elements
  if (!is.null(names)) {
    names(ans) = names
  }
  
  ans
}




##' Get element names in a vector that hold given values
##'
##' The name is short for: (names) of elements with given (V)alues 
##' 
##' @param x vector 
##' @param v vector of value within x to look for
##' 
##' @export
namesV = function(x, v) {    
    if (is.null(names(x))) {
        stop("namesV: input does not have names\n")
    }    
    names(x[x %in% v])
}




##' Get element names in a vector that hold value TRUE
##'
##' This function is a derivative of namesV
##' 
##' @param x logical vector
##'
##' @export
namesT = function(x) {
    if (class(x)!="logical") {
        stop("namesT: input x must be logical, instead it is of class ", class(x), "\n")
    } 
    namesV(x, TRUE)
}




##' Get element names in a vector that hold value FALSE
##'
##' This function is a derivative of namesV
##' 
##' @param x logical vector
##'
##' @export
namesF = function(x) {
    if (class(x)!="logical") {
        stop("namesT: input x must be logical, instead it is of class ", class(x), "\n")
    } 
    namesV(x, FALSE)
}




##' Get element names in a vector that are NA
##'
##' This function is a derivative of namesV
##' 
##' @param x vector
##'
##' @export
namesNA = function(x) {    
    namesV(x, NA)
}




##' Get number of unique elements in a vector
##'
##' The name is short for: (len)th of (u)nique(x)
##' 
##' @param x vector
##'
##' @export
lenu = function(x) {    
    length(unique(x))
}




##' Concatenate strings
##'
##' This is an exact copy of paste0, just the name is shorter
##'
##' @param ... passed on to paste0
##'
##' @export
p0 = function(...) {
  base::paste0(...)
}




##' convert an object to a data.frame
##'
##' The names is short for: convert (x) (to) a (d)ata (f)frame. Useful for
##' generating transparency levels.
##'
##' @param x object, could be a matrix, data.table, etc. 
##' @param stringsAsFactors logical, convert character-columns to factors or not
##'
##' @export
x2df = function(x, stringsAsFactors=F) {
    cx = class(x)[1]
    if (cx=="data.frame") {
        return(x)
    }
    saf = stringsAsFactors
    ## special cases
    ## perhaps convert a named vector into a one-row data frame
    if (cx %in% c("numeric", "integer", "logical", "character", "factor")) {
        if (!is.null(names(x))) {
            if (length(names(x))==length(x)) {
                result = matrix(x, ncol=length(x))
                colnames(result) = names(x)
                rownames(result) = NULL
                return(x2df(result, saf))
            }
        }
    }
    ## the default behavior is to apply data.frame() 
    data.frame(x, stringsAsFactors=saf)        
}


