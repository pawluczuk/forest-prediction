naive_bayes <- function(training_data) {
  checkForStability <- FALSE
  naive_bayes <-  LBR(Cover_Type ~ ., data = training_data)
  naive_bayes
}
