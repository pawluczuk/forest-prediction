knn_classf <- function(training, testing) {
  training$Cover_Type <- as.factor(training$Cover_Type)
  predictions <- knn(
    subset(training, select = -Cover_Type),
    subset(testing, select = -Cover_Type),
    training$Cover_Type,
    k=3, prob=TRUE, use.all=TRUE
  )
  table(predictions, testing$Cover_Type)
}
