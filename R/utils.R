## Collection of functions with short names - general purpose
##
##





##' Write a message to the console, but only if in verbose mode
##'
##' The name is short for: (cat) when in (v)erbose mode
##'
##' @param ... arguments to write out
##' @param verbose logical or NA, logical values turn verbose mode
##' on and off; a value of NA implies that verbose mode is inferred
##' from a "verbose" variable in a parent environment or from global
##' options.
##'
##' @export
catv = function(..., verbose=detect.verbose()) {
  if (verbose) {
    cat(...)
  }
  invisible()
}




##' evaluate if object is empty (length 0)
##'
##' The name is short for: object is (empty)
##'
##' @param x object, vector, list, matrix
##'
##' @return logical value, TRUE if object is of length zero
##'
##' @export
empty = function(x) {
  length(x)==0
}




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




##' Return first element 
##'
##' The name is short for: (h)ead with n=(1)
##'
##' @param x vector, matrix, data-frame, or nany object that can be
##' processed by head()
##' @param ... parameters passed on to head
##'
##' @export
h1 = function(x, ...) {
  head(x, n=1, ...)
}




##' Return second element 
##'
##' The name is short for: (h)ead with n=(2)
##'
##' @param x vector, matrix, data-frame, or any object that can be
##' processed by head()
##' @param ... parameters passed on to head
##'
##' @export
h2 = function(x, ...) {
  head(x, n=2, ...)
}




##' Return third element 
##'
##' The name is short for: (h)ead with n=(3)
##'
##' @param x vector, matrix, data-frame, or any object that can be
##' processed by head()
##' @param ... parameters passed on to head
##'
##' @export
h3 = function(x, ...) {
  head(x, n=3, ...)
}




##' length of grep result
##'
##' @param pattern character string with a grep pattern
##' @param x character vector to search in
##' @param ... any other arguments passed on to grep()
##'
##' @return integer, length of grep result
##'
##' @export
lengrep = function(pattern, x, ...) {
  length(grep(pattern, x, ...))
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




##' Collect objects into a named list
##'
##' The names is short for: (l)i(st) from named entities
##'
##' @param ... several arguments
##'
##' @return a named list holding to input objects
##'
##' @examples
##' a = 4
##' b = 3
##' lst(a, b)
##'
##' @export
lst = function(...) {
  # fetch the arguments as a list
  result = list(...)
  # identify all the labels
  labels = as.character(substitute(list(...)))[-1]
  # transfer the labels that are not present in "data"
  if (length(names(result))==0) {
    wolabs = rep(TRUE, length(result))
  } else {
    wolabs = names(result)==""
  }
  names(result)[wolabs] = labels[wolabs]
  result
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




##' Create a named list using an existing object or data frame
##'
##' The name is short for: (n)amed (list)
##'
##' @param x object, can be vector, matrix, or data.frame
##' @param values.col character, identifies source of values for the list
##' @param names.col charcter, identifies source of names for the list
##'
##' @return named list
##'
##' @examples
##' nlist(c("a", "b", "c"))
##' nlist(values=c(1,2,3), names=c("x", "y", "z"))
##'
##' @export
nlist = function(x=NULL, values.col=NULL, names.col=NULL) {
  xnames = xval = NULL
  if (!is.null(x)) {
    ## handle when first input is matrix-like
    if (class(x)=="matrix" | class(x)=="data.frame") {
      if (is.null(names.col)) {
        names.col=values.col
      }
      # check that relevant columns exist
      check.col = function(z) {
        if (is.null(z) | !(z %in% colnames(x))) {
          stop("nvec: invalid column name ", z, "\n")
        }
      }
      check.col(values.col)
      check.col(names.col)
      xnames = x[, names.col]
      xval = x[, values.col]
    } else {
      xval = x
      xnames = x
    }
  } else {
    ## handle using values and names separately
    if (is.null(values.col)) {
      stop("x and values cannot both be null\n")
    } else {
      if (is.null(names.col)) {
        names.col = values.col
      }
      xval = values.col
      xnames = names.col
    }    
  }
  setNames(as.list(xval), xnames)
}




##' Create a named vector using two columns in a data-frame
##'
##' The name is short for: (n)amed (vec)tor
##'
##' @param x data frame
##' @param values.col character, column in x used for vector values
##' @param names.col character, column in x used for vector names
##'
##' @return named vector
##'
##' @examples
##' df = data.frame(A=letters[1:4], B=c(4,2,3,1))
##' nvec(df, "B", "A")
##'
##' @export
nvec = function(x, values.col=NULL, names.col=NULL) {
  # check that relevant columns exist
  check.col = function(z) {
    if (is.null(z) | !(z %in% colnames(x))) {
      stop("nvec: invalid column name ", z, "\n")
    }
  }
  check.col(values.col)
  check.col(names.col)
  # check that names are unique
  if (length(unique(x[, names.col])) != nrow(x)) {
    stop("nvec: names are not unique\n")
  }
  # the proper calculation
  setNames(x[, values.col], x[, names.col])
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




##' Extract a component from an object
##'
##' @param x object - either vector, list, matrix, etc
##' @param n integer or string that identifies a part of x
##' @param type string, identifies 
##'
##' @export
pluck = function(x, n, type=c("auto", "character", "integer", "numeric", "logical",
                              "list", "matrix", "data.frame")) {
    type = match.arg(type)
    if (type=="auto") {
        pluck(x, n, class(x))
    } else if (type %in% c("vector", "character", "integer", "numeric", "logical")) {
        return(x[n])
    } else if (type=="list") {
        return(x[[n]])
    } else if (type=="matrix" | type=="data.frame") {
        return(x[n,])
    }
}




##' Extract the first component from an object
##'
##' @param x object - either vector, list, matrix, etc
##' @param type string, see pluck() for details
##'
##' @export
pluck1 = function(x, type=class(x)) {
    pluck(x, 1, type)
}




##' Extract the second component from an object
##'
##' @param x object - either vector, list, matrix, etc
##' @param type string, see pluck() for details
##'
##' @export
pluck2 = function(x, type=class(x)) {
    pluck(x, 2, type)
}




##' Get a string with today's date, e.g. 20171126
##'
##' @param sep character - separating character between year, month, day
##'
##' @export
today = function(sep="") {
  today.format = paste("%Y", "%m", "%d", sep=sep)
  format(Sys.time(), today.format)
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


