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
a function `wtch()` that achieves these common settings by default and thus shortens code substantially. 

Many of the function in this package are similar to `wtch()` in that they 
are relatively simple wrappers for existing R functions. Some of the functions, including `wtch`, also include features that would otherwise have to be written using two or more commands (see documentation)

*Disclaimer:* Useful shorthand notation is subjective. Thus you might not 
agree with all acronyms or design choices in these functions. So please 
feel free to use/adapt just bits and pieces from the package.


## Contents

The following is a quick synopsis of the functions available in the package. Column `Group` provides a category for each function and helps to identify where to find the code and documentation. Column `Function` shows the function names. 

| Group | Function | Description |
| -- | -- | -- |
| messages | msg | log and output a message |
| messages | newmsg | create message logger |
| files | rtht | read tables from files |
| files | wtht | write tables to files |
| utils | grepv | pattern matching |
| utils | mtrx | creating matrices |
| utils | newv | creating empty, named vectors |
| utils | p0 | paste0 |



## Documentation

The goal is to provide some documentation on each function (or each family of functions) through markdown [vignettes](https://github.com/tkonopka/shrt/tree/master/inst/doc).


## License

The package is under a MIT license. Comments and contributions are welcome. 

