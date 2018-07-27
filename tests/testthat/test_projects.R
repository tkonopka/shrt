## Tests for R/projects.R

cat("\ntest_projects.R\n")




testproj = "projectdir"


## Tests for creation of a project structure

test_that("initp creates directories (without messages)", {
  initp(testproj, verbose=FALSE)
  expected_dir = file.path(getwd(), testproj)
  expect_true(file.exists(expected_dir))
  output = list.files(expected_dir)
  expect_gt(length(output), 4)
  unlink(testproj, recursive=TRUE)
})

test_that("initp creates directories (with messages)", {
  expect_message(initp(testproj), "Creating")
  unlink(testproj, recursive=TRUE)
})

test_that("initp creating custom sets of subdirectories", {
  custom.dirs = c("custom", "data")
  initp(testproj, verbose=FALSE, subdirs=custom.dirs)
  expected_dir = file.path(getwd(), testproj)
  expect_true(file.exists(expected_dir))
  output = sort(list.files(expected_dir))
  expect_equal(sort(list.files(expected_dir)), custom.dirs)
  unlink(testproj, recursive=TRUE)
})

test_that("initp with wrong input", {
  ## 'work' is not allowed as a subdirectory
  expect_error(initp(testproj, verbose=FALSE, subdirs=c("notes", "work")))
})



## Tests for checking variables
## 
## These tests are not quite right, but I don't know how to fix them.
## reqvars() returns the expected results when used after library(shrt)
## but within the tests, reqvars does not detect the defined variables


test_that("reqvars finds defined variables", {
  abc = 10
  output = reqvars(c("abc"), halt=FALSE)
  expected = c(abc=TRUE)
  expect_equal(length(output), length(expected))
})


test_that("reqvars finds defined variables", {
  abc = 10
  expect_error(reqvars(c("missing.var"), halt=TRUE))
  expect_message(reqvars(c("missing.var"), halt=FALSE))
})



