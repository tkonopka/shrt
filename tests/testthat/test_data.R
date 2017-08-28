## Tests for data.R


# helper object, vector with zero length
emptychars = newv("character", 0)




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


