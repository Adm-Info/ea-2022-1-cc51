#c. ¿Cuándo se producen las temporadas de reservas: alta, media y baja?

#Creamos copia del archivo csv
hotel_data3 <- read.csv ("data/hotel_bookings_miss.csv", header = TRUE, sep = ",")

#No hay datos NA en arrival_date_month

#Si la reservacion fue cancelada la volvemos na
hotel_data3$is_canceled[hotel_data3$is_canceled == 1] <- NA

#Borramos las recervaciones canceladas
data.iscancel.limpio <- hotel_data3[!is.na(hotel_data3$is_canceled),]

#Solo obtenemos datos unicos
data.iscancel.limpio<-unique(data.iscancel.limpio)

#Volvemos el mes como factor para poder ordenarlos
month_vector<-factor(data.iscancel.limpio$arrival_date_month)
month<-factor(month_vector,levels=c("January","February","March","April","May","June","July","August","September","October","November","December"))
levels(month)<-c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre")

#vizualizar datos
plot(month,col="darkslategray1",ylab="Cantidad de reservas",xlab="Mes")
table(month)

#Como se puede se puede observa la temporada baja se da en los meses de Noviembre, Diciembre, Enero y Febrero. La temporada media
#se da en Marzo, abril, Mayo y Junio. Por ultimo, la temporada alta se da en JUlio, Agosto, Setiembre y Octubre. 