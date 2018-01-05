## Collection of functions with short names - project management
##
##




##' Initialize a directory structure for a project
##'
##' The name is short for: (init)ialize a new (p)roject
##'
##' @param workdir directory path, root directory for new project
##' @param subdirs character vector, names for subdirectories
##' @param verbose logical. If TRUE the function outputs progress messages.
##' @param ... additional arguments passed on to dir.create, e.g. permission
##' codes. See dir.create for details
##' 
##' @export
initp = function(workdir,
  subdirs=c("notes", "figures", "tables", "Rda", "data", "code"),
  verbose=TRUE, ...) {

  ## some subdirectories will not be allowed ("work" and "version")
  if ("work" %in% subdirs) {
    stop("initp: subdirectory 'work' is not permitted\n")
  }
  
  ## helper function, check for a directory
  makeDir = function(dd, ...) {
    if (!file.exists(dd)) {
      if (verbose) {
        msg("Creating: ",dd)
      }
      dir.create(dd, ...)
    }
    normalizePath(dd)
  }
  
  ## create base work directory and subdirectories
  ans = list();  
  ans$work = makeDir(workdir, ...);
  for (nowsub in subdirs) {
    ans[[nowsub]] = makeDir(file.path(workdir, nowsub), ...);
  }

  ## the output is a list with the directory structure
  invisible(ans)
}





##' Check that variables are defined
##'
##' The name is short for: (req)uire (var)iable(s)
##'
##' @param varnames vector with variable names
##' @param halt logical determines whether stop() is called (stop is reserved)
##'
##' @return logical vector, indicates whether each variable in vars
##' is defined
##' 
##' @export
reqvars = function(varnames, halt=TRUE) {

  ## check that each variable exists in parent environment
  varexists = sapply(as.character(varnames), function(x) {
    ##xe = exists(x, parent.frame())
    xe = exists(x, where=-1)
    if (!xe) {
      message("Missing variable: ", x, "\n")
    }
    xe
  })
  
  if (halt & sum(!varexists)>0) {
    stop("Missing variables\n", call.=FALSE)
  }
  
  ## output is a vector with existence values for each variable
  invisible(varexists)
}

