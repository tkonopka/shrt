## Collection of functions with short names - color manipulation
##
##




##' Convert numbers [0,1] into two-digit hex [00,ff]
##'
##' The names is short for: convert (x) (to) a (hex) value. Useful for
##' generating transparency levels.
##'
##' @param x numeric vector
##' @param type use "x" for lowercase hex and "X" for uppercase hex
##' 
##' @export
x2hex = function(x, type="x") {
  ## deal with edge case where x is a single NA value
  ## This case causes errors in the sprintf below
  ## (cases with NA inside a vector are handled correctly below)
  if (length(x)==1) {
    if (is.na(x)) {
      return(NA)
    }
  }
  ## deal with x in [0,1] only
  x[x>1] = 1
  x[x<0] = 0
  ## get a first conversion into hex
  ans = sprintf(paste0("%02",type), round(x * 255))
  if (class(x)=="matrix") {
    ans = matrix(ans, ncol=ncol(x))
    rownames(ans) = rownames(x)
    colnames(ans) = colnames(x)
  } else {
    names(ans) = names(x)
  }
  ## but above changes NA into text "NA" -> restore real NA
  badx = !is.finite(x)
  ans[badx] = x[badx]
  ans
}



##' Convert numbers or matrices into colors with transparency
##'
##' The name is short for: convert (x) (to) a (col)or with transparency
##' shading. Useful for generating heatmaps.
##' 
##' @param x numeric vector or matrix.
##' @param col vector of two colors in #XXXXXX format.
##' First element determines color associated with negative values.
##' Second element determines color associated with positive values
##' @param maxval numeric. Value for which color reaches saturation.
##' @param bgcol color of background. Colors with full transparency
##' will be replaced with this bg color instead.
##'
##' @export
x2col = function(x, col=c("#0000ff", "#ff0000"), maxval=1,
                 bgcol="#ffffff") {
  
  ## keep track of all NAs (will restore at the end)
  x.na = is.na(x)
  
  ## replaces colors with full transpancy with bg color
  bgreplace = function(z) {
    if (!is.null(bgcol)) {
      z[x==0]=bgcol
    }
    z[x.na] = NA
    z
  }
  
  if (class(x)=="matrix") {
    ## convert matrix into a vector, transform, reformat into matrix
    xcols = x2col(as.vector(x), col=col, maxval=maxval, bgcol=bgcol)
    ans = mtrx(xcols, col.names=colnames(x), row.names=rownames(x))
    return (ans)
  } 
  
  ## here assume x is simple vector    
  ## create a boolean vector of colors based on sign of x
  ans = rep(col[1], length(x))
  ans[x>0 & !x.na] = col[2]    
  ## make sure values are within [-1, 1] range
  x[x>maxval & !x.na] = maxval;
  x[x<(-maxval) & !x.na] = -maxval;
  x = x/maxval    
  ## append a transparency value
  ans = setNames(paste0(ans, x2hex(abs(x))), names(x))
  bgreplace(ans)
}

