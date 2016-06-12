# `shrt`: Project management

This vignette demonstrate function in the `projects` range.




&nbsp;
## initp

`initp` creates a new directory and some subdirectories. 


```r
wp = initp("MyProjects")
```

```
## [2016-06-12 10:27:09]	Creating:  MyProjects 
## [2016-06-12 10:27:09]	Creating:  MyProjects/notes 
## [2016-06-12 10:27:09]	Creating:  MyProjects/figures 
## [2016-06-12 10:27:09]	Creating:  MyProjects/tables 
## [2016-06-12 10:27:09]	Creating:  MyProjects/Rda 
## [2016-06-12 10:27:09]	Creating:  MyProjects/data 
## [2016-06-12 10:27:09]	Creating:  MyProjects/code
```

The returned object is a simple list with all the directories.

Note that the messages displayed by `initp` are output via function `msg`. This means they are logged and can be retrieved


```r
msg(action="show")
```

```
## [2016-06-12 10:27:09]	Creating:  MyProjects 
## [2016-06-12 10:27:09]	Creating:  MyProjects/notes 
## [2016-06-12 10:27:09]	Creating:  MyProjects/figures 
## [2016-06-12 10:27:09]	Creating:  MyProjects/tables 
## [2016-06-12 10:27:09]	Creating:  MyProjects/Rda 
## [2016-06-12 10:27:09]	Creating:  MyProjects/data 
## [2016-06-12 10:27:09]	Creating:  MyProjects/code
```

See documentation for `msg` for further details. 







