## Tests for cache.R

## objects used during test save/load
testvec = 1:10
testobj = list(a=10, b=letters[1:4])
abcfun = function() {
  letters
}
addTen = function(x) {
  x+10
}




## remember original working directory
workdir = getwd()
datadir = file.path(dirname(workdir), "testdata")

## prep the tests by deleting all contents of the test directory
file.remove(list.files(datadir, pattern="Rda", full.names=T))




test_that("set cache directory", {
  cache(datadir)
  expected = datadir
  output = cache()
  expect_equal(output, expected)
})


test_that("file exists after save, not after remove", {
  cache(datadir)
  myvec = testvec
  savec(myvec)
  vecfile = file.path(datadir, "myvec.Rda")
  expect_equal(vecfile, cachefile("myvec"))
  expect_true(existsc("myvec"))
  rmc(myvec)
  expect_false(existsc("myvec"))
})


test_that("remove warning when removing a file that is not there", {
  cache(datadir)
  myvec = testvec
  savec(myvec)
  rmc(myvec)
  ## myvec.Rda does not exist, removing it should give warnings
  expect_warning(rmc(myvec))
})


test_that("load cache object (without assign)", {
  cache(datadir)
  myvec = testvec
  savec(myvec)
  rm(myvec)
  ## now only exists in cache
  newvec = loadc("myvec")
  expect_true(identical(testvec, newvec))
  ## remove cache file, gives warning because myvec not loaded
  expect_warning(rmc(myvec))
})


test_that("assign from simple cache object", {
  cache(datadir)
  myvec = testvec
  savec(myvec)
  rm(myvec)
  ## now only exists in cache
  assignc("myvec")
  expect_true("myvec" %in% ls())
  expect_true(identical(testvec, myvec))
  rmc(myvec)
})


test_that("assign from larger cache object", {
  cache(datadir)
  myobj = testobj
  savec(myobj)
  rm(myobj)
  assignc("myobj")
  expect_true("myobj" %in% ls())
  expect_true(identical(testobj, myobj))
  rmc(myobj)
})


test_that("load error when object does not exist", {
  cache(datadir)
  myobj = testobj
  savec(myobj)
  rmc(myobj)
  ## now myobj does not exist
  expect_error(loadc("myobj"))
})


test_that("assign from cache with/without overwrite", {
  cache(datadir)
  myvec = testvec
  savec(myvec)
  rm(myvec)

  ## assign without overwrite
  myvec = c(testvec, testvec)
  expect_false(identical(myvec, testvec))
  acode = assignc("myvec")
  expect_equal(acode, 2)
  expect_false(identical(myvec, testvec))
  
  ## assign with overwrite
  acode = assignc("myvec", overwrite=TRUE)
  expect_equal(acode, 1)
  expect_true(identical(myvec, testvec))
  
  ## cleanup
  rmc(myvec)
})


test_that("assign with warning", {
  expect_warning(assignc("notthere", warn=TRUE))
})


test_that("makec a simple object", {
  cache(datadir)

  ## create an object
  mcode = makec("abc", abcfun)
  
  ## check object was generated with function and has the alphabet
  expect_equal(mcode, 3)
  expect_true("abc" %in% ls())
  expect_true(existsc("abc"))
  expect_identical(abc, letters)
  rmc(abc)
})


test_that("makec when object exists in environment", {
  cache(datadir)
  
  ## create an object
  myvec=testvec
  mcode = makec("myvec", abcfun)
  
  ## check makec aborted because myvec already exists
  expect_equal(mcode, 2)
  expect_true("myvec" %in% ls())
  expect_false(existsc("myvec"))
  expect_identical(myvec, testvec)
  rmc(myvec)
})


test_that("makec when object exists in cache", {
  cache(datadir)
  
  ## create an object
  myvec=testvec
  savec(myvec)
  rm(myvec)
  mcode = makec("myvec", abcfun)

  ## check makec aborted because myvec already exists
  expect_equal(mcode, 1)
  expect_true("myvec" %in% ls())
  expect_true(existsc("myvec"))
  expect_identical(myvec, testvec)
  rmc(myvec)
})


