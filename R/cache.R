## Functions for working with a cache
##
## Many of these functions are inter-related and also use function load1




##' Assign value to a variable using value from cache 
##'
##' @param x character, name of object to retrieve from cache
##' @param overwrite logical, when TRUE, load from cache occurs regardless
##' of whether object already exists; when FALSE, assign only happens
##' @param warn logical, determine if show warning when assignment fails
##'
##' @return integer code:
##' 0 when load failed;
##' 1 when object loaded from cache;
##' 2 when assign was aborted because object already exists
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
      assign(x, load1(xfile), envir=parent.frame(n=1))
      result = 1
    } 
  }
  ## be silent when success, perhaps send warning upon failure
  if (result==0 & warn) {
    warning("object ", x, " does not exist in cache")
  }
  invisible(result)
}




##' Set or query a cache directory
##'
##' @param dir character, path to cache directory (will be created if
##' not exists)
##'  
##' @export
cachedir = function(dir=NULL) {
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
  invisible(cachedir())
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
  return(file.path(cachedir(), paste0(x, ".Rda")))
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




##' Make an object using a function and record in cache
##'
##' Similar logic to assignc(x), but 
##'
##' @param x character, name of target object; a side effect
##' of the function is to add data into an object with this name
##' @param constructor function, used to generate object x 
##' @param ... additional arguments passed on to constructor
##'
##' @return integer code:
##' 3 when object generated using contructor
##' 2 when make aborted because object already exists
##' 1 when object loaded from cache
##' 0 (should not happen)
##'
##' @export
makec = function(x, constructor, ...) {
  ## look up if object already exists in environment
  result = 0
  xexists = exists(x, envir=parent.frame(n=1), inherits=FALSE)
  if (xexists) {
    result = 2
  }
  ## perhaps load from cache
  if (result==0) {
    xfile = cachefile(x)
    if (file.exists(xfile)) {
      assign(x, load1(xfile), envir=parent.frame(n=1))
      result = 1
    } 
  }
  ## perhaps construct from scratch and save into cache
  if (result==0) {
    assign(x, constructor(...), envir=parent.frame(n=1))
    eval(parse(text=paste0("savec(", x, ")")), envir=parent.frame(n=1))
    result = 3
  }
  invisible(result)
}




##' Remove an object and its disk-cached match
##'
##' Wrapper for rm(), which in addition attempts to remove a matched
##' file from disk cache (see cachedir())
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
##' object into a matched file in disk cache (see cachedir())
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



