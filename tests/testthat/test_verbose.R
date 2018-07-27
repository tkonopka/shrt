## Tests for verbose.R

cat("\ntest_verbose.R\n")




test_that("detect verbosity from parent environment", {
  verbose = 14
  result = detect.verbose()
  expect_equal(result, 14)
})


test_that("detect verbosity from options", {
  options(verbose=TRUE)
  verbose= 4
  rm(verbose)
  result = detect.verbose()
  expect_equal(result, TRUE)
  options(verbose=FALSE)
})


test_that("detect verbose set locally within a function", {
  verbose = 2
  a1 = function() {
    verbose = 4;
    a2 = function() {
      detect.verbose()
    }
    a2()
  }
  result = a1()
  expect_equal(result, 4)
})

