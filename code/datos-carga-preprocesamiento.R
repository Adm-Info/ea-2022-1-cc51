#CARGAR DATOS
hotel_data <- read.csv ("data/hotel_bookings_miss.csv", header = TRUE, sep = ",")


#INSPECCIONAR DATOS
#verificamos que los datos estén acorde al tipo de dato
str(hotel_data)

#las columnas is_canceled e is_repeated_guest serán convertidas en factor
hotel_data$is_canceled <- as.factor(hotel_data$is_canceled)
hotel_data$is_repeated_guest <- as.factor(hotel_data$is_repeated_guest)

#la columna reservation_status_date será convertida a date
#verificamos el formato de la fecha es dd/mm/yyyy o mm/dd/yyyy
head(hotel_data$reservation_status_date,50)
#comprobamos que es mm/dd/yyyy
hotel_data$reservation_status_date <- as.Date(hotel_data$reservation_status_date, "%m/%d/%y")

#Concatenaremos las columnas "arrival_date_..." para crear una sola con formato fecha
#verificamos que los meses tienen formato con nombre del mes, por tanto los transformaremos en número



hotel_data$arrival_date <- paste(hotel_data$arrival_date_year,
                                  match(substr( hotel_data$arrival_date_month, 1, 3), month.abb),
                                 hotel_data$arrival_date_day_of_month, sep="-")
hotel_data$arrival_date <- as.Date(hotel_data$arrival_date)
summary(hotel_data$arrival_date)


#volvemos a comprobar la tabla
str(hotel_data)



# DUplicados
#solo usaremos columnas no duplicadas
hotel_datos<-unique(hotel_data)

# Identificación de datos faltantes (NA).
datos_NA <- function(x){
  sum = 0
  cat("Columnas : total de valores NA \n")
  for(i in 1:ncol(x)) {
    #solo aquellas columnas donde falten datos
    n_nas <- colSums(is.na(x[i]))
    if (n_nas > 0) {
      cat(colnames(x[i]),":",n_nas,"\n")
    }
  }
}

datos_NA(hotel_datos)

#Columnas : total de valores NA 
#lead_time : 21 
#arrival_date_year : 6 
#arrival_date_week_number : 25 
#arrival_date_day_of_month : 7 
#stays_in_weekend_nights : 25 
#stays_in_week_nights : 12 
#adults : 12 
#children : 4 
#babies : 32 
#days_in_waiting_list : 7
#arrival_date : 13 < es la cantidad de días NA y meses NA


#Identificamos datos en blanco
en_blanco <- function(x){
  sum = 0
  cat("Columnas : total de valores en blanco \n")
  for(i in 1:ncol(x))
  {
    n_blanks = colSums(x[i]=="")
    if (n_blanks > 0 | is.na(n_blanks)) {
      cat(colnames(x[i]),":",n_blanks,"\n")
    }
  }
}
en_blanco(hotel_datos)
#no hay


# Técnica utilizada para eliminar o completar los datos faltantes.

#Ingresar datos aleatorios a las columnas lead_time, arrival_date_year, arrival_date_day_of_month
rand.valor <- function(x){
  faltantes <- is.na(x)
  tot.faltantes <- sum(faltantes)
  x.obs <- x[!faltantes]
  valorado <- x
  valorado[faltantes] <- sample(x.obs, tot.faltantes, replace = TRUE)
  return (valorado)
}
random.df <- function(df, cols){
  nombres <- names(df)
  for (col in cols) {
    df[nombres[col]] <- rand.valor(df[,col])
  }
  df
}
hotel_datos<-random.df(hotel_datos, c(3, 4, 7))

# Completar datos de children
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
hotel_datos[is.na(hotel_datos$children),'children'] <- sample(c(0,1), replace=TRUE, size=4)
hotel_datos[empty_children_rows,c('reserved_room_type','children')]
# Respecto a la cantidad de bebés, no se aprecia una categoría
# que muestre cierta relación con la cantidad de bebés

# Completar datos de babies
barplot(table(hotel_datos$babies))
empty_babies_rows <- as.integer(rownames(hotel_datos[is.na(hotel_datos$babies),]))
# Sin embargo, se aprecia que una mayoría considerable de personas
# no se hospeda con bebés, por lo cual se completarán los datos con 0
hotel_datos[is.na(hotel_datos$babies),'babies'] <- 0
hotel_datos[empty_babies_rows,c('reserved_room_type','babies')]

# Completar datos de adultos
#verificamos datos atipicos de los adultos
boxplot(x = hotel_datos$adults)
table(hotel_datos$adults)
#Creamos la funcion de la moda
calc_mode <- function(x){
  distinct_tabulate <- tabulate(match(x, distinct_values))
  # Return the value with the highest occurrence
  distinct_values[which.max(distinct_tabulate)]
}


# Completar datos de arrival_date_week_number
# arrival_date_week_number : 25 
empty_weeks.nums <- as.integer(rownames(hotel_datos[is.na(hotel_datos$arrival_date_week_number), ]))
hotel_datos[empty_weeks.nums,c('arrival_date', 'arrival_date_week_number')]
empty_weeks.days <- as.POSIXlt(hotel_datos$arrival_date[empty_weeks.nums])
empty_weeks.weeks <- (empty_weeks.days$yday) %/%7 +1
hotel_datos$arrival_date_week_number[is.na(hotel_datos$arrival_date_week_number)] = empty_weeks.weeks








# * Identificación de datos atípicos (Outliers).
# * Técnica(s) utilizada(s) para transformar los datos atípicos

# En el resumen de la columna de Children se observa el máximo 10, que es un dato
# atípico considerando que la moda es 0,1029 y la mediana, 0
outline_children_rows <- as.integer(rownames(hotel_datos[hotel_datos$children > 5,]))
hotel_datos[outline_children_rows,c('reserved_room_type','children')]
# Como en la D no suele haber niños, se colocará 0
hotel_datos[hotel_datos$children > 5,'children'] <- 0
hotel_datos[outline_children_rows,c('reserved_room_type','children')]

# En bebes solo hay 2 datos atípicos: 10 y 9
outline_babies_rows <- as.integer(rownames(hotel_datos[hotel_datos$babies >= 9,]))
hotel_datos[outline_babies_rows,'babies'] <- 0
hotel_datos[outline_babies_rows,c('reserved_room_type','babies')]



