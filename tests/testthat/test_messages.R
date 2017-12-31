
## tests for R/messages.R


test_that("using basic msg", {  
  ## write some messages
  tt = today("-")
  expect_message(msg("one"), "one")
  expect_message(msg("two"), tt)
  expect_message(msg(action="show"))
  expect_message(msg())
  out = msg(action="get")
  expect_equal(length(out), 2)
})


test_that("writing/retrieving/reseting messages in custom logger", {

  ## create messaging system
  mymsg = newmsg(verbose=FALSE, date=FALSE)
  
  ## write some messages
  mymsg("hello")
  mymsg("there")

  ## retrieve the messages
  output = mymsg(action="get")
  expected = c("hello", "there")
  expect_equal(output, expected)
  
  mymsg(action="reset")
  output2 = mymsg(action="get")
  expect_equal(output2, c())
})
