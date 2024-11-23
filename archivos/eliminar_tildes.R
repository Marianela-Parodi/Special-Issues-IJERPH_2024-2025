# Definir una función para eliminar tildes
eliminar_tildes <- function(texto) {
  # Verificar si hay caracteres acentuados
  if (any(grepl("[áéíóúÁÉÍÓÚ]", texto))) {
    # Usar iconv para eliminar los tildes
    texto <- iconv(texto, from = "UTF-8", to = "ASCII//TRANSLIT")
  }
  return(texto)
}