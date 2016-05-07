c45_classf <- function(training, testing) {
  training$Cover_Type <- as.factor(training$Cover_Type)

  ## Identify a decision tree.
  #m <- J48(training$Cover_Type ~., data = training)
  #print(m)
  ## Use 10 fold cross-validation.

}
