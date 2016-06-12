# `shrt`: General purpose functions

This vignette demonstrates functions in the `utils` range.




&nbsp;
## grepv

`grepv` is a pattern matching function, a wrapper for `grep` that returns the actual matching values. For example, let's start with a vector of strings


```r
greek = c("alpha", "beta", "gamma", "delta")
```

If we need all items that contain the pattern `a[lm]`, we can use grep. 


```r
grep("a[lm]", greek, value=T)
```

```
## [1] "alpha" "gamma"
```

The `grepv` function syntax is


```r
grepv("a[lm]", greek) 
```

```
## [1] "alpha" "gamma"
```



&nbsp;
## mtrx

`mtrx` creates a matrix from input data. Compared to the usual `matrix`, it provides some new possibilities in naming rows and columns.

There are two ways to create a matrix with two rows and four named columns. The first is multi-step


```r
mm = matrix(0, nrow=2, ncol=4)
colnames(mm) = greek
mm
```

```
##      alpha beta gamma delta
## [1,]     0    0     0     0
## [2,]     0    0     0     0
```

A second way achieves the same in a single line


```r
matrix(0, nrow=2, ncol=4, dimnames=list(rep(NULL, 2), greek))
```

```
##      alpha beta gamma delta
## [1,]     0    0     0     0
## [2,]     0    0     0     0
```

However, this last expression is not very elegant. It requires a null component in the `dimnames` list and the lengths of the row and column names must match the integers specified by `nrow` and `ncol`.

The new `mtrx` function achieves in a slightly more compact form


```r
mtrx(0, nrow=2, col.names=greek)
```

```
##      alpha beta gamma delta
## [1,]     0    0     0     0
## [2,]     0    0     0     0
```

Note how the number of columns is automatically determined by the specified names (this is not possible using `matrix`). Besides this usage, `mtrx` also accepts names for rows.





&nbsp;
## newv

`newv` creates a new vector of specified length, possibly containing names. 

For some data types like integers or characters, we can create a small vector with `rep` and then name the elements with `names`. For example


```r
v = rep(0, 4)
names(v) = greek
v
```

```
## alpha  beta gamma delta 
##     0     0     0     0
```

The new function can create the same object in a single line. 


```r
newv("integer", names=greek)
```

```
## alpha  beta gamma delta 
##     0     0     0     0
```

The new function is also handy for creating lists. The traditional way to create a list of a known size is


```r
mylist = vector("list", length=4)
setNames(mylist, greek)
```

```
## $alpha
## NULL
## 
## $beta
## NULL
## 
## $gamma
## NULL
## 
## $delta
## NULL
```

The new function reproduces this in a single line.


```r
newv("list", names=greek)
```

```
## $alpha
## NULL
## 
## $beta
## NULL
## 
## $gamma
## NULL
## 
## $delta
## NULL
```

Note that the length of the output object is determined by the names. 






&nbsp;
## p0

`p0` is equivalent to `paste0`. It concatenates its input without adding any spaces or other characters.


```r
paste0(greek)
```

```
## [1] "alpha" "beta"  "gamma" "delta"
```

```r
p0(greek)
```

```
## [1] "alpha" "beta"  "gamma" "delta"
```
