#`shrt`: managing cache objects and files

The `cache` collection of functions streamlines use of save() and load() to manage objects during scripting. 

Unlike other vignettes in the package that demonstrate functions in a category in order, this vignette demonstrates some use cases.






&nbsp;
## Setting up a disk cache

A disk cache is a location on disk that holds computed objects so that they can be retrieved without requiring recomputing from scratch. The default location of the cache is the working directory and can be retrieved busing the function`cachedir()` without arguments,


```r
cachedir()
```

```
## [1] "/science/code/R-packages/shrt/vignettes/cachedata"
```

Adding an argument sets up a new directory


```r
cachedir("cachedata")
cachedir()
```

```
## [1] "/science/code/R-packages/shrt/vignettes/cachedata"
```

It is also possible to include a prefix to each file of the cache directory.


```r
cacheprefix("testing")
cacheprefix()
```

```
## [1] "testing"
```

To stop using the prefix, set it to the empty string.


```r
cacheprefix("")
cacheprefix()
```

```
## [1] ""
```




&nbsp;
## Writing to and loading from a cache

Consider a simple test object `abc`,


```r
abc = letters[1:3]
abc
```

```
## [1] "a" "b" "c"
```

Saving and loading this object from disk can be performed using `save`, `load`, and old files can be removed by `file.remove`.


```r
abc.file = file.path("cachedata", "abc.Rda")
save(abc, file=abc.file)
```

At this point, the object exists on disk. It is possible to remove it from the working environment, and reload it from disk,


```r
rm(abc)
load(abc.file)
abc
```

```
## [1] "a" "b" "c"
```

With the `shrt` cache-management, saving and re-loading can be simpliefied via functions `savec` and `loadc`, 


```r
savec(abc)
rm(abc)
abc = loadc("abc")
abc
```

```
## [1] "a" "b" "c"
```

The file path need not be constructed or specified, but it can be retrieved if necessary using `cachefile`,


```r
cachefile("abc")
```

```
## [1] "/science/code/R-packages/shrt/vignettes/cachedata/abc.Rda"
```

In the above example, using `loadc` requires assigning the value of the object into a variable. This may be useful to explicitly use a different object name. The package also provides an alternative function `assignc` that loads from cache and performs the assignment in one go.


```r
rm(abc)
assignc("abc")
abc
```

```
## [1] "a" "b" "c"
```

When the object is no longer needed, it can be removed from the environment using `rm` or from botth the environment and cache using `rmc`.


```r
before = file.exists(cachefile("abc"))
rmc(abc)
after = file.exists(cachefile("abc"))
c(before, after)
```

```
## [1]  TRUE FALSE
```

Again, the interface to `rmc` requires specifying the object, but not the file path in cache.




&nbsp;
## Pipelines with cache

Cached objects can be useful to speed-up a long-running script or pipeline. Functions `assignc` and `makec` provide tools for this purpose. For this use case, consider generating an object using a function.


```r
myfun = function(x, rev=TRUE) {
  result = 1:x
  if (rev) {
    result = rev(result)
  }
  result
}
fwd5 = myfun(5)
fwd5
```

```
## [1] 5 4 3 2 1
```

Within a pipeline, there might be a module to compute `fwd5` that loads it from disk when available, or compute it and save it otherwise.


```r
## base R
fwd5.file = file.path("cachedata", "fwd5.Rda")
if (!file.exists(fwd5.file)) {
  fwd5 = myfun(5)
  save(fwd5, file=fwd5.file)
} else {
  fwd5 = load1(fwd5.file)
}
fwd5
```

```
## [1] 5 4 3 2 1
```

The snippet always ends with a representation of `fwd5`. This is explicit in the two statements begining with `fwd5 =` along the two branches of the `if`-`else` block.

An alternative implementation exploits the capability of `assignc` to report whether or not a cache representation exists in a manner that is consistent with an `if` statement.


```r
## shrt v.1
if (!assignc("fwd5")) {
  fwd5 = myfun(5)
  savec(fwd5)
}
fwd5
```

```
## [1] 5 4 3 2 1
```

Here, when the object exists in cache, `fwd` obtains a value through a side-effect of `assignc`. When the cached file does not exist, the object is computed and saved within the `if` block.

Although this is simpler than the original version, it still requires a manual call to `savec` to record the object in cache. It is possible to avoid that using `makec`. This function requires the name of the target object and a generator function; it performs all the cache maintenance automatically.


```r
## shrt v.2
makec("fwd5", myfun, 5)
fwd5
```

```
## [1] 5 4 3 2 1
```

The generator can take more than one argument. For example, to generate the reverse sequence taking advantage of `myfun`'s optional second argument,


```r
makec("rev5", myfun, 5, rev=TRUE)
rev5
```

```
## [1] 5 4 3 2 1
```



&nbsp;
## Logging

By default, function `assignc` does not produce any log messages. Thus, the following snippet is silent.


```r
abc = 5
assignc("abc")
```

It is possible to activate messages by setting a verbosity level greater than 1.


```r
verbose = 2
assignc("abc")
```

```
## [2018-07-27 04:47:37]	!! 'abc' already exists
```

Turning off logging is achieved by resetting verbosity.


```r
verbose = FALSE
assignc("abc")
```



&nbsp;
## Notes

It is worth stressing that `assignc` and `makec` perform different actions depending on the state of the current environment. The default order of preference is as follows:

 - do not modify the environment if object already exists
 - load an object from cache file
 - compute object using a constructor function (`makec`), or abort (`assignc`)







