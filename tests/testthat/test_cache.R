## Tests for cache.R

## objects used during test save/load
testvec = 1:10
testobj = list(a=10, b=letters[1:4])



## remember original working directory
workdir = getwd()
datadir = file.path(dirname(workdir), "testdata")



test_that("set cache directory", {
  cache(datadir)
  expected = datadir
  output = cache()
  expect_equal(output, expected)
})


test_that("file exists after save", {
  cache(datadir)
  myvec = testvec
  savec(myvec)
  cachefile = file.path(datadir, "myvec.Rda")
  expect_true(file.exists(cachefile))
  rmc(myvec)
})


test_that("remove files from cache", {
  cache(datadir)
  myvec = testvec
  savec(myvec)
  rmc(myvec)
  cachefile = file.path(datadir, "myvec.Rda") 
  expect_false(file.exists(cachefile))
})


test_that("remove warning when removing a file that is not there", {
  cache(datadir)
  myvec = testvec
  savec(myvec)
  rmc(myvec)
  ## myvec.Rda does not exist, removing it should give warnings
  expect_warning(rmc(myvec))
})


test_that("retrieve simple cache object", {
  cache(datadir)
  myvec = testvec
  savec(myvec)
  rm(myvec)
  ## now only exists in cache
  loadc("myvec")
  expect_true("myvec" %in% ls())
  expect_true(identical(testvec, myvec))
  rmc(myvec)
})


test_that("retrieve larger cache object", {
  cache(datadir)
  myobj = testobj
  savec(myobj)
  rm(myobj)
  loadc("myobj")
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


test_that("retrieve cache object without assign", {
  cache(datadir)
  myvec = testvec
  savec(myvec)
  rm(myvec)
  ## now only exists in cache
  newvec = loadc("myvec", FALSE)
  expect_false("myvec" %in% ls())
  expect_true("newvec" %in% ls())
  expect_true(identical(testvec, newvec))
  ## to finish here, remove saved object, this should create a warning
  ## because myvec does not exist in the environmnt at this stage
  expect_warning(rmc(myvec))
})

