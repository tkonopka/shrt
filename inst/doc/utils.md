# `shrt`: General-purpose functions

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
## lenu

`lenu` is equivalent to `unique` followed by `length`. It returns the
number of unique elements in a vector.


```r
foo = c("f", "o", "o")
lenu(foo)
```

```
## [1] 2
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
## namesF, namesNA, namesT, namesV

The four functions `namesF`, `namesNA`, `namesT`, and `namesV` are variations on a theme. They act on a vector and provide the names of elements that match particular values. 

Consider a named vector with boolean values


```r
foo.boolean = setNames((1:10)%%2==0, letters[1:10])
foo.boolean
```

```
##     a     b     c     d     e     f     g     h     i     j 
## FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE
```

If we want to know which of letters is associated with a true value, we can match the pattern and fetch the names.


```r
names(foo.boolean)[foo.boolean==TRUE]
```

```
## [1] "b" "d" "f" "h" "j"
```

With the `namesT` function, we can instead write


```r
namesT(foo.boolean)
```

```
## [1] "b" "d" "f" "h" "j"
```

Note how we avoid writing the vector twice! The function `namesF` behaves similarly but returns the names of elements that are marked as false. 

Consider now that the vector contains numbers or strings.


```r
foo.integer = setNames(c(2,4,NA,0,-1,3,NA,7,3,NA), LETTERS[1:10])
foo.integer
```

```
##  A  B  C  D  E  F  G  H  I  J 
##  2  4 NA  0 -1  3 NA  7  3 NA
```

Suppose we want to know the names that match a certain value, say 3. Finding these is not hard, but it is important to handle NAs carefully. 


```r
names(foo.integer)[foo.integer==3]
```

```
## [1] NA  "F" NA  "I" NA
```

```r
names(foo.integer)[foo.integer %in% 3]
```

```
## [1] "F" "I"
```

The function `namesV` provides the latter implementation with a simple syntax.


```r
namesV(foo.integer, 3)
```

```
## [1] "F" "I"
```

Finally, `namesNA` provides element names that hold NAs.


```r
names(foo.integer)[is.na(foo.integer)]
```

```
## [1] "C" "G" "J"
```

```r
namesNA(foo.integer)
```

```
## [1] "C" "G" "J"
```




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
paste0(greek[1], greek[2])
```

```
## [1] "alphabeta"
```

```r
p0(greek[1], greek[2])
```

```
## [1] "alphabeta"
```




&nbsp;
## x2df

`x2df` is a conversion function that coerces an input object into a data frame. It is shorthand notations for calls to `data.frame`. For example, let's start with a matrix of characters.


```r
charmat = mtrx(letters[1:9], col.names=c("x", "y", "z"), nrow=3)
charmat
```

```
##      x   y   z  
## [1,] "a" "d" "g"
## [2,] "b" "e" "h"
## [3,] "c" "f" "i"
```

The conversion produces a related object


```r
chardf = x2df(charmat)
chardf
```

```
##   x y z
## 1 a d g
## 2 b e h
## 3 c f i
```

The difference from the input is the class.


```r
class(chardf)
```

```
## [1] "data.frame"
```

```r
apply(chardf, 2, class)
```

```
##           x           y           z 
## "character" "character" "character"
```

The default behavior is to convert characters into characters, but it is also possible to set `stringsAsFactors` to true during the function call.

In addition to such simple conversion, the function can also convert vectors into a data frame.


```r
myvec = setNames(1:4, letters[1:4])
x2df(myvec)
```

```
##   a b c d
## 1 1 2 3 4
```
