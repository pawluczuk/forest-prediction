run_classifiers <- function() {
  # load data
  drops <- c("Id")
  data <- readRDS(system.file("train.Rda", package = "forestPredictionPkg"))
  # removeId column
  data <- data[ , !(names(data) %in% drops)]

  # treat every column as factor
  data <- as.data.frame(lapply(data, factor))

  # C4.5 decision trees
  #print("C4.5: ")
  #dt <- c45_classf(data)
  #classifier_quality(dt)

  # Naive Bayes classification
  print("Naive Bayes: ")
  nb <- naive_bayes(data)
  classifier_quality(knn)

  # kNN classification
  print("kNN: ")
  #knn <- knn_classf(data)
  #classifier_quality(knn)

  # split data into training and testing set
  # splits <- splitdf(data, seed=808)
  # training <- splits$trainset
  # testing <- splits$testset
}

splitdf <- function(dataframe, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  list(trainset=trainset,testset=testset)
}
