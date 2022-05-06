#CARGAR DATOS
hotel_data <- read.csv ("data/hotel_bookings_miss.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",")

# DUplicados
#solo usaremos columnas no duplicadas
hotel_datos<-unique(hotel_data)

#INSPECCIONAR DATOS
#verificamos que los datos estén acorde al tipo de dato
str(hotel_datos)

# convertimos las columnas necesarias en factor
hotel_datos$ï..hotel <- as.factor(hotel_datos$ï..hotel)
hotel_datos$is_canceled <- as.factor(hotel_datos$is_canceled)
hotel_datos$is_repeated_guest <- as.factor(hotel_datos$is_repeated_guest)
hotel_datos$arrival_date_month <- as.factor(hotel_datos$arrival_date_month)
hotel_datos$meal <- as.factor(hotel_datos$meal)
hotel_datos$country <- as.factor(hotel_datos$country)
hotel_datos$market_segment <- as.factor(hotel_datos$market_segment)
hotel_datos$distribution_channel <- as.factor(hotel_datos$distribution_channel)
hotel_datos$reserved_room_type <- as.factor(hotel_datos$reserved_room_type)
hotel_datos$assigned_room_type <- as.factor(hotel_datos$assigned_room_type)
hotel_datos$deposit_type <- as.factor(hotel_datos$deposit_type)
hotel_datos$agent <- as.factor(hotel_datos$agent)
hotel_datos$company <- as.factor(hotel_datos$company)
hotel_datos$customer_type <- as.factor(hotel_datos$customer_type)
hotel_datos$reservation_status <- as.factor(hotel_datos$reservation_status)

#la columna reservation_status_date será convertida a date
#verificamos el formato de la fecha es dd/mm/yyyy o mm/dd/yyyy
head(hotel_datos$reservation_status_date,50)
#comprobamos que es mm/dd/yyyy
hotel_datos$reservation_status_date <- as.Date(hotel_datos$reservation_status_date, "%m/%d/%y")


#volvemos a comprobar la tabla
str(hotel_datos)
summary(hotel_datos)
