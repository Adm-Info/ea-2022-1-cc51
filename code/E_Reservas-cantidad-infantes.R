
# e. ¿Cuántas reservas incluyen niños y/o bebes?

# * Visualización de datos
mat <- matrix(c(1, 2,  # Primero, segundo
                3, 3), # y tercer gráfico
              nrow = 2, ncol = 2,
              byrow = TRUE)
layout(mat = mat)

# Solo niños
infantes.children.table <- table(data.frame(hotel_datos[hotel_datos$children > 0,]['children']))
infantes.children.bp <- barplot( infantes.children.table,
                        xlim = c(0,4), ylim = c(0,5500), las=1, border=NA,
                        col = c('deepskyblue', 'mediumturquoise', 'lightblue4'),
                        xlab = 'Cantidad de niños', ylab = 'Frecuencia',
                        main = 'Cantidad de reservas con niños' ) 
text(x=infantes.children.bp, y=infantes.children.table, labels=infantes.children.table, pos = 3)
text(x=2.5, y=max(infantes.children.table)+500, labels=paste("Total:",sum(infantes.children.table))) 

# solo bebés
infantes.babies.table <- table(data.frame(hotel_datos[hotel_datos$babies > 0,]['babies']))
infantes.babies.bp <- barplot( infantes.babies.table,
                                 xlim = c(0,3), ylim = c(0,1100), las=1, border=NA,
                               col = c('deepskyblue', 'mediumturquoise', 'lightblue4'),
                                 xlab = 'Cantidad de bebés', ylab = 'Frecuencia',
                                 main = 'Cantidad de reservas con bebés' ) 
text(x=infantes.babies.bp, y=infantes.babies.table, labels=infantes.babies.table, pos = 3)
text(x=2.5, y=max(infantes.babies.table)+100, labels=paste("Total:",sum(infantes.babies.table))) 

# Considerando ambos
infantes.df <- data.frame( hotel_datos[hotel_datos$children > 0 | hotel_datos$babies > 0,][, c('children','babies')] )
infantes.table <- table(infantes.df)
infantes.table
infantes.totals <- colSums(infantes.table)
infantes.bp <- barplot( infantes.table, xlim = c(0,4), ylim = c(0,9500), las=1,border=NA,
                        col = c('deepskyblue', 'mediumturquoise', 'lightblue4'),
                        xlab = 'Cantidad de niños y bebés', ylab = 'Frecuencia',
                        main = 'Cantidad de reservas con niños y/o bebés' ) 
text(x=infantes.bp, y=infantes.totals, labels=infantes.totals, pos = 3)
text(x=2.5, y=max(infantes.totals)+100, labels=paste("Total:",sum(infantes.table))) 

# reestablecemos el layout
layout(mat = c(1,1))