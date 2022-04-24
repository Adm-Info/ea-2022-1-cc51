#CARGAR DATOS
hotel_data <- read.csv ("data/hotel_bookings_miss.csv", header = TRUE, sep = ",")

#PRE-PROCESAR DATOS

#verificamos que los datos estén acorde al tipo de dato
str(hotel_data)

#las columnas is_canceled e is_repeated_guest serán convertidas en factor
hotel_data$is_canceled <- as.factor(hotel_data$is_canceled)
hotel_data$is_repeated_guest <- as.factor(hotel_data$is_repeated_guest)

#la columna reservation_status_date será convertida a date
#verificamos el formato de la fecha es dd/mm/yyyy o mm/dd/yyyy
head(hotel_data$reservation_status_date,50)
#comprobamos que es mm/dd/yyyy
hotel_data$reservation_status_date <- as.Date(hotel_data$reservation_status_date, "%m/%d/%y")


str(hotel_data)
