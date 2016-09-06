## Collection of functions with short names - loops
##
##


##' Apply function with an iterator
##'
##' Performs a loop over a vector or a list, performing an action on each element.
##' The action has access to an indexing variable marking position in x.
##'
##' To provide the iterator, the implementation actually uses a for loop.
##' 
##' The names is short for: (ap)ply (w)ith (i)terator
##' 
##' @param x vector or list
##' @param FUN function. The structure of the function should be function(i, x)
##' where 'i' is an index variable and 'x' is the data.
##' @param ... parameters passed on to FUN
##'
##' @export
apwi = function(X, FUN, ...) {

    ## get the iterator names or indexes.
    ## Defaults to integers, but uses names(x) if available
    APWI.INDEXES = seq_len(length(X))
    if (!is.null(names(X))) {
        APWI.INDEXES = names(X)
    }

    ## perform a loop over the input data, and apply the FUN
    APWI.RESULT = list()
    for (APWI.I in APWI.INDEXES) {
        APWI.RESULT[[APWI.I]] = FUN(APWI.I, X[[APWI.I]], ...)
    }

    ## return the result in a quiet way
    invisible(APWI.RESULT)
}






##' Apply function with invisible output
##'
##' Performs a loop over a vector or a list, performing an action on each element.
##' The output is not displayed in the terminal
##'
##' The name is short for: s(ap)ply with (i)invisible (o)utput
##'
##' @param X vector or list
##' @param FUN function
##' @param ... parameters passed on to FUN
##'
##' @export
apio = function(X, FUN, ...) {
    invisible(sapply(X, FUN, ...))
}

