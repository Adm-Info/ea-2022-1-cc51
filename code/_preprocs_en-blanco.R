# IDENTIFICACIÓN DE DATOS EN BLANCO
en_blanco <- function(x){
  sum = 0
  cat("Columnas : total de valores en blanco \n")
  for(i in 1:ncol(x))
  {
    n_blanks = colSums(x[i]=="")
    if (n_blanks > 0 | is.na(n_blanks)) {
      cat(colnames(x[i]),":",n_blanks,"\n")
    }
  }
}
en_blanco(hotel_datos)
#no hay
