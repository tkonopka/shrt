## Collection of functions with short names - related to handling plots and graphics
##
##




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

