# Collection of functions with short names - loops
#


#' Apply function with an iterator
#'
#' Performs a loop over a vector or a list, performing an action on each element.
#' The action has access to an indexing variable marking position in x.
#'
#' To provide the iterator, the implementation actually uses a for loop.
#' 
#' The names is short for: (ap)ply (w)ith (i)terator
#' 
#' @param x vector or list
#' @param fun function. The structure of the function should be function(i, x)
#' where 'i' is an index variable and 'x' is the data.
#' @param ... parameters passed on to FUN
#'
#' @export
apwi = function(x, fun, ...) {

  # get the iterator names or indexes.
  # Defaults to integers, but uses names(x) if available
  apwi.indexes = seq_len(length(x))
  if (!is.null(names(x))) {
    apwi.indexes = names(x)
  }
  
  # perform a loop over the input data, and apply the FUN
  apwi.result = list()
  for (apwi.i in apwi.indexes) {
    apwi.result[[apwi.i]] = fun(apwi.i, x[[apwi.i]], ...)
  }
  
  # return the result in a quiet way
  invisible(apwi.result)
}

