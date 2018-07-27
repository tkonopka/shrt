## Collection of functions dealing with verbosity level
##
## Some of these 
##


##' determine a verbosity level
##'
##' Verbosity can be set via assignments like verbose=TRUE or verbose=2.
##' If such variables are not set anywhere, the last resort is to look in the options()
##'
##' @return usually logical or integer, but depends on what user
##' set previously using verbose=... or setOption("verbose", ...)
##'
##' @export 
detect.verbose = function() {

  ## look through frames to determine if verbose is set
  glob = globalenv()
  n=1
  result = NA
  while (n>0) {
    ##cat("looking at frame n=",n, "\n")
    pp = parent.frame(n)
    if (exists("verbose", envir=pp)) {
      ## try catch is necessary to prevent recursive call when parent
      ## tries to determine verbosity using verbose=detect.verbose()
      tryCatch({
        result = get("verbose", envir=pp)
      }, error=function(e) {}, warning=function(e) {})
    }
    ##cat("value is ", result, "\n")
    if (!is.na(result) & !is.null(result)) {
      return(result)
    }
    if (identical(pp, glob)) {
      n = -1; ## end back-looking through frames
    } else {
      n = n + 1
    }
  }
  
  if (is.na(result) | is.null(result)) {
    result = getOption("verbose")
  }
  result
}

