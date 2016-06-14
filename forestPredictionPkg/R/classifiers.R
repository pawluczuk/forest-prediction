run_classifiers <- function() {
  # load data
  drops <- c("Id")
  data <- readRDS(system.file("train.Rda", package = "forestPredictionPkg"))
  # removeId column
  data <- data[ , !(names(data) %in% drops)]

  data$Soil_Type <- as.factor(data$Soil_Type)
  data$Cover_Type <- as.factor(data$Cover_Type)
  data$Wilderness_Area <- as.factor(data$Wilderness_Area)

  # analyse fature importance
  feature_statistics(data)

  #split data into training and testing set
  splits <- splitdf(data, seed=123)
  training <- splits$trainset
  testing <- splits$testset

  # save testing data for later prediction
  saveRDS(testing, "inst/testing.Rds")

  # C4.5 decision trees
  print("C4.5: ")
  dt <- c45_classf(training, testing)
  .jcache(dt$classifier)
  classifier_quality(dt)
  saveRDS(dt, "inst/dt.Rds")

  # kNN classification
  print("kNN: ")
  knn <- knn_classf(training)
  .jcache(knn$classifier)
  classifier_quality(knn)
  saveRDS(knn, "inst/knn.Rds")

  # Naive Bayes classification
  print("Naive Bayes: ")
  nb <- naive_bayes(training)
  .jcache(nb$classifier)
  classifier_quality(nb)
  saveRDS(nb, "inst/nb.Rds")
}

splitdf <- function(dataframe, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  list(trainset=trainset,testset=testset)
}
