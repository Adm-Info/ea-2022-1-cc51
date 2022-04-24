# e. ¿Cuántas reservas incluyen niños y/o bebes?

# * Identificación de datos faltantes (NA).
summary(hotel_data[, c('children','babies')])
# Existen 4 filas sin cantidad de niños y 32 sin cantidad de bebés

# * Técnica utilizada para eliminar o completar los datos faltantes.

# Dado que las familias con niños requieren un poco más de espacio en el cuarto,
# usaremos esa variable para comparar
boxplot(hotel_data$children ~ hotel_data$reserved_room_type, ylim  = c(0,3),
        main = "Tipos de cuartos reservados vs Cantidad de niños",
        xlab = "Tipos de cuarto", ylab="Cantidad de niños")
# en las categorias de cuartos a, d, e, h, l y p no suelen tener niños
# en la categoría H suelen haber 1 niño, y en la categoría F,
# aunque no la mayoría,la distribución se concentra en el 1 niño
# en las categorías C y G, aunque no todos, la mediana se halla en 2 niños
# en la categoria B, la mediana se encuentra en 0 niños
# utilizaremos los datos de la mediana para reemplazar los NA

# Respecto a la cantidad de bebés, no se aprecia una categoría
# que muestre cierta relación con la cantidad de bebés
barplot(table(hotel_data$babies))
# Sin embargo, se aprecia que una mayoría considerable de personas
# no se hospeda con bebés, por lo cual se completarán los datos con 0

# * Identificación de datos atípicos (Outliers).
# En el resumen de la columna se observa el máximo 10, que es un dato
# atípico considerando que la moda es 0,1029 y la mediana, 0
# verificamos si hay datos más cercanos
hotel_data$children[hotel_data$children > 5]
# solo se encuentra ese valor como atípico

hotel_data$babies[hotel_data$babies > 5]
#solo hay 2 datos atípicos: 10 y 9

# * Técnica(s) utilizada(s) para transformar los datos atípicos

# * Visualización de datos
t_infantes <- data.frame( hotel_data[hotel_data$children > 0 | hotel_data$babies > 0,][, c('children','babies')] )
t_infantes_total <- colSums(table(t_infantes)) 
bp_infantes <- barplot( table(t_infantes), xlim = c(0,4), ylim = c(0,10000), las=1,
                        xlab = 'Cantidad de bebes y niños', ylab = 'Frecuencia',
                        main = paste('Cantidad de reservas con niños y/o bebés',nrow(t_infantes)) )
text(x=bp_infantes, y=t_infantes_total, labels=t_infantes_total, pos = 3)
cat(8413+900+15+36+1+1)
