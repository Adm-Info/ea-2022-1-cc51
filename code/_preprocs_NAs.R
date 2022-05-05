# IDENTIFICACIÓN DE DATOS FALTANTES (NA).
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


# TÉCNICAS UTILIZADAS PARA ELIMINAR O COMPLETAR LOS DATOS FALTANTES.


# COLUMNAS: lead_time, arrival_date_year, arrival_date_day_of_month :
#Ingresar datos aleatorios
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
# usaremos datos aleatorios para estas columnas
hotel_datos<-random.df(hotel_datos, c(3, 4, 7, 26))


# CHILDREN:
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
empty_children_rows <- rownames(hotel_datos[is.na(hotel_datos$children),])
# son 4 filas: 40601 40668 40680 41161
# se observa que todos tienen reserved_room_type B, en los cuales la cantidad de niños
# varía entre 0, 1 y 2
hotel_datos[is.na(hotel_datos$children),'children'] <- sample(c(0,1), replace=TRUE, size=4)
hotel_datos[empty_children_rows,c('reserved_room_type','children')]
# Respecto a la cantidad de bebés, no se aprecia una categoría
# que muestre cierta relación con la cantidad de bebés


# BABIES:
barplot(table(hotel_datos$babies))
empty_babies_rows <- rownames(hotel_datos[is.na(hotel_datos$babies),])
# Sin embargo, se aprecia que una mayoría considerable de personas
# no se hospeda con bebés, por lo cual se completarán los datos con 0
hotel_datos[is.na(hotel_datos$babies),'babies'] <- 0
hotel_datos[empty_babies_rows,c('reserved_room_type','babies')]


# arrival_date_week_number (25)
empty_weeks.nums <- rownames(hotel_datos[is.na(hotel_datos$arrival_date_week_number), ])
hotel_datos[empty_weeks.nums,c('arrival_date', 'arrival_date_week_number')]
empty_weeks.days <- as.POSIXlt(hotel_datos[empty_weeks.nums,'arrival_date'])
empty_weeks.weeks <- (empty_weeks.days$yday) %/%7 +1
hotel_datos$arrival_date_week_number[is.na(hotel_datos$arrival_date_week_number)] = empty_weeks.weeks
hotel_datos[empty_weeks.nums,c('arrival_date', 'arrival_date_week_number')]
#https://stackoverflow.com/questions/22439540/how-to-get-week-numbers-from-dates


# stays_in_weekend_nights (25)
empty_stays.weekends.nums <- row.names(hotel_datos[is.na(hotel_datos$stays_in_weekend_nights), ])
hotel_datos[empty_stays.weekends.nums,c('arrival_date', 'stays_in_weekend_nights', 'stays_in_week_nights')]
#verificamos que el arrival date no sea un fin de semana
empty_stays.weekends.arrday <- weekdays(hotel_datos[empty_stays.weekends.nums,'arrival_date'])
#https://www.rdocumentation.org/packages/lubridate/versions/0.1/topics/wday
empty_stays.weekends.fill <- function () {
  new_weekends = c()
  for (i in 1:length(empty_stays.weekends.nums)) {
    ind = as.integer(empty_stays.weekends.nums[i])
    left_days = switch (
      empty_stays.weekends.arrday[i],
      'Monday' = 5,
      'Tuesday' = 4,
      'Wednesday' = 3,
      'Thursday' = 2,
      'Friday' = 1,
      0
    )
    num_w_days =  0
    #Si arribo un lunes y permanecio 5 dias, no llegó a weekend
    #Si arribo un martes y permanecio 4 dias, no llegó a weekend, ...
    if (hotel_datos$stays_in_week_nights[ind] == 0){
      if (empty_stays.weekends.arrday[i] == 'Saturday') {
        num_w_days = sample(c(0,1,2),replace = TRUE, size=1)
      }
      else if (empty_stays.weekends.arrday[i] == 'Sunday') {
        num_w_days = 1
      }
      else {
        num_w_days = 0
      }
    } else if (hotel_datos$stays_in_week_nights[ind] < left_days) {
      num_w_days = 0
    } else {
      #Si arribo un lunes (5) y permanecio 8 dias, llegó a 1 weekend
      #Si arribo un lunes (5) y permanecio 10 dias, llegó a 2 weekend
      num_w_days = (hotel_datos$stays_in_week_nights[ind]%/%5)*2
    }
    new_weekends <- append(new_weekends,num_w_days)
  }
  return(new_weekends)
}
hotel_datos$stays_in_weekend_nights[is.na(hotel_datos$stays_in_weekend_nights)] <- empty_stays.weekends.fill()
hotel_datos[empty_stays.weekends.nums,c('arrival_date', 'stays_in_weekend_nights', 'stays_in_week_nights')]


# stays_in_week_nights (12)
empty_stays.weeks.nums <- row.names(hotel_datos[is.na(hotel_datos$stays_in_week_nights), ])
hotel_datos[empty_stays.weeks.nums,c('arrival_date', 'stays_in_weekend_nights', 'stays_in_week_nights')]
#verificamos que el arrival date no sea un fin de semana
empty_stays.weeks.weekends <- hotel_datos[empty_stays.weeks.nums,'stays_in_weekend_nights']
empty_stays.weeks.arrday <- weekdays(hotel_datos[empty_stays.weeks.nums,'arrival_date'])
empty_stays.weeks.fill <- function () {
  new_weeks = c()
  for (i in 1:length(empty_stays.weeks.nums)) {
    ind = as.integer(empty_stays.weeks.nums[i])
    cat(i,"a",ind,'\n')
    num_w_days =  0
    left_days = switch (
      empty_stays.weeks.arrday[i],
      'Monday' = 5,
      'Tuesday' = 4,
      'Wednesday' = 3,
      'Thursday' = 2,
      'Friday' = 1,
      1
    )
    #Si arribo un lunes y weekend=0, puede ser random de 0-5
    #Si arribo un martes y weekend=0, puede ser random de 0-4
    num_w_days = sample(0:left_days,replace = TRUE, size=1)
    if (empty_stays.weeks.weekends[i] > 0){
      cat('_',empty_stays.weeks.weekends[i],'\n')
      #si llegó lunes y weekend=1 o 2 => 5 + rand
      #si llegó martes y weekend=1 o 2 => 4 + rand
      #si llegó lunes y weekend=3 o 4 => 5*2 + rand
      if (empty_stays.weeks.weekends[i] %% 2) {
        num_ws = (empty_stays.weeks.weekends[i]%/%2)
      } else {
        num_ws = ((empty_stays.weeks.weekends[i]+1)%/%2)
      }
      num_w_days = num_w_days + (num_ws*5)
    }
    new_weeks <- append(new_weeks,num_w_days)
  }
  return(new_weeks)
}
empty_stays.weeks.fill()
hotel_datos$stays_in_week_nights[is.na(hotel_datos$stays_in_week_nights)] <- empty_stays.weeks.fill()
hotel_datos[empty_stays.weeks.nums,c('arrival_date', 'stays_in_weekend_nights', 'stays_in_week_nights')]


# ARRIVAL_DATE
# volvemos a completar los datos de esta columna calculada
hotel_datos$arrival_date <- paste(hotel_datos$arrival_date_year,
                                  match(substr( hotel_datos$arrival_date_month, 1, 3), month.abb),
                                  hotel_datos$arrival_date_day_of_month, sep="-")
hotel_datos$arrival_date <- as.Date(hotel_datos$arrival_date)
summary(hotel_datos$arrival_date)
