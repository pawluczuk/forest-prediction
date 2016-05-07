run_classifiers <- function() {
  # load data
  data <- readRDS(system.file("train.Rda", package = "forestPredictionPkg"))

  # split data into training and testing set
  splits <- splitdf(data, seed=808)
  training <- splits$trainset
  testing <- splits$testset

  # train controller
  # not used yet! splitting data to 10 parts and teaches on 3
  train_control <- trainControl(method="repeatedcv", number=10, repeats=3)

  # Naive Bayes classification
  nb <- naive_bayes(training, testing)
  print("Naive Bayes: ")
  nb_cm <- confusionMatrix(nb)
  print(nb_cm)

  # kNN classification
  knn <- knn_classf(training, testing)
  print("kNN: ")
  knn_cm <- confusionMatrix(knn)
  print(knn_cm)

  # C4.5 decision trees
  dt <- c45_classf(training, testing)
  print("C4.5: ")
  #dt_cm <- confusionMatrix(dt)
  #print(dt_cm)
}

splitdf <- function(dataframe, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  list(trainset=trainset,testset=testset)
}
