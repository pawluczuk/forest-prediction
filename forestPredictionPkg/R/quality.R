classifier_quality <- function(classifier) {
  summary <- summary(classifier)
  print(summary)
  print(summary$details)
}
