## Collection of functions with short names - working with files
##
##




##' Load one R object from an Rda file
##'
##' Loads an object from an Rda file. In contrast to
##' standard load(), this function does not put the loaded object
##' in the current environment. Rather, this function returns the loaded
##' data as an object. It is thus possible to save an object x using
##' save(x, file=myfile), and then retrieve it using y = load1(myfile). 
##'
##' The name is short for: (load 1) object
##'
##' @param file filename with Rda object
##'
##' @export
load1 = function(file) {
  if (!file.exists(file)) {
    stop("file does not exist: ", file, "\n")
  }
  ## load from file into weird-name variable to avoid overwriting data
  tempAJIDPJSJXFOPP238Q = load(file)
  if (length(tempAJIDPJSJXFOPP238Q)>1) {
    stop("load1: loading file creates more than one object\n")
  }
  tempAJIDPJSJXFOPP238Q = paste0("return(", tempAJIDPJSJXFOPP238Q[1], ")")
  eval(parse(text=tempAJIDPJSJXFOPP238Q))
}




##' Load contents of directory (from multiple files of different types)
##'
##' Scans a directory and loads data from all files,
##' using an appropriate loader for each file extension type.
##'
##' @param dirpath path for input directory
##' @param extensions vector of extensions to try to load
##' @param verbose logical, prints filenames as it is loading them
##' @param ... other parameters passed on to rtht
##'
##' @export
loaddir = function(dirpath, extensions=c("Rda", "txt", "txt.gz",
                                         "json", "json.gz",
                                         "tsv", "tsv.gz", "csv", "csv.gz"),
                   verbose=FALSE,
                   ...) {

  ## identify content of directory with acceptabel extensions
  extpattern = paste(paste0(extensions, "$"), collapse="|")
  allfiles = list.files(dirpath, full.names=TRUE, pattern=extpattern)  

  ## helper for converting a filename with special characters into an R name
  safeName = function(f) {
    if (endsWith(f, "csv") | endsWith(f, "tsv") | endsWith(f, "txt") | endsWith(f, "Rda")) {
      f = substr(f, 1, nchar(f)-4)
    } else if (endsWith(f, "csv.gz") | endsWith(f, "tsv.gz") | endsWith(f, "txt.gz")) {
      f = substr(f, 1, nchar(f)-7)
    } else if (endsWith(f, "json")) {
      f = substr(f, 1, nchar(f)-5)
    } else if (endsWith(f, "json.gz")) {
      f = substr(f, 1, nchar(f)-8)
    }
    gsub("-| ", "_", f)
  }
  
  ## loop through files and load each one in turn
  result = vector("list", length(allfiles))
  names(result) = sapply(basename(allfiles), safeName)
  for (onefile in allfiles) {
    x = basename(onefile)
    if (verbose) {
      cat(x, "\n")
    }
    if (endsWith(x, "Rda")) {
      xdata = load1(onefile)
    } else if (endsWith(x, "json") | endsWith(x, "json.gz")) {
      xdata = fromJSON(onefile)
    } else if (endsWith(x, "csv") | endsWith(x, "tsv")  | endsWith(x, "txt") |
                 endsWith(x, "csv.gz") | endsWith(x, "tsv.gz") | endsWith(x, "txt.gz")) {
      xdata = rtht(onefile, ...)
    } else {
      stop("unsupported extension for file ", x, "\n")
    }
    result[[safeName(x)]] = xdata
  }
  
  result
}




##' Read table from file
##'
##' A wrapper for read.table. By default, it assumes the file
##' has a header row, is tab separated. By default it does not
##' convert strings into factors.
##'
##' The name is short for: (r)ead (t)able with (h)eader and (t)ab separated
##' 
##' @param f filename
##' @param rowid.column character name of column to use as rownames 
##' @param header logical, determines if to read the header
##' @param sep character, column separator
##' @param comment.char character denoting line-to-ignore (comment)
##' @param stringsAsFactors logical, determines whether strings are
##' converted into factors 
##' @param ... other parameters passed on to read.table
##' 
##' @export
rtht = function(f, rowid.column=NULL, header=TRUE,
                sep="\t", comment.char="#", stringsAsFactors=FALSE, ...) {
  
  ans = utils::read.delim(f, header=header, sep=sep,
                          comment.char=comment.char,
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
##' A wrapper for write.table. By default this function:
##' with column names; no row names; no quotation marks; tab
##' separated columns.
##'
##' The name is short for: (w)rite (t)able with (h)eader and (t)ab separated
##' 
##' @param x data frame or matrix
##' @param file detstination file
##' @param rowid.column character, determines name of column that will hold
##' row names. Leave NULL to use R's standard system, i.e. header with one
##' fewer element than table body. Set to something, e.g. "rowname" to create
##' a new column called "rowname" with the actual row names
##' @param row.names logical, determines whether to write row names
##' @param col.names logical, determines whether to write column names
##' @param quote logical, determines quotation marks
##' @param sep character, separator for columns
##' @param ... other parameters passed on to write.table
##' 
##' @export
wtht = function(x, file, rowid.column=NULL, row.names=FALSE,
  col.names=TRUE, quote=FALSE, sep="\t", ...) {

  ## when rowid.column is specified, change the input table x with new column
  if (!is.null(rowid.column)) {
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



