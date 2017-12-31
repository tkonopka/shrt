## Tests for R/utils.R



## Tests for grep family

test_that("grepv with simple regex", {
  input = c("abc", "bcde", "cdef", "def", "efgh")
  expect_equal(grepv("b", input), c("abc", "bcde"))
})

test_that("grepv with regex with special chars", {
  input = c("b0", "b1", "b2", "b3", "b4", "b5", "b6", "ab3")
  expect_equal(grepv("^b[2-4]", input), c("b2", "b3", "b4"))
})




## Tests for h1, h2, h3

test_that("head with preset length, vector", {
  input = c("abc", "bcde", "cdef", "def", "efgh")
  expect_equal(h1(input), input[1])
  expect_equal(h2(input), input[1:2])
  expect_equal(h3(input), input[1:3])
})

test_that("head with preset length, data frame", {
  input = data.frame(A=letters[1:5], val=1:5)
  expect_equal(h1(input), input[1,])
  expect_equal(h2(input), input[1:2,])
  expect_equal(h3(input), input[1:3,])
})

test_that("head with preset length, empty", {
  input = data.frame(A=letters[1:5], val=1:5)
  input = input[c(),]
  ## h1-h3 should return data frames with the same columns
  expect_equal(h1(input), input)
  expect_equal(h2(input), input)
  expect_equal(h3(input), input)
})




## Tests for lenu

test_that("lenu with basic input", {
  expect_equal(lenu(letters), length(letters))
  inrep = c("a", "b", "c", "b", "d", "b", "b", "c")
  expect_equal(lenu(inrep), 4)
})



## Tests for matrix creation

test_that("create matrix based on rownames and colnames", {
  ## basic matrix without colnames
  out1 = mtrx(0, ncol=3, nrow=5)
  expected = matrix(0, ncol=3, nrow=5)
  expect_equal(out1, expected)
  ## create matrix with names
  output = mtrx(0, col.names=LETTERS[1:3], row.names=letters[1:5])
  colnames(expected) = LETTERS[1:3]
  rownames(expected) = letters[1:5]
  expect_equal(output, expected)
})

test_that("create matrix with mismatching size and names", {
  expect_error(mtrx(0, ncol=3, col.names=letters[1:4], nrow=4))
  expect_error(mtrx(0, ncol=3, row.names=letters[1:4], nrow=3))
})




## Tests for creating new vectors/lists

test_that("creation of new lists", {
  ## lists of certain length
  expected1 = vector("list", 2)
  expect_equal(newv("list", 2), vector("list", 2))
  expected2 = list(AA=c(NULL), BB=c(NULL))
  expect_equal(newv("list", names=c("AA", "BB")), expected2)
})

test_that("creation of new vectors with integers", {
  ## lists of certain length
  expect_equal(newv("integer", 2), c(0, 0))
  expect_equal(newv("logical", names=c("AA", "BB")), c("AA"=FALSE, "BB"=FALSE))
})

test_that("creation of new vectors (irregular inputs)", {
  ## lists of certain length
  expect_error(newv("integer", 2, names=letters[1:4]))
})





## Tests for namesX family

nvec1 = setNames(rep(c(1,2), 3), letters[1:6])
nvec2 = setNames(1:6, letters[1:6])

test_that("use of namesV", {
  output = namesV(nvec1, 1)
  expect_equal(output, c("a", "c", "e"))
})

test_that("use of namesF", {
  input = nvec2>3
  expect_equal(namesF(input), c("a", "b", "c"))
})

test_that("use of namesT", {
  input  = setNames(nvec2 %in% c(1,5,6), names(nvec2))    
  expected = c("a", "e", "f")
  ## test when vector is actually logical
  expect_equal(namesT(input), expected)
})

test_that("use of namesNA", {
  input  = nvec2
  expected = c("a", "d")
  input[expected] = NA
  expect_equal(namesNA(input), expected)
})

test_that("names family gives errors", {
  expect_error(namesT(nvec1))
  expect_error(namesF(nvec1))
  temp = nvec1
  names(temp) = NULL
  expect_error(namesV(temp, 2))
})




## Tests for pluck family

plist1 = list(A=1:5, B=101:105)
plist2 = list(A=setNames(11:15, letters[1:5]),
              B=setNames(201:203, letters[3:5]))
pmatrix = mtrx(1:8, col.names=c("A", "B"), row.names=letters[1:4])


test_that("pluck element by integer 1", {
  expected1 = setNames(c(1, 101), c("A", "B"))
  expect_equal(sapply(plist1, pluck1), expected1)
  expected2 = setNames(c(2, 102), c("A", "B"))
  expect_equal(sapply(plist1, pluck2), expected2)
})
test_that("pluck element by integer 2", {
  expected1 = setNames(c(11, 201), c("A.a", "B.c"))
  expect_equal(sapply(plist2, pluck1), expected1)
  expected2 = setNames(c(12, 202), c("A.b", "B.d"))
  expect_equal(sapply(plist2, pluck2), expected2)
})
test_that("pluck element by name", {
  expected1 = setNames(c(13, 201), c("A.c", "B.c"))
  expect_equal(sapply(plist2, pluck, "c"), expected1)
  expected2 = setNames(c(14, 202), c("A.d", "B.d"))
  expect_equal(sapply(plist2, pluck, "d"), expected2)
})
test_that("pluck from list", {
  expected1 = plist1[[1]]
  expect_equal(pluck1(plist1), plist1[[1]])
  expect_equal(pluck2(plist1), plist1[[2]])
})
test_that("pluck from matrix", {
  expected1 = pmatrix["b", ]
  expected2 = pmatrix["c", ]
  expect_equal(pluck2(pmatrix), expected1)
  expect_equal(pluck(pmatrix, "c"), expected2)
})
test_that("pluck from unknown object type", {
  somefunction = function(x) { x }
  expect_error(pluck1(somefunction))
})




## Tests for today string

test_that("today is a string", {
  output = today()
  output.dash = today("-")
  ## it is hard to test the value given by today, but it must be a string
  expect_equal(class(output), "character")
  expect_gt(nchar(output), 4)
  expect_equal(nchar(output.dash)-nchar(output), 2)
})




## Tests for x2df conversions

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

test_that("avoid df-conversion when not needed", {
  expect_equal(x2df(df2a), df2a)
})



