#b- ¿Está aumentando la demanda con el tiempo?

#Ordenamos los meses
month_vector<-factor(hotel_datos$arrival_date_month)
month<-factor(month_vector,levels=c("January","February","March","April","May","June","July","August","September","October","November","December"))
levels(month)<-c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre")

#Visualización de datos
counts = table(hotel_datos$arrival_date_year.comp,month)
table(month,hotel_datos$arrival_date_year)
table(hotel_datos$arrival_date_year.comp)
barplot(counts, main = "", beside = TRUE,  col=c("blue" , "black", "red"), legend = c("2015", "2016", "2017"))

#Como se puede observar la demanda a través del tiempo está aumentado. El año 2017
#presenta menor cantidad de alojamientos porque solo se está contado hasta el mes de julio.
#Si comparamos solo los meses que el 2017 presenta, podemos observar que el 2017 tiene mayor cantidad
#de alojamientos comparado al 2016 en las mismas fechas.Entonces se puede afirmar que hay un aumento de demanda
#con el tiempo. 

