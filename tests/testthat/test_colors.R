## Tests for colors.R



## Tests for hex numbers

test_that("convert single values into hex (upper and lower case)", {
  ## lowercase by default
  expect_equal(x2hex(1), "ff")
  ## upper case with optional argument
  expect_equal(x2hex(1, type="X"), "FF")
  ## out-of range and strange values
  expect_equal(x2hex(NA), NA)
  expect_equal(x2hex(Inf), "ff")  
})

test_that("convert vectors of values into hex (empty input)", {
  ## should give empty result
  expect_equal(length(x2hex(c())), 0)
})

test_that("convert vectors of values into hex", {
  input = c(-0.2, 0, 0.00001, 0.5, 1, 1.2, 0.999999999)
  output = x2hex(input)
  expected = c("00", "00", "00", "80", "ff", "ff", "ff")
  expect_equal(output, expected)
})

test_that("convert strange values into hex", {
  input = c(0, NA, Inf)
  output = x2hex(input)
  expected = c("00", NA, "ff")
  expect_equal(output, expected)
})

test_that("convert matrix of values into hex", {
  input = matrix(c(0, 1, 2, NA, Inf, 0.5), ncol=2, nrow=3)
  rownames(input) = letters[1:3]
  colnames(input) = LETTERS[1:2]
  output = x2hex(input)
  expected = matrix(c("00", "ff", "ff", NA, "ff", "80"), ncol=2, nrow=3)
  rownames(expected) = letters[1:3]
  colnames(expected) = LETTERS[1:2]
  expect_equal(output, expected)
})




## Tests for color lighten/darken

test_that("test shading using default colors", {
  input = c(-1, -0.5, 0, 0.5, 1)
  output = x2col(input)
  expected = c("#0000ffff", "#0000ff80", "#ffffff", "#ff000080", "#ff0000ff")
  expect_equal(output, expected)
})

test_that("test shading without bgcol", {
  input = c(-1, -0.5, 0, 0.5, 1)
  output = x2col(input, bgcol=NULL)
  expected = c("#0000ffff", "#0000ff80", "#0000ff00", "#ff000080", "#ff0000ff")
  expect_equal(output, expected)
})

test_that("test shading with new color scale", {
  input = c(-1, -0.2, 0, 0.2, 1)
  output = x2col(input, col=c("#00ff00", "#ffff00"))
  expected = c("#00ff00ff", "#00ff0033", "#ffffff", "#ffff0033", "#ffff00ff")
  expect_equal(output, expected)
})

test_that("test shading with different range", {
  input = c(-1, -0.4, 0, 0.4, 1, 2)
  output = x2col(input, maxval=2)
  expected = c("#0000ff80", "#0000ff33", "#ffffff", "#ff000033", "#ff000080", "#ff0000ff")
  expect_equal(output, expected)
})

test_that("test shading of a matrix", {
  input = matrix(c(-1, -0.5, 0, NA), nrow=2)
  colnames(input) = rownames(input) = letters[1:2]
  ## also try new bg value
  output = x2col(input, bg=NA)
  expected = matrix(c("#0000ffff", "#0000ff80", NA, NA), nrow=2)
  colnames(expected) = rownames(expected) = letters[1:2]
  expect_equal(output, expected)
})






