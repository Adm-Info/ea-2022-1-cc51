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

#Concatenaremos las columnas "arrival_date_..." para crear una sola con formato fecha
#verificamos que los meses tienen formato con nombre del mes, por tanto los transformaremos en número



hotel_data$arrival_date <- paste(hotel_data$arrival_date_year,
                                 match(substr( hotel_data$arrival_date_month, 1, 3), month.abb),
                                 hotel_data$arrival_date_day_of_month, sep="-")
hotel_data$arrival_date <- as.Date(hotel_data$arrival_date)
summary(hotel_data$arrival_date)


#volvemos a comprobar la tabla
str(hotel_data)

#Identificación de datos faltates
datos_NA <- function(x){
  sum = 0
  cat("Columnas : total de valores NA \n")
  for(i in 1:ncol(x)) {
    #solo aquellas columnas donde falten datos
    n_nas <- colSums(is.na(x[i]))
    if (n_nas > 0) {
      cat(colnames(x[i]),":",n_nas,"\n")
    }
  }
}

datos_NA(hotel_data)

#Columnas : total de valores NA 
#lead_time : 21 
#arrival_date_year : 6 
#arrival_date_week_number : 25 
#arrival_date_day_of_month : 7 
#stays_in_weekend_nights : 25 
#stays_in_week_nights : 12 
#adults : 12 
#children : 4 
#babies : 32 
#days_in_waiting_list : 7
#arrival_date : 13 < es la cantidad de días NA y meses NA

hotel_data[is.na(hotel_data$arrival_date),]


#Identificamos datos en blanco
en_blanco <- function(x){
  sum = 0
  cat("Columnas : total de valores en blanco \n")
  for(i in 1:ncol(x))
  {
    n_blanks = colSums(x[i]=="")
    if (n_blanks > 0 | is.na(n_blanks)) {
      cat(colnames(x[i]),":",n_blanks,"\n")
    }
  }
}
en_blanco(hotel_data)
#no hay



