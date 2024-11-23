# Instalar el paquetes
install.packages("readr")
install.packages("MDPIexploreR")

# Cargar el paquetes
library(readr)
library(MDPIexploreR)

source("C:\\Users\\Marianela Parodi\\Documents\\guest_editor_info_modificado.R")

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

si_2018<-special_issue_find("ijerph",type="closed", years = seq(2018,1));
guest_editor_info_2018<-guest_editor_info(sample(si_2018));
write.csv(guest_editor_info_2018, file = "guest_editor_info_2018.csv", row.names = FALSE)



#-------------------------------------------------------------------------------
#Usando
source("C:\\Users\\Marianela Parodi\\Documents\\guest_editor_info_modificado.R")
#2500-2888
guest_editor_2500al2888<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=2500:2888)
write.csv(guest_editor_2500al2888, file = "guest_editor_1800al2888.csv", row.names = FALSE)

guest_editor_2400al2499<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=2400:2499)
write.csv(guest_editor_2400al2499, file = "guest_editor_2400al2499.csv", row.names = FALSE)

guest_editor_2300al2399<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=2300:2399)
write.csv(guest_editor_2300al2399, file = "guest_editor_2300al2399.csv", row.names = FALSE)

guest_editor_2200al2299<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=2200:2299)
write.csv(guest_editor_2200al2299, file = "guest_editor_2200al2299.csv", row.names = FALSE)

guest_editor_2100al2199<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=2100:2199)
write.csv(guest_editor_2100al2199, file = "guest_editor_2100al2199.csv", row.names = FALSE)

guest_editor_2000al2099<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=2000:2099)
write.csv(guest_editor_2000al2099, file = "guest_editor_2000al2099.csv", row.names = FALSE)

guest_editor_1900al1999<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1900:1999)
write.csv(guest_editor_1900al1999, file = "guest_editor_1900al1999.csv", row.names = FALSE)

guest_editor_1800al1899<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1800:1899)
write.csv(guest_editor_1800al1899, file = "guest_editor_1800al1899.csv", row.names = FALSE)


source("C:\\Users\\Marianela Parodi\\Documents\\guest_editor_info_modificado_manejo_de_errores.R")
guest_editor_1790al1799<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1790:1799)
write.csv(guest_editor_1790al1799, file = "guest_editor_1790al1799.csv", row.names = FALSE)

guest_editor_1780al1789<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1780:1789)
write.csv(guest_editor_1780al1789, file = "guest_editor_1780al1789.csv", row.names = FALSE)

guest_editor_1760al1769<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1760:1769)
write.csv(guest_editor_1760al1769, file = "guest_editor_1760al1769.csv", row.names = FALSE)

guest_editor_1750al1759<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1750:1759)
write.csv(guest_editor_1750al1759, file = "guest_editor_1750al1759.csv", row.names = FALSE)


guest_editor_1740al1749<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1740:1749)
write.csv(guest_editor_1740al1749, file = "guest_editor_1740al1749.csv", row.names = FALSE)

guest_editor_1700al1709<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1700:1709)
write.csv(guest_editor_1700al1709, file = "guest_editor_1700al1709.csv", row.names = FALSE)

guest_editor_1600al1699<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1600:1699)
write.csv(guest_editor_1600al1699, file = "guest_editor_1600al1699.csv", row.names = FALSE)

guest_editor_1500al1599<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1500:1599)
write.csv(guest_editor_1500al1599, file = "guest_editor_1500al1599.csv", row.names = FALSE)

guest_editor_1400al1499<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1400:1499)
write.csv(guest_editor_1400al1499, file = "guest_editor_1400al1499.csv", row.names = FALSE)


# este tira error: Error in open.connection(x, "rb") : Recv failure: Connection was reset
guest_editor_1350al1399<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1350:1399)
write.csv(guest_editor_1350al1399, file = "guest_editor_1350al1399.csv", row.names = FALSE)

source("C:\\Users\\Marianela Parodi\\Documents\\guest_editor_info_modificado_trycatch.R")
guest_editor_1300al1309<-guest_editor_info_modificado_trycatch(la_concha_de_tu_madre,sample=1400:1400)
write.csv(guest_editor_1300al1349, file = "guest_editor_1300al1349.csv", row.names = FALSE)

guest_editor_1350al1399<-guest_editor_info_modificado(la_concha_de_tu_madre,sample=1300:1301)



la_concha_de_tu_madre<-read.csv("C:\\Users\\Marianela Parodi\\Documents\\SI_ijerph_all.csv")

source("C:\\Users\\Marianela Parodi\\Documents\\prueba_editor.R")
prueba_editor(sample(si_2018,5))

source("C:\\Users\\Marianela Parodi\\Documents\\article_info_modificado.R")
article_info_modificado(all_ijerph_articles,sample=1) 

source("C:\\Users\\Marianela Parodi\\Documents\\article_info_2.R")
article_info_2(all_ijerph_articles,sample=5) 

source("C:\\Users\\Marianela Parodi\\Documents\\special_issue_find_modificado.R")
lalala<-special_issue_find("ijerph",type="closed")
write.csv(lalala, file = "SI_ijerph_all.csv", row.names = FALSE)


source("C:\\Users\\Marianela Parodi\\Documents\\guest_editor_info_2.R")
guest_editor_info_all<-guest_editor_info_2(sample(lalala,5))
write.csv(guest_editor_info_all, file = "guest_editor_info_all.csv", row.names = FALSE)

