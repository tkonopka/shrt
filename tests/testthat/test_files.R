## tests for R/files.R

cat("\ntest_files.R ")




library(jsonlite)

testtsv = "amatrix.tsv"
testrda = "anrda.Rda"
testjson = "ajson.json"
unsafetxt = "a-txt.txt"

somedata = data.frame(a.id=1:4, AA=letters[1:4], BB=LETTERS[6:9],
                      stringsAsFactors=F)



###############################################################################
## Tests for rtht and wtht


test_that("save and read standard matrix", {
  wtht(somedata, file=testtsv)
  output = rtht(testtsv)
  expect_equal(somedata, output)
  unlink(testtsv)
})


test_that("save and read using rownames", {
  mydata = somedata[, c("AA", "BB")]
  rownames(mydata) = somedata[, "a.id"]
  wtht(mydata, file=testtsv, rowid.column = "id")
  output = rtht(testtsv, rowid.column="id")
  expect_equal(output, mydata)
  unlink(testtsv)
})


test_that("save and read using made-up rownames", {
  ## create table without a numerical column
  mydata = as.matrix(somedata[, c("AA", "BB")])
  rownames(mydata) = NULL
  ## save and indicate a new column for ids
  wtht(mydata, file=testtsv, rowid.column = "new.ids")
  output = rtht(testtsv)
  ## expected result should be like somedata but with a column called new.ids
  expected = somedata
  colnames(expected)[1] = "new.ids"
  expect_equal(output, expected)
  unlink(testtsv)
})


test_that("report wrong attempts to write tables", {
  mydata = somedata[, c("AA", "BB")]
  rownames(mydata) = somedata[, "a.id"]
  expect_error(wtht(mydata, file=testtsv, rowid.column = "AA"))
  unlink(testtsv)
})


test_that("report wrong attempts to read tables", {
  wtht(somedata, file=testtsv)
  expect_error(rtht(testtsv, rowid.column="ZZ"))
  unlink(testtsv)
})




###############################################################################
## Tests for rtht and wtht


test_that("retrieve all data files in a directory with one command", {
  ## write some files into local directory
  save(somedata, file=testrda)
  write(toJSON(somedata), file=testjson)
  wtht(somedata, file=testtsv)
  wtht(somedata, file=unsafetxt)

  ## retrieve prints messages
  expect_message(loaddir(getwd(), verbose=TRUE))
  
  ## retrieve all the data items
  output = loaddir(getwd())
  ## expected set is the somedata matrix multiple times, labeled with filenames
  expected = list("anrda"=somedata,
                  "amatrix"=somedata,
                  "ajson"=somedata,
                  "a_txt"=somedata)
  ## for testing, make sure lists are ordered the same way
  output = output[sort(names(output))]
  expected = expected[sort(names(expected))]
  expect_equal(output, expected)

  ## clean up after the test
  unlink(testrda)
  unlink(testjson)
  unlink(testtsv)
  unlink(unsafetxt)
})


test_that("retrieve several data files by extension filter", {
  ## write some files into local directory
  save(somedata, file=testrda)
  write(toJSON(somedata), file=testjson)
  wtht(somedata, file=testtsv)
  wtht(somedata, file=unsafetxt)
  
  ## retrieve only some types of data
  output = loaddir(getwd(), extensions=c("txt", "tsv"))
  expected = list("amatrix"=somedata, "a_txt"=somedata)
  output = output[sort(names(output))]
  expected = expected[sort(names(expected))]
  expect_equal(output, expected)
  
  ## clean up after the test
  unlink(testrda)
  unlink(testjson)
  unlink(testtsv)
  unlink(unsafetxt)
})


test_that("attempt to retrieve strange data from directory", {
  expect_error(loaddir(getwd(), extensions=c("txt", "R")))
})



###############################################################################
## Tests for load1


test_that("load1 obtains one item", {
  myobj = 1:4
  save(myobj, file=testrda)
  expect_true(file.exists(testrda))
  rm(myobj)
  objects.before = ls()
  newobj = load1(testrda)
  objects.after = ls()
  expect_equal(sort(objects.after),
               sort(c(objects.before, "objects.before", "newobj")))
  unlink(testrda)
})


test_that("load1 gives error if object contains more than one item", {
  obj1 = 1:4
  obj2 = letters[1:4]
  save(obj1, obj2, file=testrda)
  expect_true(file.exists(testrda))
  rm(obj1, obj2)
  ## because file contains two separate objects, load1 should give error
  expect_error(load1(testrda))
  unlink(testrda)
})



###############################################################################
## Cleanup, just in case

unlink(testrda)
unlink(testjson)
unlink(testtsv)
unlink(unsafetxt)

