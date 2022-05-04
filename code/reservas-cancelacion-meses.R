# g. ¿En qué meses del año se producen más cancelaciones de reservas?

#names(hotel_data)
#IsCanceled Value indicating if the booking was canceled (1) or not (0)
summary(hotel_data$is_canceled)
#solo aquuellos que no cancelaron (1)
#ReservationStatus:
#Canceled – booking was canceled by the customer;
#Check-Out – customer has checked in but already departed;
#No-Show – customer did not check-in and did inform the hotel of the reason why
summary(hotel_data$reservation_status)
#ReservationStatusDate	Date	Date at which the last status was set.
#This variable can be used in conjunction with the ReservationStatus
#to understand when was the booking canceled or when did the customer checked-out of the hotel
summary(hotel_data$reservation_status_date)

# * Identificación de datos faltantes (NA).
#No hay
# * Técnica utilizada para eliminar o completar los datos faltantes.
# * Identificación de datos atípicos (Outliers).
boxplot(reservation_status_date ~ reservation_status * is_canceled, data = hotel_data,
      ylab = "Meses y Si fue cancelado", xlab = "Estado de reserva", drop=TRUE, horizontal = TRUE)
# No se encontraron datos atípicos. Si han sido cancelados están marcados como tal
# * Técnica(s) utilizada(s) para transformar los datos atípicos

# * Visualización de datos
boxplot(reservation_status_date ~ reservation_status , data = hotel_data,
        ylab = "Meses y Si fue cancelado", xlab = "Estado de reserva", drop=TRUE, horizontal = TRUE,
        subset = is_canceled==1)
# Como se puede observar, entre los meses de marzo a octubre se dieron las cancelaciones,
# siendo entre junio a julio los más frecuentes

