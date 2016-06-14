feature_statistics <- function(data) {
  print("Preparing feature statistics.")
  print("Working on plots...")

  #density plots
  boxplots <- list()
  densityplots <- list()
  for(i in names(data)){
    if (!is.factor(data[,i])) {
      boxplots[[ (length(boxplots) +1) ]] <- (ggplot(data, aes_string(x="Cover_Type", y=i)) + geom_boxplot(colour="black", fill="white") + xlab("Cover Type"))
      densityplots[[ (length(densityplots) +1) ]] <- (ggplot(data,aes_string(x=i)) + geom_density(colour="black", fill="white") + xlab(paste(i)))
   }
  }

  # save grouped boxplots
  png(filename="boxplot.png",width = 1200, height = 1200)
  multiplot(plotlist = boxplots, cols=3)
  dev.off()
  print("Saved boxplots...")

  # save grouped density plots
  png(filename="density.png",width = 1200, height = 1200)
  multiplot(plotlist = densityplots, cols=3)
  dev.off()
  print("Saved density plots...")

  print("Working on correlation matrix...")
  cormatrix <- cor(data[sapply(data, is.numeric)])
  png(height=1200, width=1200, pointsize=15, file="correlation-matrix.png")
  corrplot(cormatrix, method="number")
  dev.off()

  print("Chi square attribute values")
  chiSquare <- chi.squared(Cover_Type~. ,data) #discrete target
  chiSquare$features1 <- row.names(chiSquare)
  colnames(chiSquare)[1] <- "chi.square"
  chiSquare$chi.square <- round(chiSquare$chi.square,3)
  chiSquare <- chiSquare[with(chiSquare, order(-chi.square)), ]
  write.csv(chiSquare, "chi-square-results.csv")
}
