#   f. ¿Es importante contar con espacios de estacionamiento?

# * Visualización de datos

#identificamos cuántos son los espacios requeridos
length(hotel_datos$required_car_parking_spaces[hotel_datos$required_car_parking_spaces > 0])

#consideramos a la columna de required_car_parking_spaces
#además de las que nos puedan brindar un acumulado diario

install.packages("dplyr")
library(dplyr)

#agrupamos por día para contar la cantidad diaria requerida
nparks.dates <- hotel_datos[,c("arrival_date_year","arrival_date_month", "arrival_date", "required_car_parking_spaces")] %>% 
  group_by(arrival_date, arrival_date_month, arrival_date_year) %>% 
  summarise(n_parkings = sum(required_car_parking_spaces))

boxplot(n_parkings ~ arrival_date_month*arrival_date_year, data = nparks.dates,
        col = c('coral','coral3','coral4','brown4','brown3','brown1'),
        main = "Espacios de estacionamiento diario",
        xlab = "Año y mes", ylab="Espacios de estacionamiento")

table(nparks.dates[,c("arrival_date_month","n_parkings")])
# observamos que por semana comúnmente se solicitan entre 10-12 aparcamientos
# pero no en los últimos meses del 2017
# por lo cual, no se considera importante contar con espacios de estacionamiento,
# o, en todo caso, considerar solo 1 piso para ello