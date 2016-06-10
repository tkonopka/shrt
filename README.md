# shrt
Functions for shorter R code


## Introduction

It is important for code to be legible - this helps in understanding
and maintaining previous work. However, some commands or sequences of 
commands sometimes occur so often that one can wish for shorthand notation. 
This package is a collection of such shorthand functions that trade some
expressivity in function names for typing convenience.

For example, I personally write tables to files using options set 
`quote=F, col.names=T, row.names=F, sep='\t'`. This package thus implements
a function `wtch()` that achieves my common settings and simplifies 
my code substantially. 

Many of the function in this package are similar to `wtch()` in that they 
are relatively simple wrappers for existing R functions. Some other
functions like `newv()` provide functionality that would otherwise
have to be written using two or more commands.

*Disclaimer:* Useful shorthand notation is subjective. Thus you might not 
agree with all acronyms or design choices in these functions. So please 
feel free to use/adapt just bits and pieces from the package.


## Documentation

The goal is to provide some documentation on each function (or each family of functions) through markdown vignettes (to do).

## License

The package is under a MIT license. Comments and contributions are welcome. 

