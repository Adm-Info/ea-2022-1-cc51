#a. ¿Cuántas reservas se realizan por tipo de hotel? o ¿Qué tipo de hotel prefiere la gente?
#Cargamos la data
hotel_data1 <- read.csv ("data/hotel_bookings_miss.csv", header = TRUE, sep = ",")
#Como se puede observar en la data obtenida existen 2 tipos de hotel EL city hotel y el resort hotel

#Eliminar datos duplicados
hotel_data1.u<-unique(hotel_data1)

#Observar datos unicos
counts = table(hotel_data1.u$is_canceled, hotel_data1.u$ï..hotel)
table(hotel_data1.u$ï..hotel,hotel_data1.u$is_canceled)
table(hotel_data1.u$ï..hotel)
barplot(counts, col=c("blue" , "red"), legend = c("Check-in", "Cancelado"), main = "Reserva por tipo de hotel",  beside = TRUE)

#datos no unicos
table(hotel_data1$ï..hotel,hotel_data1$is_canceled)
table(hotel_data1$ï..hotel)
#Como se puede observar en en la tabla se han realizado 79330 reservas en los hoteles tipo City de las 
#cuales 46228 son check-in y 33102 Cancelados. En el caso de los Resort Hotel presenta 40060
#reservaciones de las cuales 28938 son check-in y 11122 son cancelaciones.
#A partir de esta data se puede llegar a inferir que el tipo de hotel que las personas prefieren es el
#City Hotel