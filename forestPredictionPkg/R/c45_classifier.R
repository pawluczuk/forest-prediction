c45_classf <- function(training_data) {
  checkMinimumLeafExamples <- FALSE
  checkForStability <- FALSE

  if (checkMinimumLeafExamples) {
    print("Checking how incermenting minimum examples in leaf relates to classifier quality")
    pctCorrectVector <- double(50)
    for (i in seq(2, 100, 2)) {
      decision_tree <- J48(Cover_Type ~ ., data = training_data, control = Weka_control(B=TRUE, M=i))
      pctCorrectVector[i/2] <- summary(decision_tree)$details["pctCorrect"]
      print(pctCorrectVector[i/2])
    }
    plot(pctCorrectVector, xlab="Minimalna liczba przykładów w liściu",
         ylab="% poprawnie sklasyfikowanych przykładów")
  }
  else {
    decision_tree <- J48(Cover_Type ~ ., data = training_data, control = Weka_control(B=TRUE))
  }

  if (checkForStability) {
    print("Checking for stability by cross-validation to classifier quality")
    pctCorrectVector <- double(5)
    pctCorrectVector[1] <- summary(decision_tree)$details["pctCorrect"]
    for (folds in 2:5) {
      eval_j48 <- evaluate_Weka_classifier(decision_tree,
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

  decision_tree
}
