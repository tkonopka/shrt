## test for R/loops.R


## functions used within tests of apply
afun = function(i, x) {
  paste(i, x)
}


test_that("apply with index (basic use)", {
  ## apwi allows computing apply with explicit reference to element index
  input = c("a", "b", "c")
  expected = list("1 a", "2 b", "3 c")
  expect_equal(apwi(input, afun), expected)
})


test_that("apply with index (using names as indexes)", {
  ## apwi allows computing apply with explicit reference to element index
  input = c(AA="a", BB="b", CC="c")
  expected = list(AA="AA a", BB="BB b", CC="CC c")
  expect_equal(apwi(input, afun), expected)
})


