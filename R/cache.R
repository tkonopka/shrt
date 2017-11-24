## Functions for working with a cache
##




##' Set or query a cache directory
##'
##' @param dir character, path to cache directory.
##'  
##' @export
cache = function(dir=NULL) {
  if (is.null(dir)) {
    cachedir = getOption("cachedir")
    if (is.null(cachedir)) {
      cachedir = getwd()
    }
    return (cachedir)
  } else {
    options(cachedir=file.path(normalizePath(dir)))
  }
  invisible(cache())
}




##' Remove an object and its disk-cached match
##'
##' Wrapper for rm(), which in addition attempts to remove a matched
##' file from disk cache (see cache())
##'
##' WARNING: This function will remove files from the file system;
##' use with caution.
##'
##' @param x object to remove
##'
##' @export
rmc = function(x) {
  ## construct path to cached file
  xsub = deparse(substitute(x))
  cachefile = file.path(cache(), paste0(xsub, ".Rda"))
  ## remove cached file
  if (file.exists(cachefile)) {
    file.remove(cachefile)
  }
  ## remove object from parent environment
  rmexp = paste0("rm(", substitute(x), ")")
  eval(parse(text=rmexp), envir=parent.frame(n=1))
}




##' Save an object into disk-based cache
##'
##' Wrapper for save(), which write an Rda representation of an
##' object into a matched file in disk cache (see cache())
##'
##' @param x object to save
##'
##' @return full path to the saved object
##'
##' @export
savec = function(x) {
  ## construct path to output file
  xsub = deparse(substitute(x))
  cachefile = file.path(cache(), paste0(xsub, ".Rda"))
  ## execute the save
  saveexp = paste0("save(", substitute(x), ", file='", cachefile, "')")
  eval(parse(text=saveexp), envir=parent.frame(n=1))
  invisible(cachefile)
}




##' Retrieve object from cache
##'
##' Look up content in the cache. By default, create or overwrite an
##' object in calling environment with contents from cache
##'
##' @param x character, name of object to retrieve from cache
##' @param envir logical, whether to assign cache value to an object
##' in calling environment
##'
##' @export
loadc = function(x, envir=TRUE) {
  ## safety checks 
  if (class(x)=="factor") {
    x = as.character(x)
  }
  if (class(x)!="character") {
    stop("x must be a character of factor\n")
  }
  ## load file from cache
  xval = load1(file.path(cache(), paste0(x, ".Rda")))
  if (envir) {
    assign(x, xval, envir=parent.frame(n=1))
  } 
  invisible(xval)
}

