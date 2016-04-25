# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

hello <- function() {
  print("Reading training data.")
  training_data <- read.csv("data/train.csv")
  # Statisticts
  cat("\nNumber of training examples: ", length(training_data[,1]))
  cat("\nNumber of variables: ", length(training_data))
  cat("\nDistribution of forest cover types:")
  print(table(training_data$Cover_Type))
  hist(training_data$Cover_Type, main="Histogram of forest types in training set", xlab="Forest Cover type", xlim=c(0,8))

  names = c("Nazwa atrybutu", "Typ atrybutu", "Brakujące wartości", "Unikalne wartości", "Max", "Min", "Średnia", "Mediana", "Odchylenie standardowe")

  mx <- matrix(NA, nrow = length(names(training_data)), ncol = length(names), byrow = TRUE)
  counter <- 1
  for (i in names(training_data)) {
    print(i)
    print(counter)
    if (class(training_data[[paste(i)]]) == "integer") {

      vector <- c(i,
                  class(training_data[[paste(i)]]),
                  sum(is.na(training_data[paste(i)])),
                  length(unique(training_data[paste(i)])),
                  max(training_data[paste(i)]),
                  min(training_data[paste(i)]),
                  mean(training_data[[paste(i)]]),
                  median(training_data[[paste(i)]]),
                  sd(training_data[[paste(i)]]))
      mx[counter,] <- vector
      counter <- counter+1

    }
    else {
      vector <- c(i,
                  class(training_data[[paste(i)]]),
                  sum(is.na(training_data[paste(i)])),
                  length(unique(training_data[paste(i)]))
                )
      mx[counter,] <- vector
      counter <- counter+1
    }

  }
  colnames(mx) <- names
  print(mx)

  }
