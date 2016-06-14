knn_classf <- function(training_data) {
  checkForNeighboursNumber <- FALSE
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
    training_data <- training_data[ , !(names(training_data) %in% c("Hillshade_3am"))]
    nearest_neighbours <- IBk(Cover_Type ~ ., data = training_data, control=Weka_control(K=4))
  }

  if (checkForStability) {
    print("Checking for stability by cross-validation to classifier quality")
    indexes <- c(2,5,10, 100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, (nrow(training_data)-1))
    pctCorrectVector <- double(length(indexes))

    pctCorrectVector[1] <- summary(nearest_neighbours)$details["pctCorrect"]
    for (folds in 1:length(pctCorrectVector)) {
      eval_j48 <- evaluate_Weka_classifier(nearest_neighbours,
                                           numFolds = indexes[folds], complexity = FALSE,
                                           seed = 123, class = TRUE)
      pctCorrectVector[folds] <- eval_j48$details["pctCorrect"]
      print(folds)
      print(eval_j48$details["pctCorrect"])
    }
    pctCorrectVector <- c(summary(nearest_neighbours)$details["pctCorrect"], pctCorrectVector)
    indexes <- c(1,indexes)

    print(pctCorrectVector)

    # save image
    png(filename="knn-cv.png", width = 400, height = 400)
      plot(indexes,pctCorrectVector, xlim = c(0,(nrow(training_data) + 10)), ylim = c(0,100),
           xlab="Ilość podziałów zbioru treningowego",
           ylab="% poprawnie sklasyfikowanych przykładów")
    dev.off()

  }

  nearest_neighbours
}
