## Tests for R/plot.R

cat("\ntest_plot.R\n")



## Tests for limq

test_that("limq determines limits from a single vector", {
  data = seq(0, 100)
  expect_equal(limq(data), c(1, 99))
})


test_that("limq omits NAs", {
  data = seq(0, 100)
  data[c(20, 30)] = NA
  expect_lt(limq(data)[1], 10)
  expect_gt(limq(data)[2], 90)
})


test_that("limq determines limits from a single vector with custom quantiles", {
  data = seq(0, 100)
  expect_equal(limq(data, quantiles=c(0.05, 0.98)), c(5, 98))
})


test_that("limq respects preset limits", {
  data = seq(0, 100)
  result = limq(data, lim=c(0, NA), quantiles=c(0.05, 0.95))
  expect_equal(result, c(0, 95))
})


test_that("limq extracts data from matrix columns", {
  data = matrix(seq(0, 100), ncol=4, nrow=101)
  data[,1] = data[,1] + 1000
  colnames(data) = letters[1:4]
  result = limq(data, column=c("b", "c"))
  expect_equal(result, c(1, 99))
})


test_that("limq extracts from nested data frames", {
  data.matrix = matrix(seq(0, 100), ncol=4, nrow=101)
  colnames(data.matrix) = letters[1:4]
  data = list(A=data.matrix, B=data.matrix)
  data$A[,1] = 1000
  data$B[,1] = 2000
  resultBC = limq(data, column=c("b", "c"))
  expect_equal(resultBC, c(1, 99))
  resultB = limq(data, column=2, lim=c(0, NA))
  expect_equal(resultB, c(0, 99))
  resultA = limq(data, column=1, lim=c(0, NA))
  expect_equal(resultA, c(0, 2000))
})


test_that("limq can prettify ouput", {
  data = seq(0, 100, by=12)
  result = limq(data, quantiles=c(0.05, 0.95), pretty=c(10, 10))
  expect_equal(result, c(0, 100))
})


test_that("limq can prettify ouput", {
  data = -seq(0, 100, by=12)
  result = limq(data, quantiles=c(0.05, 0.95), pretty=c(10, 10))
  expect_equal(result, c(-100, 0))
})




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

