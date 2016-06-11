# `shrt`: Logging and messaging functions

This vignette demonstrate functions in the `messages` range. 




&nbsp;
## msg

`msg` displays messages on the console and records them for later use. In contrast to many other function in the `shrt` package, this function provides interesting functionality that is not directly provided by base R functions. 

A common way to output a message onto the console is with `cat`


```r
cat("hello")
```

```
## hello
```

The `msg` function performs a similar role, except that it also outputs a date and time


```r
msg("hello")
```

```
## [2016-06-11 17:54:49]	hello
```

```r
msg("hello again")
```

```
## [2016-06-11 17:54:49]	hello again
```

An interesting feature is that `msg` internally records all the messages so that they can be retrieved at a later date. 


```r
msg(action="show")
```

```
## [2016-06-11 17:54:49]	hello 
## [2016-06-11 17:54:49]	hello again
```

It is also possible to retrieve the messages without displaying them


```r
mm = msg(action="get")
mm
```

```
## [1] "[2016-06-11 17:54:49]\thello \n"      
## [2] "[2016-06-11 17:54:49]\thello again \n"
```

The is handy if the messages require further processing, for example saving into a log file. 

When the log is no longer needed, it can be reset 


```r
msg(action="reset")
msg(action="show")
```


&nbsp;
## newmsg

`newmsg` is factory function that creates a new message log. For example, we can create a silent log that does not include the call date. 


```r
silent.msg = newmsg(verbose=FALSE, date=FALSE)
class(silent.msg)
```

```
## [1] "function"
```

The new object is a function that works analogously to `msg` above. 


```r
silent.msg("hi 123")
silent.msg("hi 456")
```

The messages can again be displayed as above. 


```r
silent.msg(action="show")
```

```
## hi 123 
## hi 456
```





