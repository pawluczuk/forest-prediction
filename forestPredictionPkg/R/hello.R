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
  print("Reading training data.")
  training_data <- read.csv("data/train.csv")
  # Statisticts
  cat("\nNumber of training examples: ", length(training_data[,1]))
  cat("\nNumber of variables: ", length(training_data))
  cat("\nDistribution of forest cover types:")
  print(table(training_data$Cover_Type))
  hist(training_data$Cover_Type, main="Histogram of forest types in training set", xlab="Forest Cover type", xlim=c(0,7))
}
