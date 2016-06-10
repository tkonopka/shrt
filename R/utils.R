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



