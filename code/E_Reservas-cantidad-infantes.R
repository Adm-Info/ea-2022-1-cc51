
# e. ¿Cuántas reservas incluyen niños y/o bebes?

# * Visualización de datos
t_infantes <- data.frame( hotel_datos[hotel_datos$children > 0 | hotel_datos$babies > 0,][, c('children','babies')] )
t_infantes_total <- colSums(table(t_infantes)) 
bp_infantes <- barplot( table(t_infantes), xlim = c(0,4), ylim = c(0,10000), las=1,
                        xlab = 'Cantidad de bebes y niños', ylab = 'Frecuencia',
                        main = 'Cantidad de reservas con niños y/o bebés' ) 
text(x=bp_infantes, y=t_infantes_total, labels=t_infantes_total, pos = 3)
