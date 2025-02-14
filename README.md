# Special-Issues-IJERPH_2024-2025

El objetivo principal de este proyecto es recopilar información sobre los editores invitados (*guest editors*) de los números especiales (*special issues (SIs)*) de la revista *International Journal of Environmental Research and Public Health (IJERPH)* de MDPI. 

## Descripción

Este repositorio contiene el código y los resultados del web scraping realizado para extraer información sobre los editores invitados de los SIs de *IJERPH*. Para tal propósito se utiliza principalmente el paquete MDPIExplorer (Gómez Barreiro P, 2024). 

## Contenido

*   `main_guest_editors.Rmd`: Script principal en R Markdown que ejecuta el proceso de web scraping.

## Ejecución

1.  Abrir el archivo `main_guest_editors.Rmd`.
2.  Instalar los paquetes necesarios, incluyendo `MDPIexploreR`.
3.  Ejecutar el script para realizar el web scraping y obtener la información sobre los editores invitados de los SIs.

## Funciones Utilizadas

Se utilizan funciones del paquete [`MDPIexploreR`](https://github.com/pgomba/MDPI_exploreR) versión 0.2.1, desarrollado por Gómez Barreiro P (2024). Las principales funcionalidades del `MDPIexploreR` se describen detalladamente en: https://pgomba.github.io/MDPI_explorer/articles/introduction_MDPIexploreR.html

Las funciones principales son:

*   `special_issue_find.R`:
    *   **Sintaxis:** `special_issue_find("nombre_revista", type, years)`
    *   **Descripción:** Obtiene los números especiales (abiertos o cerrados según el parámetro `type`) de una revista en el periodo especificado en `years`.
    *   **Ejemplo:** `special_issue_find("ijerph", "open", c(2024, 2025))`
*   `guest_editor_info_nuevo.R`: (Versión modificada Nov. 2024 de `guest_editor_info.R`)
    *   **Sintaxis:** `guest_editor_info(sample(si, 5))`
    *   **Descripción:** Extrae información sobre los editores invitados de los números especiales. Esta versión modificada agrega los nombres de los editores invitados a la información obtenida por la función original.

Además, se incluyen funciones auxiliares para mejorar el procesamiento de los datos:

*   `clean_names.R`: Limpia y formatea los nombres para una mejor manipulación.
*   `eliminar_tildes.R`: Elimina las tildes de los nombres para facilitar la búsqueda y comparación.


## Dependencias

*   R (versión 4.0 o superior)
*   Paquete `MDPIexploreR` (versión 0.2.1): [https://github.com/pgomba/MDPI_exploreR](https://github.com/pgomba/MDPI_exploreR) (Gómez Barreiro P, 2024)
*   Otros paquetes necesarios para el web scraping (ej. `rvest`, `dplyr`, `stringr`, etc.).

## Instalación de Dependencias

*   Para instalar el paquete `MDPIexploreR` ver: https://github.com/pgomba/MDPI_explorer/blob/main/README.md#installation
*   Para instalar el resto de las dependencias, usar `install.packages()`. 

## Contacto

Marianela Parodi
parodi.marianela@gmail.com

https://www.linkedin.com/in/marianela-parodi-734657a7/
https://scholar.google.com/citations?hl=es&user=3eyZMLwAAAAJ
https://orcid.org/0000-0002-9099-0954

## Referencias

Gómez Barreiro, P. (2024). MDPIexploreR: Web Scraping and Bibliometric Analysis of MDPI Journals. R package version 0.2.1, https://github.com/pgomba/MDPI_exploreR.


