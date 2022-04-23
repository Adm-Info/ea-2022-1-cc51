#OPEN FILE
hotel_data <- read.csv ("data/hotel_bookings_miss.csv", header = TRUE, sep = ",")
#PREGUNTA A
barplot(table(hotel_data$ï..hotel), main = "Reservas por tipo de hotel")
#PREGUNTA B
counts = table(hotel_data$is_canceled, hotel_data$arrival_date_year)
barplot(counts, col=c("green","red"),legend = c("No Cancelado", "Cancelado"), main = "")
