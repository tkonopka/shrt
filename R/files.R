## Collection of functions with short names - working with files
##
##




##' Read table from file
##'
##' This is a wrapper for read.table. By default it assumes the file
##' has a header row, is tab separated. By default it does not
##' convert strings into factors.
##'
##' The name is short for: (r)ead (t)able with (h)eader and (t)ab separated
##' 
##' @param f filename
##' @param rowid.column character name of column to use as rownames 
##' @param header logical, determines if to read the header
##' @param sep character, column separator
##' @param stringsAsFactors logical, determines whether strings are
##' converted into factors
##' 
##' @param ... other parameters passed on to read.table
##' 
##' @export
rtht = function(f, rowid.column=NULL, header=TRUE,
  sep="\t", stringsAsFactors=FALSE, ...) {
  
  ans = utils::read.table(f, header=header, sep=sep,
    stringsAsFactors=stringsAsFactors, ...)
  
  ## handle row names from a column
  if (!is.null(rowid.column)) {
    if (!rowid.column %in% colnames(ans)) {
      stop("rtht: rowid.column does not exist in table\n")
    }
    rownames(ans) = ans[, rowid.column]
    ans = ans[, colnames(ans) != rowid.column, drop=FALSE]
  }

  ans
}




##' Write a table to disk
##'
##' This is a wrapper for write.table. By default this function:
##' with column names; no row names; no quotation marks; tab
##' separated columns.
##'
##' The name is short for: (w)rite (t)able with (h)eader and (t)ab separated
##' 
##' @param x data frame or matrix
##' @param file detstination file
##' @param rowid.column character, determines name of column that will hold
##' row names. This is only relevant for row.names=TRUE. Leave NULL to
##' use R's standard system, i.e. header with one fewer element than table
##' body. Set to something, e.g. "rowname" to create a new column called
##' "rowname" with the actual row names
##' @param row.names logical, determines whether to write row names
##' @param col.names logical, determines whether to write column names
##' @param quote logical, determines quotation marks
##' @param sep character, separator for columns
##' @param ... other parameters passed on to write.table
##' 
##' @export
wtht = function(x, file, rowid.column=NULL, row.names=FALSE,
  col.names=TRUE, quote=FALSE, sep="\t", ...) {

  ## when rowid.column is specified, no need to set row.names
  if (!is.null(rowid.column)) {
    row.names=TRUE
  }

  ## perhaps modify the table to incorporate the row names
  if (row.names & !is.null(rowid.column)) {
    if (is.null(rownames(x))) {
      rownames(x) = as.character(seq_len(nrow(x)))
    }
    
    ## what happens if the desired rowid column already
    ## exists in the table? Either forgive or complain
    if (rowid.column %in% colnames(x)) {
      if (!identical(rownames(x), x[, rowid.column])) {
        stop("wtht: rowid.column already exists in table\n")
      }      
    }

    ## all checks passed, augment the table and label the columns
    x = data.frame(rownames(x), x, stringsAsFactors=F)
    colnames(x)[1] = rowid.column
  }

  ## write out the table to disk
  utils::write.table(x, file=file, col.names=col.names, row.names=row.names,
                     quote=quote, sep=sep, ...)  
}





