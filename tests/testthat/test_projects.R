## Tests for R/projects.R



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

