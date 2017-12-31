## Collection of functions with short names - message logging
##
##



##' Create new message logging object
##'
##' @param verbose logical, determines if message passed to the
##' logging function are sent back to console via 'message'
##' @param date logical, determines if messages are recorded
##' with current date and time
##' 
##' @export
newmsg = function(verbose=TRUE, date=TRUE) {

  ## data structures that hold the state of the log
  history = vector("list", 16)
  history.i = 0

  ## the output of this function is another function that allows
  ## storing values into the history structures
  function(x=NULL, ..., action=c("log", "get", "show", "reset")) {
    action = match.arg(action)
    
    ## by default, if no input, assume user wants to see the log
    if (is.null(x) & action=="log") {
      action="show"
    }

    if (length(list(...))>0) {
        x = paste(x, ..., collapse=" ")
    }
    if (date) {
      x = paste0("[", Sys.time(), "]\t", x)
    }
    
    ## for logging, need to save x into history
    if (action=="log") {
      if (length(history) < round((history.i*1.2))) {
        history <<- c(history, vector("list", length(history)))
      }      
      history.i <<- history.i + 1;
      history[[history.i]] <<- x      
      if (verbose) message(x)      
    }
    
    ## for retrieving log info
    if (action %in% c("get", "show") ) {
      temp <- unlist(history)
      if (action=="show") {
        message(paste0(temp, collapse=""))
      }
      if (action=="get") return(temp)
      invisible(temp)      
    }
    
    ## for deleting logged messages
    if (action == "reset") {
      history.i <<- 1;
      history <<- vector("list", 16)
    }
  }  
}


##' Message logging function
##'
##' This is an interface to a simple message logging system. The
##' basic usage is to call msg("text") to output some text onto the
##' console with cat. This function records all the messages logged, so
##' that it is possible to retrive them using msg(NULL, action="show")
##'
##' @param x character, messages to log
##' @param ... character, this allows the user to write a
##' message that is split into multiple parts, e.g. msg("hello", "there")
##' @param action character, determines what the processing
##' performed on the input. Defaults to 'log', which logs a new message.
##' Other options are show and get, which retrieve all the stored message.
##' Action 'reset' deletes all messages and clears up memory.
##' 
##' @export
msg = newmsg()

