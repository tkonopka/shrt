## tests for R/files.R

library(jsonlite)

testtsv = "amatrix.tsv"
testrda = "anrda.Rda"
testjson = "ajson.json"
unsafetxt = "a-txt.txt"

somedata = data.frame(a.id=1:4, AA=letters[1:4], BB=LETTERS[6:9], stringsAsFactors=F)



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
})

test_that("save and read using made-up rownames", {
  ## create table without a numerical column
  mydata = somedata[, c("AA", "BB")]
  ## save and indicate a new column for ids
  wtht(mydata, file=testtsv, rowid.column = "new.ids")
  output = rtht(testtsv)
  ## expected result should be like somedata but with a column called new.ids
  expected = somedata
  colnames(expected)[1] = "new.ids"
  expect_equal(output, expected)
})

test_that("report wrong attempts to write tables", {
  mydata = somedata[, c("AA", "BB")]
  rownames(mydata) = somedata[, "a.id"]
  expect_error(wtht(mydata, file=testtsv, rowid.column = "AA"))
})

test_that("report wrong attempts to read tables", {
  wtht(somedata, file=testtsv)
  expect_error(rtht(testtsv, rowid.column="ZZ"))
  unlink(testtsv)
})




test_that("retrieve all data files in a directory with one command", {
  ## write some files into local directory
  save(somedata, file=testrda)
  write(toJSON(somedata), file=testjson)
  wtht(somedata, file=testtsv)
  wtht(somedata, file=unsafetxt)

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

  ## retrieve only some types of data
  output2 = loaddir(getwd(), extensions=c("txt", "tsv"))
  expected2 = list("amatrix"=somedata, "a_txt"=somedata)
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

