## Tests for R/projects.R



testproj = "testproject"




## Tests for creation of a project structure

test_that("initp creates directories", {
  initp(testproj, verbose=FALSE)
  expected_dir = file.path(getwd(), testproj)
  expect_true(file.exists(expected_dir))
  output = list.files(expected_dir)
  expect_gt(length(output), 4)
  unlink(testproj)
})





## Tests for checking variables
