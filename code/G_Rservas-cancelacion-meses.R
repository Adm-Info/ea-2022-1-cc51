# g. ¿En qué meses del año se producen más cancelaciones de reservas?

# * Visualización de datos
reservs.canceled <- hotel_datos[hotel_datos$is_canceled==1,][,c('reservation_status','reservation_status_date')]
reservs.canceled['months_names'] <- months(reservs.canceled$reservation_status_date)
reservs.canceled['months_nums'] <- strftime(reservs.canceled$reservation_status_date,"%m")
reservs.canceled['months'] <- paste(reservs.canceled$months_nums,':',reservs.canceled$months_names,sep='')
boxplot(reservation_status_date ~ reservation_status , data = reservs.canceled,
        col = c('chocolate1','orangered'), drop=TRUE, horizontal = TRUE,
        ylab = "Estado de reserva", xlab = "Meses",
        main = "Estado de reservas canceladas por meses")
table(reservs.canceled[,c('reservation_status','months')])
# Como se puede observar, entre los meses de marzo a octubre se dieron las cancelaciones,
# siendo entre junio a julio los más frecuentes

