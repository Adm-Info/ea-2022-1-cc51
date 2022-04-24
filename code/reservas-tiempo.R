#b- ¿Está aumentando la demanda con el tiempo?

#Revisar datos faltantes

#Tecnica para eliminar datos

#Visualización de datos
counts = table(hotel_data$is_canceled, hotel_data$arrival_date_year)
barplot(counts, col=c("green","red"),legend = c("No Cancelado", "Cancelado"), main = "")

table(hotel_data$is_canceled, hotel_data$arrival_date_year)