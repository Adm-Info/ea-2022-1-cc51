#CARGAR DATOS
hotel_data <- read.csv ("data/hotel_bookings_miss.csv", header = TRUE, sep = ",")

# DUplicados
#solo usaremos columnas no duplicadas
hotel_datos<-unique(hotel_data)

#INSPECCIONAR DATOS
#verificamos que los datos estén acorde al tipo de dato
str(hotel_datos)

#las columnas is_canceled e is_repeated_guest serán convertidas en factor
hotel_datos$is_canceled <- as.factor(hotel_datos$is_canceled)
hotel_datos$is_repeated_guest <- as.factor(hotel_datos$is_repeated_guest)

#la columna reservation_status_date será convertida a date
#verificamos el formato de la fecha es dd/mm/yyyy o mm/dd/yyyy
head(hotel_datos$reservation_status_date,50)
#comprobamos que es mm/dd/yyyy
hotel_datos$reservation_status_date <- as.Date(hotel_datos$reservation_status_date, "%m/%d/%y")

#Concatenaremos las columnas "arrival_date_..." para crear una sola con formato fecha
#verificamos que los meses tienen formato con nombre del mes, por tanto los transformaremos en número
hotel_datos$arrival_date <- paste(hotel_datos$arrival_date_year,
                                  match(substr( hotel_datos$arrival_date_month, 1, 3), month.abb),
                                  hotel_datos$arrival_date_day_of_month, sep="-")
hotel_datos$arrival_date <- as.Date(hotel_datos$arrival_date)
summary(hotel_datos$arrival_date)

#volvemos a comprobar la tabla
str(hotel_datos)
