# `shrt`: Project management

This vignette demonstrate function in the `projects` range.




&nbsp;
## initp

`initp` creates a new directory and some subdirectories. 


```r
wp = initp("MyProjects")
```

```
## [2016-06-12 10:06:46]	nproj is creating:  MyProjects 
## [2016-06-12 10:06:46]	nproj is creating:  MyProjects/notes 
## [2016-06-12 10:06:46]	nproj is creating:  MyProjects/figures 
## [2016-06-12 10:06:46]	nproj is creating:  MyProjects/tables 
## [2016-06-12 10:06:46]	nproj is creating:  MyProjects/Rda 
## [2016-06-12 10:06:46]	nproj is creating:  MyProjects/data 
## [2016-06-12 10:06:46]	nproj is creating:  MyProjects/code
```

The returned object is a simple list with all the directories







