## Tests for R/plot.R

cat("\ntest_plot.R ")


## Tests for widen

test_that("widen gives error on wrong inputs", {
  expect_error(widen(1))
  expect_error(widen(c(1, 2, 3)))
})


test_that("widen create new symmetric intervals", {
  aa = c(0, 1)
  out1 = widen(aa, by=c(0.05, 0.05))
  out2 = widen(aa, by=0.05)
  expected = c(-0.05, 1.05)
  expect_equal(out1, expected)
  expect_equal(out2, expected)
})


test_that("widen creates new intervals on log scale (intended base 2)", {
  aa = c(1, 1024)
  out = widen(aa, by=0.05, log=TRUE)
  expected = 2^c(-0.5, 10.5)
  expect_equal(out, expected)
})


test_that("widen creates new intervals on log scale (intended base 10)", {
  aa = c(1, 100)
  out = widen(aa, by=0.05, log=TRUE)
  expected = 10^c(-0.1, 2.1)
  expect_equal(out, expected)
})

