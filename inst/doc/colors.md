# `shrt`: manipulations related to colors

This vignette demonstrates functions in the `colors` range.




It will be handy to have a vector and a matrix with numbers


```r
x = c(-0.2, 0, 0.04, 0.5, 1, NA, 1.2)
names(x) = letters[1:length(x)]
x
```

```
##     a     b     c     d     e     f     g 
## -0.20  0.00  0.04  0.50  1.00    NA  1.20
```

```r
y = mtrx(seq(-4, 4, length=9), row.names=letters[1:3], col.names=LETTERS[1:3])
y[1,3] = NA
y[2,3] = Inf
y
```

```
##    A  B   C
## a -4 -1  NA
## b -3  0 Inf
## c -2  1   4
```


&nbsp;	
## x2hex	

`x2hex` converts numbers in a [0,1] range into hexadecimal strings that can be used as transparency values


```r
x
```

```
##     a     b     c     d     e     f     g 
## -0.20  0.00  0.04  0.50  1.00    NA  1.20
```

```r
x2hex(x)
```

```
##    a    b    c    d    e    f    g 
## "00" "00" "0a" "80" "ff"   NA "ff"
```

The function provides useful behavior in special cases:

 - negative numbers are converted into a two-digit `00`
 - small numbers are always output in two-digit notation with a leading zero
 - `NA` and other non-numbers are preserved as in the original input
 - names associated to the original data are preserved in the output



&nbsp;	
## x2col	

`x2col` converts numbers into colors on a two-color scale. Intermediate colors are created using transparency codes.


```r
x
```

```
##     a     b     c     d     e     f     g 
## -0.20  0.00  0.04  0.50  1.00    NA  1.20
```

```r
x2col(x)
```

```
##           a           b           c           d           e           f 
## "#0000ff33"   "#ffffff" "#ff00000a" "#ff000080" "#ff0000ff"          NA 
##           g 
## "#ff0000ff"
```

The function provides the following behavior:

 - negative numbers are placed on one color scale (e.g. shades of blue)
 - positive numbers are placed on another scale (e.g. shades of red)
 - the two-color scheme can be changed via argument `col`
 - the numeric values that saturate the color scales can be set by `maxval`
 - `NA` and other non-numbers are preserved 
 - names associated with the input data are preserved
 - values of exactly zero are output as white color. This background color can be changed using argument `bgcol`. This behavior can also be turned off by setting `bgcol` to `NULL`. 

The function also works on matrices


```r
y
```

```
##    A  B   C
## a -4 -1  NA
## b -3  0 Inf
## c -2  1   4
```

```r
x2col(y, maxval=3)
```

```
##   A           B           C          
## a "#0000ffff" "#0000ff55" NA         
## b "#0000ffff" "#ffffff"   "#ff0000ff"
## c "#0000ffaa" "#ff000055" "#ff0000ff"
```

