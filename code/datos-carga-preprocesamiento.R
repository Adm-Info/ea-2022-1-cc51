#CARGAR DATOS
hotel_data <- read.csv ("data/hotel_bookings_miss.csv", header = TRUE, sep = ",")


#INSPECCIONAR DATOS
#verificamos que los datos estén acorde al tipo de dato
str(hotel_data)

#PRE-PROCESAR DATOS
#las columnas is_canceled e is_repeated_guest serán convertidas en factor
hotel_data$is_canceled <- as.factor(hotel_data$is_canceled)
hotel_data$is_repeated_guest <- as.factor(hotel_data$is_repeated_guest)

#la columna reservation_status_date será convertida a date
#verificamos el formato de la fecha es dd/mm/yyyy o mm/dd/yyyy
head(hotel_data$reservation_status_date,50)
#comprobamos que es mm/dd/yyyy
hotel_data$reservation_status_date <- as.Date(hotel_data$reservation_status_date, "%m/%d/%y")


str(hotel_data)

#Identificación de datos faltates
datos_NA <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores NA:",colSums(is.na(x[i])),"\n")
  }
}

datos_NA(hotel_data)

#Identificamos datos en blanco
en_blanco <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores en blanco:",colSums(x[i]==""),"\n")
  }
}
en_blanco(hotel_data)
