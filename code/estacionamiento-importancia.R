#   f. ¿Es importante contar con espacios de estacionamiento?

#consideramos a la columna de required_car_parking_spaces
#además de las que nos puedan brindar un acumulado semanal

# crearemos una columna de añosemana (yearweek)
hotel_data$arrival_date_year_week = hotel_data$arrival_date_year * 100 + hotel_data$arrival_date_week_number
summary(hotel_data[c("required_car_parking_spaces", "arrival_date_year_week")])
summary(hotel_data$adr)#?

# * Identificación de datos faltantes (NA).
# existen 31 año_semana sin fecha

# * Técnica utilizada para eliminar o completar los datos faltantes.


# * Identificación de datos atípicos (Outliers).
boxplot(x = hotel_data$required_car_parking_spaces)
table(hotel_data$required_car_parking_spaces)
#  0      1      2      3      8 
#111974   7383     28      3      2 
# se observa que como datos atípicos aquellos que son superiores a 1 (parking spaces)

# analizaremos la siguiete columna de importancia: adr
boxplot(hotel_data$adr)
summary(hotel_data$adr)
length(hotel_data$adr[hotel_data$adr>4000])
# consideramos como datos atípicos el minimo que es es -6.38, ya que no tiene sentido
# porque refiere a la tarifa diaria promedio, por lo que no puede ser negativa
# además del máximo 5400, que supera en gran medida el rango de error observable
boxplot(hotel_data$adr[hotel_data$adr<4000 & hotel_data$adr>0])
summary(hotel_data$adr[hotel_data$adr<4000 & hotel_data$adr>0])
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.26   70.53   95.00  103.49  126.00  510.00

# se observa que como datos atípicos aquellos que son superiores a 1 (parking spaces)
boxplot(hotel_data$arrival_date_year_week)

# no existen datos anómlaos en arrival_date_year_week


# * Técnica(s) utilizada(s) para transformar los datos atípicos

# * Visualización de datos

#identificamos cuántos son los espacios requeridos
length(hotel_data$required_car_parking_spaces[hotel_data$required_car_parking_spaces > 0])
#de los 119 390 registros, solo 7 416 han requerido aparcamiento

#comparamos el número de parquins requeridos vs la tarifa pagada
t_adr_nps <- data.frame( hotel_data[hotel_data$required_car_parking_spaces > 0 
                                    & hotel_data$required_car_parking_spaces < 4000,][, c('required_car_parking_spaces','adr')] )
plot(t_adr_nps$required_car_parking_spaces~t_adr_nps$adr, xlab="ADR", ylab="# aparcamientos requeridos")
#observamos que aquellos que pagan por aparcamiento son, principalmente,
# quienes pagan entre 0 a 400 por día
# y ocasionalmente quienes pagan entre 40 a 290 aprox. requieren de 2 parqueos

#sin embargo, dado que las personas estacionan sus carros en diferentes tiempos, también lo analizaremos

install.packages("dplyr")
library(dplyr)

#agrupamos por día para contar la cantidad diaria requerida
t_date_nps <- hotel_data[,c("arrival_date_year_week", "arrival_date", "required_car_parking_spaces")] %>% 
  group_by(arrival_date, arrival_date_year_week) %>% 
  summarise(n_parkings = sum(required_car_parking_spaces))
#agrupamos por semana para calcular el promedio por semana
t_week_nps <- t_date_nps[,c("arrival_date_year_week", "n_parkings")] %>% 
  group_by(arrival_date_year_week) %>% 
  summarise(n_parkings = mean(n_parkings))

boxplot(t_week_nps$n_parkings)
summary(t_week_nps)
# observamos que por semana comúnmente se solicitan entre 6 a 8 aparcamientos
# por lo cual, no se considera importante contar con espacios de estacionamiento