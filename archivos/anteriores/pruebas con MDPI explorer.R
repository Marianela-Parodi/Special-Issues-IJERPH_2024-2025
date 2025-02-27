

# Instalar el paquetes
install.packages("readr")
install.packages("MDPIexploreR")

# Cargar el paquetes
library(readr)
library(MDPIexploreR)

#-------------------------------------------------------------------------------
#MDPI
MDPI_journals()

#IJERPH
# cargo todos los artículos de IJERPH
all_ijerph_articles<-article_find("ijerph")
write.csv(all_ijerph_articles, file = "all_ijerph_articles.csv", row.names = FALSE)

# saco la información para cada artículo
article_info_ijerph_5<-article_info_modificado(all_ijerph_articles, sample=5)
write.csv(article_info_ijerph_todos, file = "article_info_ijerph_todos.csv", row.names = FALSE)

datos_ijerph <- read_csv("article_info_ijerph_todos.csv");
plot_articles(datos_ijerph,journal = "ijerph", type = "summary" )
plot_articles(datos_ijerph,journal = "ijerph", type = "type" )
plot_articles(datos_ijerph,journal = "ijerph", type = "issues" )





#-------------------------------------------------------------------------------
