## tests for R/messages.R


test_that("writing/retrieving/reseting messages", {

  ## create messaging system
  mymsg = newmsg(verbose=FALSE, date=FALSE)
  
  ## write some messages
  mymsg("hello")
  mymsg("there")

  ## retrieve the messages
  output = mymsg(action="get")
  expected = c("hello\n", "there\n")
  expect_equal(output, expected)

  mymsg(action="reset")
  output2 = mymsg(action="get")
  expect_equal(output2, c())
})
