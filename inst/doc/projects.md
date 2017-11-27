# `shrt`: Project management

This vignette demonstrates function in the `projects` range.






&nbsp;
## initp

`initp` creates a new directory and some subdirectories. 


```r
wp = initp("MyProjects")
```

```
## [2017-11-27 08:14:28]	Creating:  MyProjects
## [2017-11-27 08:14:28]	Creating:  MyProjects/notes
## [2017-11-27 08:14:28]	Creating:  MyProjects/figures
## [2017-11-27 08:14:28]	Creating:  MyProjects/tables
## [2017-11-27 08:14:28]	Creating:  MyProjects/Rda
## [2017-11-27 08:14:28]	Creating:  MyProjects/data
## [2017-11-27 08:14:28]	Creating:  MyProjects/code
```

The returned object is a simple list with all the directories.

Note that the messages displayed by `initp` are output via function `msg`. This means they are logged and can be retrieved


```r
msg(action="show")
```

```
## [2017-11-27 08:14:28]	Creating:  MyProjects
## [2017-11-27 08:14:28]	Creating:  MyProjects/notes
## [2017-11-27 08:14:28]	Creating:  MyProjects/figures
## [2017-11-27 08:14:28]	Creating:  MyProjects/tables
## [2017-11-27 08:14:28]	Creating:  MyProjects/Rda
## [2017-11-27 08:14:28]	Creating:  MyProjects/data
## [2017-11-27 08:14:28]	Creating:  MyProjects/code
```

See documentation for `msg` for further details. 






&nbsp;
## reqvars

`reqvars` checks that a set of variable names are defined.


```r
a1 = 3
a4 = 0
reqvars(c("a1", "a2", "a3", "a4"))
```

```
## Missing variable:  a2 
## Missing variable:  a3
```

```
## Error: Missing variables
```

The call prints out messages about variable names that are expected, but not defined. When there are missing variables in the environment, the default action is to call `stop()`. (Argument `halt` can be set to `FALSE` to prevent this behavior.)


