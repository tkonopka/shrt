## Collection of functions with short names - data manipulation
##
##




##' compute Jaccard Index of two sets
##'
##' The Jaccard Index of two sets is defined as the ratio of the
##' size of the set intersection (common element) and the
##' size of the set union (all elements).
##'
##' The name is short for: (j)accard (i)ndex
##'
##' @param a vector of set elements
##' @param b vector of set elements
##'
##' @examples
##' ji(c(1,2,3), c(1,4,5)) # one common element out of five, JI=0.2 
##'
##' @export
ji = function(a, b) {
  length(intersect(a,b)) / length(union(a, b))
}




##' compute Overlap Index of two sets
##'
##' The Overlap Index of two sets is defined as the ratio of the
##' size of the set intersection (common elements) and the size
##' of the primary set.
##'
##' @param a vector of set elements
##' @param b vector of set elements
##'
##' @examples
##' oi(c(1,2), c(2,3,4,5)) # one element out of two in "a" is present in "b"
##'
##' @export
oi = function(a, b) {
  length(intersect(a, b)) / length(unique(a))
}




##' Characterize memberships in two sets
##'
##' @param a vector (character, numeric, etc.) with members of set a
##' @param b vector with members of set b
##' @param unique.force logical, set TRUE to enforce that a, b have
##' non-repeating elements (i.e. they are sets), set FALSE to use
##' a,b as-is, i.e. potentially with non-unique elements.
##'
##'
##' @return list holding three vectors and a summary. Vectors contain
##' the set elements that are private and common in a, b, and a vector
##' with membership counts. Warning, membership counts might not be
##' reliable if a, b have duplicate entries
##'
##' @export
setsummary = function(a, b, unique.force=TRUE) {

    # perhaps enforce a, b to be sets
    if (unique.force) {
        a = unique(a)
        b = unique(b)
    }
    
    ## compute intersection, a/b unique set members
    ab = intersect(a, b)

    a.only = a[!a %in% ab]
    b.only = b[!b %in% ab]
    summary = c("a.private" = length(a.only),
                "b.private" = length(b.only),
                "common" = length(ab))
    
    list(a.private = a.only, b.private = b.only,
         common = ab, summary=summary)
}




