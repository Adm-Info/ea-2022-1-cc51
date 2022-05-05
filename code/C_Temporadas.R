#c. ¿Cuándo se producen las temporadas de reservas: alta, media y baja?

#Volvemos el mes como factor para poder ordenarlos
month_vector<-factor(hotel_datos_final$arrival_date_month)
month<-factor(month_vector,levels=c("January","February","March","April","May","June","July","August","September","October","November","December"))
levels(month)<-c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre")

#vizualizar datos
plot(month,col="darkslategray1",ylab="Cantidad de reservas",xlab="Mes")
table(month)


#Se puede observar que la temporada baja se da en los meses de Setiembre, Octubre, Noviembre y Diciembre.
#La temporada media se da en Enero, Febrero, Marzo y abril. 
#Por último, la temporada alta se da en Mayo, Junio, JUlio y  Agosto.