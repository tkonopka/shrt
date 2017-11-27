# `shrt`: data-related functions

This vignette demonstrates functions in the `data` range.






&nbsp;
## setsummary

`setsummary` computes an overview of set membership. It takes two vectors that represent sets of objects. It outputs a list with summary statistics: the set of private members in each of the two inputs, the set of common objects, and a vector with the element counts. 


```r
setA = c("alpha", "beta")
setB = c("beta", "gamma", "delta")
setsummary(setA, setB)
```

```
## $a.private
## [1] "alpha"
## 
## $b.private
## [1] "gamma" "delta"
## 
## $common
## [1] "beta"
## 
## $summary
## a.private b.private    common 
##         1         2         1
```


