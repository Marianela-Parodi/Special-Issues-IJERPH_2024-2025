library(rvest)

# Función para leer HTML con manejo de errores
read_html_with_retry <- function(url, retries = 3) {
  for (i in 1:retries) {
    tryCatch({
      return(read_html(url))
    }, error = function(e) {
      if (i == retries) {
        stop("Failed to read from URL after several attempts: ", url)
      }
      Sys.sleep(2)  # Esperar antes de reintentar
    })
  }
}