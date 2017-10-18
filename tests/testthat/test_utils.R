## Tests for utils.R



## Tests for grep family

test_that("grepv with simple regex", {
    input = c("abc", "bcde", "cdef", "def", "efgh")
    expect_equal(grepv("b", input), c("abc", "bcde"))
})

test_that("grepv with regex with special chars", {
    input = c("b0", "b1", "b2", "b3", "b4", "b5", "b6", "ab3")
    expect_equal(grepv("^b[2-4]", input), c("b2", "b3", "b4"))
})




## Tests for namesX family

nvec1 = setNames(rep(c(1,2), 3), letters[1:6])
nvec2 = setNames(1:6, letters[1:6])

test_that("namesV", {
    output = namesV(nvec1, 1)
    expect_equal(output, c("a", "c", "e"))
})

test_that("namesF", {
    input = nvec2>3
    expect_equal(namesF(input), c("a", "b", "c"))
})

test_that("namesT", {
    input  = setNames(nvec2 %in% c(1,5,6), names(nvec2))    
    expected = c("a", "e", "f")
    ## test when vector is actually logical
    expect_equal(namesT(input), expected)
})




## Tests for df conversions

charmat = mtrx(letters[1:9], col.names=c("x", "y", "z"), nrow=3)
chardf = data.frame(x=c("a", "b", "c"),
                    y=c("d", "e", "f"),
                    z=c("g", "h", "i"),
                    stringsAsFactors=F)

mat1 = mtrx(1:8, col.names=c("x", "y"), nrow=4)
df1 = data.frame(x=1:4, y=5:8)

mat2a = setNames(p0("a", 1:4), letters[1:4])
df2a = data.frame(a="a1", b="a2", c="a3", d="a4", stringsAsFactors=F)
mat2b = setNames(1:4, letters[1:4])
df2b = data.frame(a=1, b=2, c=3, d=4)


test_that("df conversion (characters to df)", {
    expect_equal(x2df(charmat), chardf)
})

test_that("df conversion (mat to df)", {
    expect_equal(x2df(mat1), df1)
})

test_that("df conversion (vector to df)" , {
    expect_equal(x2df(mat2a), df2a)
    expect_equal(x2df(mat2b), df2b)
})




## Tests for pluck family

plist1 = list(A=1:5, B=101:105)
plist2 = list(A=setNames(11:15, letters[1:5]),
              B=setNames(201:203, letters[3:5]))

test_that("pluck element by integer 1", {
    expected1 = setNames(c(1, 101), c("A", "B"))
    expect_equal( sapply(plist1, pluck1), expected1)
    expected2 = setNames(c(2, 102), c("A", "B"))
    expect_equal( sapply(plist1, pluck2), expected2)
})
test_that("pluck element by integer 2", {
    expected1 = setNames(c(11, 201), c("A.a", "B.c"))
    expect_equal( sapply(plist2, pluck1), expected1)
    expected2 = setNames(c(12, 202), c("A.b", "B.d"))
    expect_equal( sapply(plist2, pluck2), expected2)
})
test_that("pluck element by name", {
    expected1 = setNames(c(13, 201), c("A.c", "B.c"))
    expect_equal( sapply(plist2, pluck, "c"), expected1)
    expected2 = setNames(c(14, 202), c("A.d", "B.d"))
    expect_equal( sapply(plist2, pluck, "d"), expected2)
})

