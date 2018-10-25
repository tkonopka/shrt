## Tests for data.R

cat("\ntest_data.R\n")




# helper object, vector with zero length
emptychars = newv("character", 0)




## Tests for ji

test_that("simple Jaccard Index", {
  a = c("a", "b", "c")
  b = c("b", "c", "d", "e")
  expect_equal(ji(c("a"), a), 1/3)
  expect_equal(ji(a, b), 0.4)
})


test_that("Jaccard Index with empty sets", {
  a = letters[1:5]
  empty = c()
  expect_equal(ji(empty, a), 0)
  expect_equal(ji(a, empty), 0)
  expect_equal(ji(empty, empty), NaN)
  expect_equal(ji(a, NA), 0)
})




## Tests for oi

test_that("simple overlap index", {
  a = c("a", "b", "c")
  b = c("b", "c", "d", "e")
  expect_equal(oi(a, b), 2/3)
  expect_equal(oi(b, a), 0.5)
})


test_that("overlap index with empty sets", {
  a = c("a", "b", "c")
  empty = c()
  expect_equal(oi(a, empty), 0)
  expect_equal(oi(empty, a), NaN)
})



## Tests for setsummary

test_that("simple comparison of two sets", {
  a = c("a", "b", "c")
  b = c("b", "c", "d", "e")
  ab = setsummary(a, b)
  expect_equal(ab$a.private, c("a"))
  expect_equal(ab$b.private, c("d", "e"))
  expect_equal(ab$common, c("b", "c"))
})


test_that("non-overlapping sets", {
  a = c("a", "b")
  b = c("d", "e")
  ab = setsummary(a, b)
  expect_equal(ab$a.private, a)
  expect_equal(ab$b.private, b)
  expect_equal(ab$common, emptychars)
})


test_that("complete overlap sets", {
  a = c("a", "b")
  aa = setsummary(a, a)
  expect_equal(aa$a.private, emptychars)
  expect_equal(aa$b.private, emptychars)
  expect_equal(aa$common, a)
})


test_that("empty sets", {
  a = c("a", "b")
  b = emptychars
  ab = setsummary(a, b)
  expect_equal(ab$a.private, a)
  expect_equal(ab$b.private, emptychars)
  expect_equal(ab$common, emptychars)
})


test_that("comparison of vectors with repeat elements", {
  a = c("a", "b", "b")
  b = c("b", "c")
  ab = setsummary(a, b)
  expect_equal(ab$a.private, c("a"))
  expect_equal(ab$b.private, c("c"))
  expect_equal(ab$common, c("b"))
})


