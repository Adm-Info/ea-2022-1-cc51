#d ¿Cuándo es menor la demanda de reservas?
hotel_data4 <- read.csv ("data/hotel_bookings_miss.csv", header = TRUE, sep = ",")

#Revisamos datos faltantes
summary(hotel_data4[,c('arrival_date_month')])
#Observamos que no hay datos faltantes.

#volvemos la data unica sin duplicados
data.unique<-unique(hotel_data4)

#Volvemos el mes como factor para poder ordenarlos
month_vector<-factor(data.unique$arrival_date_month)
month<-factor(month_vector,levels=c("January","February","March","April","May","June","July","August","September","October","November","December"))
levels(month)<-c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre")

#vizualizar datos
plot(month,col="darkslategray1",ylab="Cantidad de reservas",xlab="Mes")
table(month)

#Como se puede observar la demanda de reservas es menor entre los meses de noviembre y enero. La demanda de 
#reservas es menos a finales e inicios de años según la data presentada. 