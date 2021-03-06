#d ¿Cuándo es menor la demanda de reservas?

#Volvemos el mes como factor para poder ordenarlos
month_vector<-factor(data.unique$arrival_date_month)
month<-factor(month_vector,levels=c("January","February","March","April","May","June","July","August","September","October","November","December"))
levels(month)<-c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre")

#vizualizar datos
plot(month,col="blue",ylab="Cantidad de reservas",xlab="Mes", border = NA , main = "Menor cantidad de reservas")
table(month)

#Como se puede observar la demanda de reservas es menor entre los meses de noviembre y enero. 
#La demanda de reservas es menor a finales e inicios de años según la data presentada. El mes con menos demanda es Enero.