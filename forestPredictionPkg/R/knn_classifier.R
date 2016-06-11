knn_classf <- function(training_data) {
  checkForNeighboursNumber <- TRUE
  checkForStability <- FALSE

  if (checkForNeighboursNumber) {
    print("Checking how incrementing nearest neighbours relates to classifier quality")
    pctCorrectVector <- double(10)
    for (i in 1:10) {
      nearest_neighbours <- IBk(Cover_Type ~ ., data = training_data, control=Weka_control(K=i))
      pctCorrectVector[i] <- summary(nearest_neighbours)$details["pctCorrect"]
      print(pctCorrectVector[i])
    }
    plot(pctCorrectVector, xlab="Liczba najbliższych sąsiadów branych pod uwagę",
         ylab="% poprawnie sklasyfikowanych przykładów")
  }
  else {
    nearest_neighbours <- IBk(Cover_Type ~ ., data = training_data)
  }

  if (checkForStability) {
    print("Checking for stability by cross-validation to classifier quality")
    pctCorrectVector <- double(5)
    pctCorrectVector[1] <- summary(nearest_neighbours)$details["pctCorrect"]
    for (folds in 2:5) {
      eval_j48 <- evaluate_Weka_classifier(nearest_neighbours,
                                           numFolds = folds, complexity = FALSE,
                                           seed = 123, class = TRUE)
      pctCorrectVector[folds] <- eval_j48$details["pctCorrect"]
      print(folds)
      print(eval_j48$details["pctCorrect"])
    }
    print(pctCorrectVector)
    plot(pctCorrectVector,
         xlab="Ilość podziałów zbioru treningowego",
         ylab="% poprawnie sklasyfikowanych przykładów")
  }

  nearest_neighbours
}
