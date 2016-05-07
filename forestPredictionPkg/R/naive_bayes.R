naive_bayes <- function(training, testing) {
  training$Cover_Type <- as.factor(training$Cover_Type)
  classifier <- naiveBayes(
    subset(training, select = -Cover_Type),
    training$Cover_Type
  )

  print(classifier)
  predictions <- predict(classifier, subset(testing, select = -Cover_Type))
  print(length(predictions))
  print(length(testing$Cover_Type))
  t <- table(predictions, testing$Cover_Type)
  print(head(t))
  print(round(sum(predictions == testing$Cover_Type, na.rm = TRUE)/length(testing$Cover_Type), digits = 2))
}
