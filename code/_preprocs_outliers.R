# IDENTIFICACIÓN DE DATOS ATÍTPICOS (Outliers).

# CHILDREN: 
summary(hotel_datos$children)
# se observa el máximo 10, que es un dato
# atípico considerando que la moda es 0,1029 y la mediana, 0
# Dado que las familias con niños requieren un poco más de espacio en el cuarto,
# usaremos la variable tipo de cuarto para comparar
boxplot(hotel_datos$children ~ hotel_datos$reserved_room_type, ylim  = c(0,3),
        main = "Tipos de cuartos reservados vs Cantidad de niños",
        xlab = "Tipos de cuarto", ylab="Cantidad de niños")
# en las categorias de cuartos a, d, e, l y p no suelen tener niños
# en la categoría H suelen haber 1 niño, y en la categoría F,
# aunque no la mayoría, la distribución se concentra en 1 niño
# en las categorías C y G, aunque no todos, la mediana se halla en 2 niños
# en la categoria B, la mediana se encuentra en 0 niños
hotel_datos[is.na(hotel_datos$children),][,c('reserved_room_type','children')]
empty_children_rows <- as.integer(rownames(hotel_datos[is.na(hotel_datos$children),]))
# son 4 filas: 40601 40668 40680 41161
# se observa que todos tienen reserved_room_type B, en los cuales la cantidad de niños
# varía entre 0, 1 y 2
hotel_datos[is.na(hotel_datos$children),'children'] <- sample(c(0,2), replace=TRUE, size=4)
hotel_datos[empty_children_rows,c('reserved_room_type','children')]


# BABIES: solo hay 2 datos atípicos: 10 y 9
# No se aprecia una categoría que muestre cierta relación con la cantidad de bebés
outlier_babies_rows <- rownames(hotel_datos[hotel_datos$babies >= 9,])
hotel_datos$babies[hotel_datos$babies >= 9] <- 0
hotel_datos[outlier_babies_rows,c('reserved_room_type','babies')]


# ADULTS: hay 14 valores atipicos: 10, 20, 26, 27, 50 , 50 ,55
outlier_adults_rows <- rownames(hotel_datos[hotel_datos$adults >= 10,])
hotel_datos$adults[hotel_datos$adults >= 10] <- 2
hotel_datos[outlier_adults_rows,c('reserved_room_type','adults')]

