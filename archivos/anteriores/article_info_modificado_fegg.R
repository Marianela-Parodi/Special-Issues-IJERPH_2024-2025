article_info_modificado_fegg <- function(vector, sleep = 2, sample_size, show_progress = TRUE) {

  # Si 'sample_size' no está proporcionado, usar todos los elementos del vector
  if (missing(sample_size)) {
    sample_size <- 1:length(vector)  # Usar todos los índices si 'sample_size' no está especificado
  }
  
  # Si 'sample_size' es un único número, convertirlo a un vector
  if(length(sample_size) == 1) {
    sample_size <- 1:sample_size
  }
  
  # Verificar si vector es un vector de URLs o un data.frame
  if (is.data.frame(vector)) {
    papers <- vector[sample_size, ]  # Seleccionar filas de un data.frame
  } else {
    papers <- vector[sample_size]  # Si es un vector de URLs, seleccionar directamente
  }
  
  if (show_progress) {
    pb <- txtProgressBar(min = 0, max = length(papers), initial = 0, style = 3)  # Barra de progreso
  }
  
  count <- 0
  paper_data <- data.frame()  # Data frame vacío
  paper_data_clean <- data.frame()  # Data frame vacío
  # Iterar sobre los artículos seleccionados
  for (i in papers) {
    
    tryCatch(expr = {
      paper <- read_html(i)
      
      # Obtener los tiempos de publicación, aceptación y recepción
      ex_paper <- paper %>%
        html_nodes(".pubhistory span") %>%
        html_text2()
      
      fecha_publicacion <- ex_paper[grepl("Published:", ex_paper)]
      fecha_recepcion <- ex_paper[grepl("submission recived:", ex_paper)]
      fecha_aceptacion <- ex_paper[grepl("Accepted:", ex_paper)]
      
      fecha_date <- dmy(fecha_publicacion)  # Convertir la fecha de publicación
      anio_num <- as.numeric(format(fecha_date, "%Y"))  # Obtener el año de la publicación
      
      # Obtener tipo de artículo y otras categorías
      ex_paper2 <- paper %>%
        html_nodes(".belongsTo") %>%
        html_text2()
      
      article_type <- paper %>%
        html_nodes(".articletype") %>%
        html_text2()
      
      # Si no se encuentra la información, asignar valores predeterminados
      if (identical(ex_paper, character(0))) {
        ex_paper <- "no"
      }
      if (identical(ex_paper2, character(0))) {
        ex_paper2 <- "no"
      }
      if (identical(article_type, character(0))) {
        article_type <- "no"
      }
      
      # Crear un data frame temporal con la información del artículo, ahora incluyendo 'anio_num'
      temp_df <- data.frame(i, ex_paper[1], ex_paper[2], ex_paper[3], ex_paper2, article_type, anio_num)  # Asegúrate de agregar 'anio_num'
      
      # Agregar la información al data frame principal
      paper_data <- bind_rows(paper_data, temp_df)
    
      
    }, error = function(e) {
      # En caso de error, asignar valores predeterminados
      ex_paper <<- "error"
      ex_paper2 <<- "error"
      article_type <<- "error"
    })
    
    count <- count + 1
    Sys.sleep(sleep)
    
    if (show_progress) {
      setTxtProgressBar(pb, count)
    }
  }
  
  # Eliminar filas duplicadas antes de las transformaciones
# Asegurarse de que 'paper_data' es el dataframe original
# Asegúrate de que 'paper_data' es el dataframe original

# Aplicamos el mutate y extraemos las fechas de acuerdo con las reglas dadas
# Aplicamos el mutate y extraemos las fechas con ajustes en las expresiones regulares

paper_data %>%
  mutate(
    # Extraer la fecha de "Published"
    published_date = str_extract(ex_paper, "(?i)Published[:space:]*[:alpha:]+[:space:]*[0-9]{1,2}[:space:]*[A-Za-z]+[:space:]*[0-9]{4}") %>%
      str_extract("([0-9]{1,2} [A-Za-z]+ [0-9]{4})"),
    
    # Extraer la fecha de "Submission received"
    received_date = str_extract(ex_paper, "(?i)Submission received[:space:]*[:alpha:]+[:space:]*[0-9]{1,2}[:space:]*[A-Za-z]+[:space:]*[0-9]{4}") %>%
      str_extract("([0-9]{1,2} [A-Za-z]+ [0-9]{4})"),
    
    # Extraer la fecha de "Accepted"
    accepted_date = str_extract(ex_paper, "(?i)Accepted[:space:]*[:alpha:]+[:space:]*[0-9]{1,2}[:space:]*[A-Za-z]+[:space:]*[0-9]{4}") %>%
      str_extract("([0-9]{1,2} [A-Za-z]+ [0-9]{4})")
  ) %>%
  print()  # Ver todo el dataframe para confirmar las fechas extraídas
return(paper_data)

}