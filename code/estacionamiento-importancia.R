#   f. ¿Es importante contar con espacios de estacionamiento?

#consideramos a la columna de required_car_parking_spaces
#además de las que nos puedan brindar un acumulado semanal

# crearemos una columna de añosemana (yearweek)
hotel_data$arrival_date_year_week = hotel_data$arrival_date_year * 100 + hotel_data$arrival_date_week_number
summary(hotel_data[c("required_car_parking_spaces", "arrival_date_year_week")])

# * Identificación de datos faltantes (NA).
# existen 31 año_semana sin fecha

# * Técnica utilizada para eliminar o completar los datos faltantes.


# * Identificación de datos atípicos (Outliers).
boxplot(x = hotel_data$required_car_parking_spaces)
table(hotel_data$required_car_parking_spaces)
#  0      1      2      3      8 
#111974   7383     28      3      2 
# se observa que como datos atípicos aquellos que son superiores a 1 (parking spaces)

boxplot(hotel_data$arrival_date_year_week)
# no existen datos anómlaos en arrival_date_year_week


# * Técnica(s) utilizada(s) para transformar los datos atípicos

# * Visualización de datos

#identificamos cuántos son los espacios requeridos
length(hotel_data$required_car_parking_spaces[hotel_data$required_car_parking_spaces > 0])

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
# por lo cual, no se considera importante contar con espacios de estacionamiento,
# o, en todo caso, considerar solo 1 piso para ello