#b- ¿Está aumentando la demanda con el tiempo?

#creamos una copia de la data para modificarla libremente
hotel_data2 <- read.csv ("data/hotel_bookings_miss.csv", header = TRUE, sep = ",")

#Volvemos todos los que han cancelado null
hotel_data2$is_canceled[hotel_data2$is_canceled == 1] <- NA

#Borramos las recervaciones canceladas
data.iscancel.limpio2 <- hotel_data2[!is.na(hotel_data2$is_canceled),]


#Revisamos datos faltantes
summary(data.iscancel.limpio2[,c('arrival_date_year', 'arrival_date_month')])
#Observamos que solo nos queda un dato que tiene arrival_date_year NA.

#Lo remplazamos con un valor aleatorio
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
     nombre <- paste(nombres[col], "comp", sep = ".")
     df[nombre] <- rand.valor(df[,col])
    }
   df
   }
data.iscancel.limpio2<-random.df(data.iscancel.limpio2, c(4))

#volvemos la data unica sin duplicados
data.unique<-unique(data.iscancel.limpio2)

#Ordenamos los meses
month_vector<-factor(data.unique$arrival_date_month)
month<-factor(month_vector,levels=c("January","February","March","April","May","June","July","August","September","October","November","December"))
levels(month)<-c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre")

#Visualización de datos
counts = table(data.unique$arrival_date_year.comp,month)
table(month,data.unique$arrival_date_year.comp)
table(data.unique$arrival_date_year.comp)
barplot(counts, main = "", beside = TRUE,  col=c("blue" , "black", "red"), legend = c("2015", "2016", "2017"))

#Como se puede observar la demanda a través del tiempo está aumentado. El año 2017
#presenta menor cantidad de alojamientos porque solo se está contado hasta el mes de julio.
#Si comparamos solo los meses que el 2017 presenta, podemos observar que el 2017 tiene mayor cantidad
#de alojamientos comparado al 2016 en las mismas fechas.Entonces se puede afirmar que hay un aumento de demanda
#con el tiempo. 

