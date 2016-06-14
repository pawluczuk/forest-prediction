c45_classf <- function(training_data, testing) {
  checkMinimumLeafExamples <- FALSE
  checkForStability <- FALSE

  if (checkMinimumLeafExamples) {
    print("Checking how incrementing minimum examples in leaf relates to classifier quality")
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
    training_data <- training_data[ , !(names(training_data) %in% c("Hillshade_3am"))]
    decision_tree <- J48(Cover_Type ~ ., data = training_data,
                         control = Weka_control(R=TRUE, N=10, B=TRUE, M=10))
  }

  if (checkForStability) {
    print("Checking for stability by cross-validation to classifier quality")
    indexes <- c(2,5,10, 100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, (nrow(training_data)-1))
    #indexes <- c(2,5,10)
    pctCorrectVector <- double(length(indexes))
    pctCorrectVector[1] <- summary(decision_tree)$details["pctCorrect"]
    for (folds in 1:length(pctCorrectVector)) {
      eval_j48 <- evaluate_Weka_classifier(decision_tree,
                                           numFolds = indexes[folds], complexity = FALSE,
                                           seed = 123, class = TRUE)
      pctCorrectVector[folds] <- eval_j48$details["pctCorrect"]
      print(indexes[folds])
      print(eval_j48$details["pctCorrect"])
    }

    pctCorrectVector <- c(summary(decision_tree)$details["pctCorrect"], pctCorrectVector)
    indexes <- c(1,indexes)

    print(pctCorrectVector)

    png(filename="j48-cv.png", width = 400, height = 400)
    plot(indexes,pctCorrectVector, xlim = c(0,(nrow(training_data) + 10)), ylim = c(0,100),

         xlab="Ilość podziałów zbioru treningowego",
         ylab="% poprawnie sklasyfikowanych przykładów")
    dev.off()
  }

  decision_tree
}
