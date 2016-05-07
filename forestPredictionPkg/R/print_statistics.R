print_statistics <- function(training_data) {
  # Statisticts
  names = c("Nazwa atrybutu", "Typ atrybutu", "Brakujące wartości", "Unikalne wartości", "Max", "Min", "Średnia", "Mediana", "Odchylenie standardowe", "Korelacja z klasą wyjściową")

  mx <- matrix(NA, nrow = length(names(training_data)), ncol = length(names), byrow = TRUE)
  counter <- 1
  for (i in names(training_data)) {
    if (class(training_data[[paste(i)]]) == "integer") {

      vector <- c(i,
                  class(training_data[[paste(i)]]),
                  sum(is.na(training_data[paste(i)])),
                  length(unique(training_data[paste(i)])),
                  max(training_data[paste(i)]),
                  min(training_data[paste(i)]),
                  mean(training_data[[paste(i)]]),
                  median(training_data[[paste(i)]]),
                  sd(training_data[[paste(i)]]),
                  cor(training_data[paste(i)], training_data$Cover_Type)
      )
      mx[counter,] <- vector
      counter <- counter+1

    }
  }

  colnames(mx) <- names

  print("Podusmowanie wartości atrybutów")
  write.csv(x = mx, file = paste(path.package("forestPredictionPkg"), "/table.csv", sep=""))

  rmarkdown::run(system.file("report.Rmd", package = "forestPredictionPkg"))
}
