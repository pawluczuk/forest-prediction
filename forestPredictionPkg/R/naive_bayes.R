naive_bayes <- function(training_data) {
  checkForStability <- FALSE
  training_data <- training_data[ , !(names(training_data) %in% c("Hillshade_3am"))]

  NB <- make_Weka_classifier("weka/classifiers/bayes/NaiveBayes")
  nb_model <- NB(Cover_Type ~ ., data = training_data, control=Weka_control(K=TRUE))

  if (checkForStability) {
    print("Checking for stability by cross-validation to classifier quality")
    indexes <- c(2,5,10, 20, 100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, nrow(training_data))
    pctCorrectVector <- double(length(indexes))

    pctCorrectVector[1] <- summary(nb_model)$details["pctCorrect"]
    for (folds in 1:length(pctCorrectVector)) {
      eval_j48 <- evaluate_Weka_classifier(nb_model,
                                           numFolds = indexes[folds], complexity = FALSE,
                                           seed = 123, class = TRUE)
      pctCorrectVector[folds] <- eval_j48$details["pctCorrect"]
      print(folds)
      print(eval_j48$details["pctCorrect"])
    }

    pctCorrectVector <- c(summary(nb_model)$details["pctCorrect"], pctCorrectVector)
    indexes <- c(1,indexes)

    print(pctCorrectVector)

    png(filename="nb-cv.png", width = 400, height = 400)
    plot(indexes,pctCorrectVector, xlim = c(0,(nrow(training_data) + 10)), ylim = c(0,100),
         xlab="Ilość podziałów zbioru treningowego",
         ylab="% poprawnie sklasyfikowanych przykładów")
    dev.off()

  }

  nb_model
}
