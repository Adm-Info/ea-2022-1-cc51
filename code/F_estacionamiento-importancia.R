#   f. ¿Es importante contar con espacios de estacionamiento?

# * Visualización de datos

#identificamos cuántos son los espacios requeridos
length(hotel_datos$required_car_parking_spaces[hotel_datos$required_car_parking_spaces > 0])

#consideramos a la columna de required_car_parking_spaces
#además de las que nos puedan brindar un acumulado semanal

# crearemos una columna de añosemana (yearweek)
hotel_datos$arrival_date_year_week = hotel_datos$arrival_date_year * 100 + hotel_datos$arrival_date_week_number
summary(hotel_datos[c("required_car_parking_spaces", "arrival_date_year_week")])

install.packages("dplyr")
library(dplyr)

#agrupamos por día para contar la cantidad diaria requerida
t_date_nps <- hotel_datos[,c("arrival_date_year_week", "arrival_date", "required_car_parking_spaces")] %>% 
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