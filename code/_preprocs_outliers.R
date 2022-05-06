# IDENTIFICACIÓN DE DATOS ATÍTPICOS (Outliers) Y GUARDADO DE BD.

# CHILDREN: 
summary(hotel_datos$children)
boxplot(hotel_datos$children)
# observamos como dato atípico quien indica más de 4 hijos:
outline_children_rows <- as.integer(rownames(hotel_datos[hotel_datos$children > 4,]))
hotel_datos[outline_children_rows,c('reserved_room_type','children')]
# Como en la D no suele haber niños, se colocará 0
hotel_datos[hotel_datos$children > 4,'children'] <- 0
hotel_datos[outline_children_rows,c('reserved_room_type','children')]


# BABIES: solo hay 2 datos atípicos: 10 y 9
# No se aprecia una categoría que muestre cierta relación con la cantidad de bebés
outlier_babies_rows <- rownames(hotel_datos[hotel_datos$babies >= 9,])
hotel_datos$babies[hotel_datos$babies >= 9] <- 0
hotel_datos[outlier_babies_rows,c('reserved_room_type','babies')]


# ADULTS: hay 14 valores atipicos: 10, 20, 26, 27, 50 , 50 ,55
outlier_adults_rows <- rownames(hotel_datos[hotel_datos$adults >= 10,])
hotel_datos$adults[hotel_datos$adults >= 10] <- 2
hotel_datos[outlier_adults_rows,c('reserved_room_type','adults')]


# required_car_parking_spaces
boxplot(x = hotel_datos$required_car_parking_spaces)
table(hotel_datos$required_car_parking_spaces)
#  0     1     2     3     8 
#80130  7280    28     3     2 
# se observa que como datos atípicos aquellos que son superiores a 1 (parking spaces)
# compararemos los aparcamientos requeridos con el la cantidad de adultos
boxplot(required_car_parking_spaces ~ adults, data=hotel_datos)
# observamos que es posible encontrar hasta 3 reservas
# sin embargo, se considerará como dato no válido aquellos que
# tengan una cantidad de aparcamientos superior a la cantidad de adultos
# y se colocarán con el máximo de adultos
hotel_datos$required_car_parking_spaces[
  hotel_datos$adults < hotel_datos$required_car_parking_spaces
  ] <- hotel_datos$adults[hotel_datos$adults < hotel_datos$required_car_parking_spaces]
boxplot(required_car_parking_spaces ~ adults, data=hotel_datos)


#reservation_status e is_canceled
boxplot(reservation_status_date ~ reservation_status * is_canceled, data = hotel_datos, 
        ylab = "Meses y Si fue cancelado", xlab = "Estado de reserva", drop=TRUE, horizontal = TRUE)
# No se encontraron datos atípicos. Si han sido cancelados están marcados como tal


#================
# GUARDAR DATOS
write.csv(hotel_datos,"data/hotel_data_proc.csv", row.names = TRUE)


