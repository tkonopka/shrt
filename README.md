# shrt
Functions for shorter R code

![Status](https://travis-ci.org/tkonopka/shrt.svg?branch=master)
[![codecov](https://codecov.io/gh/tkonopka/shrt/branch/master/graph/badge.svg)](https://codecov.io/gh/tkonopka/shrt)


## Introduction

Some commands or sequences of commands occur so often that one can wish for
shorthand notation. This package is a collection of such shorthand functions
that streamline such common sequences, in some cases trading some expressivity
in function names for typing convenience.

For example, writing tab-separated tables with headers requires calling `write.table()` 
with options `quote=F, col.names=T, row.names=F, sep='\t'`. This package 
implements a function `wtht()` that achieves these common settings by default 
and thus shortens code substantially. 

Many of the function in this package are similar to `wtht()` in that they 
are relatively simple wrappers for existing R functions. Some of the functions, 
including `wtht`, also include features that would otherwise have to be written 
using two or more commands (see documentation).

*Disclaimer:* Useful shorthand notation is subjective. Thus you might not 
agree with all acronyms or design choices in these functions. So please 
feel free to use/adapt just bits and pieces from the package.


## Contents

The following is a quick synopsis of the functions available in the package. 
Column `Group` provides a category for each function and helps to identify where 
to find the code and documentation. Column `Function` shows the function names. 

 Group | Function | Description 
 --- | --- | ---
 cache | assignc | assign to variable using value from cache
 cache | cachedir | set a directory to act as a disk cache
 cache | cachefile | get path to a file in cache
 cache | existsc | check if cache contains representation for a variable
 cache | loadc | load object from cache
 cache | rmc | remove an object from environment and from cache
 cache | savec | save an oject into disk cache
 colors | x2hex | map values into a hex transparency code
 colors | x2col | map vectors or matrices onto a 2-color scale
 data | setsummary | summary of set membership
 loops | apwi | apply with iterator index
 messages | msg | log and output a message 
 messages | newmsg | create message logger 
 files | load1 | load from Rdata file into one named object
 files | loaddir | load content from a directory
 files | rtht | read tables from files 
 files | wtht | write tables to files 
 projects | initp | initiate directories/folders for a project
 projects | reqvars | check whether variables are defined
 utils | catv | print to console, but only in verbose mode
 utils | grepv | pattern matching 
 utils | h1, h2, h3 | head with preset n
 utils | mtrx | creating matrices 
 utils | namesF | get elements with value FALSE
 utils | namesNA | get elements with value NA
 utils | namesT | get elements with value TRUE
 utils | namesV | get elements with given value(s)
 utils | newv | creating empty, named vectors 
 utils | lenu | number of unique elements
 utils | p0 | paste0
 utils | pluck | extract a component from an object or list
 utils | pluck1 | extract first components from a list of objects
 utils | pluck2 | extract second components from a lit of objects
 utils | today | create a string with current date
 utils | x2df | transform objects into data frames



## Documentation

Documentation on each function (or each family of functions) is available through 
markdown [vignettes](https://github.com/tkonopka/shrt/tree/master/inst/doc).


## License

The package is under a MIT license. Comments and contributions are welcome. 

