merge_testdata <- function(data) {
  print("Merging data...")
  #Adding place for new attributes: Wilderness_Area and Soil_type
  names <- names(data)
  data$Wilderness_Area <- NA
  data$Soil_Type <- NA

  for(i in 1:nrow(data)) {
    data[i,] <- merge_row(data[i,], names)
  }

  attrs_to_drop <- names(data)[grep("Wilderness_Area[1-9]|Soil_Type[1-9]", names(data))]
  data$Cover_Type <- as.factor(data$Cover_Type)
  data[ , !(names(data) %in% attrs_to_drop)]
}

merge_row <- function(row, names) {
  # get wilderness area attrs that need merging
  wa <- "Wilderness_Area"
  wa_names <- names[grep(pattern = wa, x = names)]

  row <- merge_attribute(row, wa, wa_names)

  # get soil type attrs that need merging
  st <- "Soil_Type"
  st_names <- names[grep(pattern = st, x = names)]

  row <- merge_attribute(row, st, st_names)

  row
}

merge_attribute <- function(row, attribute, attribute_names) {
  for(attr in attribute_names) {
    if (row[[paste(attr)]] == 1)
      row[[paste(attribute)]] = as.integer(gsub(pattern = attribute, replacement = "", x = attr))
  }
  row
}
