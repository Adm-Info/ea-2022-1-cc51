#a. ¿Cuántas reservas se realizan por tipo de hotel? o ¿Qué tipo de hotel prefiere la gente?

#Tablas de reseva por tipo de hotel
counts = table(hotel_data$is_canceled, hotel_data$ï..hotel)
barplot(counts, col=c("blue" , "red"), legend = c("Check-in", "Cancelado"), main = "Reserva por tipo de hotel")

#Observar datos
table(hotel_data$is_canceled , hotel_data$ï..hotel)

#Como se puede observar en en la tabla han realizado 79330 reservas en el City Hotel y 40060
#en el Ressort Hotel. A partir de estos datos podemos afirmar que el tipo de hotel que prefiere
#la gente es el City Hotel.