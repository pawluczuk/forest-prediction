# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

hello <- function() {
  require(ggplot2)
  require(rmarkdown)
  require(shiny)

  # read script for merging data
  if(!exists("merge_testdata", mode="function"))
    source(system.file("merge_testdata.R", package = "forestPredictionPkg"))
  # read script for printing statistics
  if(!exists("print_statistics", mode="function"))
    source(system.file("print_statistics.R", package = "forestPredictionPkg"))

  print("Reading training data.")

  # read training data

  if(!file.exists(system.file("train.Rda", package = "forestPredictionPkg"))) {
    training_data_path <- system.file("train.csv", package = "forestPredictionPkg")
    training_data <- read.csv(training_data_path)
    training_data <- merge_testdata(training_data)
    saveRDS(training_data,file=paste(path.package("forestPredictionPkg"), "/train.Rda", sep=""))
  }
  data <- readRDS(system.file("train.Rda", package = "forestPredictionPkg"))
  # print statistics
  print_statistics(data)
}
