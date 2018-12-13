## Collection of functions with short names - related to handling plots and graphics
##
##



##' create an interval to catch a set proportion of input data based on quantiles
##'
##' The name is short for: (lim)its to capture (q)uantiles
##'
##' @param data list, data-frame, or matrix with input data
##' @param quantiles numeric of length 2, used in quantiles()
##' @param lim numeric of length 2, starting interval, values with NA are filled in
##'            and positions with non-NA are left alone.
##' @param column identifier for column 
##' @param pretty numeric of length 2, ensures that limits are multiples of these values
##'
##' @return numeric vector of length 2 with (min, max) values for limits
##'
##' @export
limq = function(data, quantiles=c(0.01, 0.99), lim=c(NA, NA),
                column=NA, pretty=c(NA, NA)) {

  # create a single vector with relevant data
  fetchValues = function(x, column) {
    if (length(column)==1) {
      if (is.na(column)) {
        return(x)
      }
    }
    x[, column]
  }
  
  if (class(data)=="list") {
    vals = unlist(lapply(data, fetchValues, column))
  } else if (sum(class(data) %in% c("matrix", "data.frame"))) {
    vals = fetchValues(data, column)
  } else {
    vals = data
  }
  vals = as.numeric(unlist(vals))

  # for safety, set inputs to vectors of length 2
  quantiles = quantiles[1:2]
  lim = lim[1:2]
  pretty = pretty[1:2]

  # fill in missing values in lim
  missing = is.na(lim)
  lim[missing] = quantile(vals, p=quantiles, na.rm=TRUE)[missing]

  ## prettify lower and upper limit
  prettylim = function(x, p, type) {
    if (is.na(p)) {
      return (x)
    }
    x.p = x/p
    if (type=="lower") {
      x.p = floor(x.p)
    } else if (type=="upper") {
      x.p = ceiling(x.p)
    }
    x.p*p
  }
  lim[1] = prettylim(lim[1], pretty[1], "lower")
  lim[2] = prettylim(lim[2], pretty[2], "upper")
  
  lim
}




##' Widen an interval by a relative amount
##'
##' This can be useful while specifying the x/y limits for a plot
##'
##' @param interval numeric vector of length 2
##' @param by numeric vector of length 2,
##' percentage widening on each side of the interval
##' @param log boolean, if TRUE, widen so that "by" percentage
##' is perceived on a logarithmic scale
##' 
##' @export
widen = function(interval, by=c(0.05, 0.05), log=FALSE) {
  if (length(interval)!=2) {
    stop("widen is meant to act on a range of length 2\n")
  }
  ## adjust so that by is always a vector of length 2
  if (length(by)<2) {
    by = rep(by, 2)
  }
  by = by[1:2]
 
  if (log) {
    interval = log2(interval)
  }
  ## add a percentage of the interval width on each side of the interval
  result = (interval + (c(-1, 1)*(interval[2]-interval[1])*by))
  if (log) {
    result = 2^result
  }
  
  result
}

