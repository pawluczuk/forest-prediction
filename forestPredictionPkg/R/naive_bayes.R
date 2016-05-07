naive_bayes <- function(training, testing) {
  training$Cover_Type <- as.factor(training$Cover_Type)
  classifier <- naiveBayes(
    subset(training, select = -Cover_Type),
    training$Cover_Type
  )

  predictions <- predict(classifier, subset(testing, select = -Cover_Type))
  table(predictions, testing$Cover_Type)
}
