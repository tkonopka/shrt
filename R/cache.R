## Functions for working with a cache
##




##' Set or query a cache directory
##'
##' @param dir character, path to cache directory (will be created if
##' not exists)
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
    ## create directory if not exists
    if (!file.exists(dir)) {
      dir.create(dir)
    }
    options(cachedir=file.path(normalizePath(dir)))
  }
  invisible(cache())
}





##' Get path to a cache file matching object
##'
##' @param x character, object name of interest
##'
##' @return character, path to file
##'
##' @export
cachefile = function(x) {
  ## type check on input
  if (class(x)=="factor") {
    x = as.character(x)
  }
  if (class(x)!="character") {
    stop("x must be a character of factor\n")
  }
  return(file.path(cache(), paste0(x, ".Rda")))
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
  xfile = cachefile(xsub)
  ## remove cached file
  if (file.exists(xfile)) {
    file.remove(xfile)
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
  xfile = cachefile(xsub)
  ## execute the save
  saveexp = paste0("save(", substitute(x), ", file='", xfile, "')")
  eval(parse(text=saveexp), envir=parent.frame(n=1))
  invisible(xfile)
}




##' Retrieve object from cache
##'
##' Look up content from the cache. 
##'
##' @param x character, name of object to retrieve from cache
##' 
##' @export
loadc = function(x) {
  return(load1(cachefile(x)))
}




##' Check if an object exists in cache
##'
##' @param x character, name of object to lookup in cache
##'
##' @return logical, TRUE if matchin file exists in cache
##'
##' @export
existsc = function(x) {
  return(file.exists(cachefile(x)))
}




##' Assign value to a variable using value from cache 
##'
##' @param x character, name of object to retrieve from cache
##' @param overwrite logical, when TRUE, load from cache occurs regardless
##' of whether object already exists; when FALSE, assign only happens
##' @param warn logical, determine if show warning when assignment fails
##'
##' @return integer code, 0 when load failed; 1 if object loaded from cache; 2 if assign
##' was aborted because object already exists
##'
##' @export
assignc = function(x, overwrite=FALSE, warn=FALSE) {
  ## look up if object exists
  result = 0
  if (!overwrite) {
    xexists = exists(x, envir=parent.frame(n=1), inherits=FALSE)
    if (xexists) {
      result = 2
    }
  }
  if (result==0) {
    ## look up if file exists
    xfile = cachefile(x)
    if (file.exists(xfile)) {
      xval = load1(xfile)
      assign(x, xval, envir=parent.frame(n=1))
      result = 1
    } 
  }
  ## be silent when success, explicit
  if (result==0 & warn) {
    warning("object ", x, " does not exist in cache")
  }
  invisible(result)
}

