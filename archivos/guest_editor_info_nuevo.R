#' Obtain information from guest edited special issues
#'
#'@description#' 
#' Extracts data from special issues, including guest editors' paper counts excluding editorials, time between last submission and issue closure, and whether guest editors served as academic editors for any published papers.
#' 
#' @param journal_urls A list of MDPI special issues URLs
#' @param sample_size A number. How many special issues do you want to explore from the main vector. Leave blank for all
#' @param show_progress Logical. If `TRUE`, a progress bar is displayed during the function execution. Defaults to `TRUE`.
#' @param sleep Number of seconds between scraping iterations. 2 sec. by default
#' @import magrittr rvest dplyr 
#' @export guest_editor_info
#' @return A data frame (class: \code{data.frame}) with the following columns:
#' \describe{
#'   \item{special_issue}{The URL of the special issue from which the information is retrieved.}
#'   \item{num_papers}{Number of special issues contained in the special issue, not considering editorial type articles}
#'   \item{flags}{Number of articles in the special issue with guest editorial pressence}
#'   \item{prop_flag}{Proportion of articles in the special issue in which a guest editor is present}
#'   \item{deadline}{Time at which the special issue was or will be closed}
#'   \item{latest_sub}{Time at which last article present in the special issue was submitted}
#'   \item{rt_sum_vector2}{Numeric vector showing number of articles in which each individual guest editor is present}
#'   \item{aca_flag}{Number of articles in the special issue where the academic editor is a guest editor too}
#'   \item{d_over_deadline}{Day differential between special issue closure and latest article submission}
#' }
#' @examples
#' \donttest{
#' ge_issue<-"https://www.mdpi.com/journal/plants/special_issues/5F5L5569XN"
#' ge_info<-guest_editor_info(ge_issue)
#' }


guest_editor_info_nuevo <- function(journal_urls, sample_size, sleep=2,show_progress=TRUE) {
 install.packages("rvest")
  library(rvest)
  install.packages("dplyr")
  library(dplyr)
  install.packages("stringr")
  library(stringr)  
  



  if (missing(sample_size)) {
    sample_size=length(journal_urls)
  }else{
    sample_size=sample_size
  }
  
 urls<-journal_urls[sample_size,1]
  
  special_issues_table<-data.frame(special_issue=character(),
                                   num_papers=double(),
                                   flags=numeric(),
                                   prop_flag=double(),
                                   stringsAsFactors=FALSE)
  
  if (show_progress) {
  pb <- txtProgressBar(min = 0, max = length(urls), initial = 0,style=3) #Build progress bar
  count<-0
  }
  
  for (i in urls) {
    
    data<-read_html_with_retry(paste0(i,"#editors"))

    # Extraer el texto relacionado con las fechas de deadline
    texto_deadline <- data %>%
      html_nodes("div") %>%  # Selecciona todos los <div>
      html_text()            # Extrae el texto
    
    # Filtrar la línea que contiene "Deadline for manuscript submissions"
    deadline_line <- texto_deadline[grepl("Deadline for manuscript submissions", texto_deadline)]
    
    # Verificar si se encontró la línea
    if (length(deadline_line) > 0) {
      # Extraer la fecha usando una expresión regular
      fecha_deadline <- str_extract(deadline_line, "\\d{1,2} \\w+ \\d{4}")  # Extrae solo la fecha sin paréntesis}
      
      if (length(fecha_deadline) > 0) {
        fecha_deadline<-fecha_deadline[1]
      }
    }
    
    editors_part1<-data%>% 
      html_nodes(".smaller-pictures .sciprofiles-link__name")%>%
      html_text2()
    
    editors_part2<-data%>%
        html_nodes(".smaller-pictures strong")%>%
        html_text2()
    
    editors<-append(editors_part1,editors_part2)%>%
      clean_names()%>%
      unique()
      editors<-eliminar_tildes(editors)

    # Usar una expresión regular para extraer solo el nombre
    nombre_extraido <- gsub("^(.*?\\s+)+", "", editors_part1)
    nombre_extraido <- unique(nombre_extraido)
    nombre_extraido<-eliminar_tildes(nombre_extraido)
    
    si_papers<-data%>%
      html_nodes(".article-content")%>%
      html_nodes(".title-link")%>%
      html_attr("href")
    
    deadline<-data%>%
      html_nodes(".si-deadline b")%>%
      html_text2()
    deadline<-gsub("closed |\\(|\\)","",deadline)
    
    
    if (identical(si_papers,character(0))) { 
      temp_df<-data.frame(special_issue=i,num_papers=as.double("empty SI"),prop_flag=as.double("empty SI"))
      special_issues_table<-bind_rows(special_issues_table,temp_df)
      Sys.sleep(sleep)
      
      if (show_progress) {
        count=count+1
        setTxtProgressBar(pb, count)
        
      }
      
    } else {
      
      table<-data.frame(submitted=as.Date(character()), 
                        stringsAsFactors=FALSE)
      
      for (j in si_papers) {
        
        article<-read_html(paste0("https://www.mdpi.com",j))
        
        artictype<-article%>%  # To jump over editorial type papers
          html_nodes(".articletype")%>% # To jump over editorial type papers
          html_text2() # To jump over editorial type papers
        
        if (artictype=="Editorial") { # To jump over editorial type papers
          
        } else {# To jump over editorial type papers
        
        authors<-article%>%
          html_nodes(".art-authors")%>%
          html_nodes(".sciprofiles-link__name")%>%
          html_text2()%>%
          unique()
        
        authors<-clean_names(authors)
        authors<-eliminar_tildes(authors)
        
        academic_editor<-article%>%
          html_nodes(".academic-editor-container")%>%
          html_nodes(".sciprofiles-link__name")%>%
          html_text2()%>%
          unique()%>%
          clean_names()
          academic_editor<-eliminar_tildes(academic_editor) 
        
        if (identical(academic_editor,character(0))) {
          aca_flag<-"No info"
        } else {
          
          aca_flag<-intersect(editors,academic_editor)
          
          if (identical(aca_flag,character(0))) {
            aca_flag<-0
          } else {
            aca_flag<-1}}
        
      
        guest_editor<-length(editors)
        result <- as.numeric(editors %in% authors)%>%
          paste(., collapse = ", ")
        
        submitted<-article%>% #ch v 0.0.1.1
          html_nodes(".pubhistory span:nth-child(1)")%>%
          html_text2()%>%
          word(start = -3,end = -1)%>% 
          as.Date("%d %B %Y")
        
        flag<-intersect(authors,editors) #outputs 1 when an editor is an author, 0 if not
        
        if (identical(flag,character(0))) { 
          flag<-0
        } else {
          flag<-1
        }
        
        MDPI_url<-j
        temp_df<-data.frame(MDPI_url,flag,result,submitted,aca_flag) ##beta
        temp_df$aca_flag<-as.character(aca_flag)
        
        table<-bind_rows(table,temp_df)
        
        }
        
      }
      
      si_summary<-round(sum(table$flag)/length(table$MDPI_url),3)
      
      rt_sum_vector<-rep(0,guest_editor)
      
      for (j in 1:nrow(table)) {
        
        line<-table$result[j]%>%
          str_split(",")%>%
          unlist()%>%
          as.numeric()
        
        rt_sum_vector<-rt_sum_vector+line
      }
      
      rt_sum_vector2<-rt_sum_vector%>%
        paste(collapse = ",")
      
      
      if (any(table$aca_flag == "No info")) {
        # Do something if "No info" is found
        aca_flag<-"No info"
      } else {
        aca_flag<-as.character(sum(as.numeric(table$aca_flag)))
      }
      
      
      ed<-nombre_extraido%>%paste(collapse = ", ")  

      temp_df<-data.frame(special_issue=i,num_papers=length(table$MDPI_url),flags=sum(table$flag),prop_flag=si_summary,deadline=as.Date(deadline,"%d %B %Y"), latest_sub=max(table$submitted),rt_sum_vector2,aca_flag)%>%
        mutate(d_over_deadline=deadline-latest_sub, ed, fecha_deadline)
      special_issues_table<-bind_rows(special_issues_table,temp_df)
      Sys.sleep(sleep)
      count<-count+1
      
      if (show_progress) {
      setTxtProgressBar(pb, count)
      }
    }
    
  }
  special_issues_table
}
