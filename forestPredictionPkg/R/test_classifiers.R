test_classifiers <- function(data, knn, nb, dt) {
  # testing data
  data <- readRDS("inst/testing.Rds")

  # k-nearest neighbours model
  print("####### KNN #######")
  knn <- readRDS("inst/knn.Rds")
  knn_results <- predict(knn, newdata=data, type=c("class"))
  cm_knn <- confusionMatrix(knn_results, data$Cover_Type)
  print(cm_knn)

  # naive Bayes model
  print("####### NAIVE BAYES #######")
  nb <- readRDS("inst/nb.Rds")
  nb_results <- predict(nb, newdata=data, type=c("class"))
  cm_nb <- confusionMatrix(nb_results, data$Cover_Type)
  print(cm_nb)

  # C4.5 decision tree
  print("####### C4.5 DECISION TREE #######")
  dt <- readRDS("inst/dt.Rds")
  dt_results <- predict(dt, newdata=data, type=c("class"))
  cm_dt <- confusionMatrix(dt_results, data$Cover_Type)
  print(cm_dt)

}
