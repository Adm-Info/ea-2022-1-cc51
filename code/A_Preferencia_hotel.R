#a. ¿Cuántas reservas se realizan por tipo de hotel? o ¿Qué tipo de hotel prefiere la gente?
#Cargamos la data
#Como se puede observar en la data obtenida existen 2 tipos de hotel EL city hotel y el resort hotel

#Completamos los datos NA con un valor random
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
     nombre <- paste(nombres[col], "valorado", sep = ".")
     df[nombre] <- rand.valor(df[,col])
     }
   df
}
#ver en que columnas falta data
colSums(is.na(hotel_data))
#limpiar data
data.limpio <- random.df(hotel_data, c(3,4,6,7,8,9,10,11,12,26,33))

#Eliminar datos duplicados
hotel_data.u<-unique(data.limpio)

#Observar datos unicos
counts = table(hotel_data.u$is_canceled, hotel_data.u$ï..hotel)
table(hotel_data.u$ï..hotel,hotel_data.u$is_canceled)
table(hotel_data.u$ï..hotel)
barplot(counts, col=c("blue" , "red"), legend = c("Check-in","Cancelado"), main = "Reserva por tipo de hotel", beside = TRUE)

#datos no unicos
table(data.limpio$ï..hotel,data.limpio$is_canceled)
table(data.limpio$ï..hotel)
#Como se puede observar en en la tabla se han realizado 79330 reservas en los hoteles tipo City de las 
#cuales 46228 son check-in y 33102 Cancelados. En el caso de los Resort Hotel presenta 40060
#reservaciones de las cuales 28938 son check-in y 11122 son cancelaciones.
#A partir de esta data se puede llegar a inferir que el tipo de hotel que las personas prefieren es el
#City Hotel
