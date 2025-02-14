# Special-Issues-IJERPH_2024-2025

Extracción de información a través de la técnica de web scraping de los editores invitados de los números especiales publicados en la revista IJERPH de MDPI.

## Ejecución
Ir a main_guest_editors.Rmd 

### Funciones utilizadas
Se utilizan funciones pertenecientes al paquete MDPIExplorer [1]. 

Principales funciones utilizadas:

- special_issue_find.R:

Sintaxis: special_issue_find("nombre_revista",type, years); type: open or closed 

Descripción: Obtiene los special issue (abiertos o cerrados según type) de una revista en el periodo especificado en years. 

- guest_editor_info_nuevo.R: Versión modoficada (Nov. 2024) de la función original guest_editor_info.R

Sintaxis: guest_editor_info(sample(si,5))

Descripción: Obtiene información sobre los editores invitados de los special issues. La versión utilizada agrega a la información brindada por guest_editor_info.R los nombres de los editores invitados.

También se utilizan funciones auxiliares necesarias para el correcto funcionamiento de las funciones anteriores:

- clean_names.R y eliminar_tildes.R para mejor manipulación de los nombres.

Referencias
[1] Gómez Barreiro P (2024). MDPIexploreR: Web Scraping and Bibliometric Analysis of MDPI Journals. R package version 0.2.1, https://github.com/pgomba/MDPI_exploreR.
