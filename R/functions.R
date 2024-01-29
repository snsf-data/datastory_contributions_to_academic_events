# Function that returns the desired language version of a string, given three
# language strings are provided to the function.
translate <- function(en_string = "NOT TRANSLATED",
                      de_string = "NOT TRANSLATED",
                      fr_string = "NOT TRANSLATED",
                      lang = "en") {
  string <-
    case_when(
      lang == "en" ~ en_string,
      lang == "de" ~ de_string,
      lang == "fr" ~ fr_string,
      TRUE ~ "NO VALID LANGUAGE SPECIFIED"
    )
  
  return(string)
}

translate_regions <- function(x, lang) {
  
  if (lang == "en") {
    
    region <- if_else(str_detect(x, "Europe"), "Europe (excl. CH)", x)
    
  }
  
  if (lang == "de") {
    region <-
      case_when(
        x == "Switzerland" ~ "Schweiz",
        str_detect(x, "Europe") ~ "Europa (ohne CH)",
        x == "Europe" ~ "Europa",
        x == "North America" ~ "Nordamerika",
        x == "Asia" ~ "Asien",
        x == "Latin America" ~ "Lateinamerika",
        x == "Africa & Oceania" ~ "Afrika und Ozeanien",
        x == "Others" ~ "Andere"
      )
  }
  
  if (lang == "fr") {
    region <-
      case_when(
        x == "Switzerland" ~ "Suisse",
        str_detect(x, "Europe") ~ "Europe (excl. CH)",
        x == "North America" ~ "Amérique du Nord",
        x == "Asia" ~ "Asie",
        x == "Latin America" ~ "Amérique Latine",
        x == "Africa & Oceania" ~ "Afrique et Océanie",
        x == "Others" ~ "Autres"
      )
  }
  
  return(region)
  
}

translate_events <-  function(x, lang) {
  
  if (lang == "en") event <- x
  
  if (lang == "de") {
    event <-
      case_when(
        x == "Poster" ~ "Poster",
        x == "Talk given at a conference" ~ "Referat an Konferenz",
        x == "Individual talk" ~ "Einzelreferat"
      )
  }
  
  if (lang == "fr") {
    event <-
      case_when(
        x == "Poster" ~ x,
        x == "Talk given at a conference" ~ "Exposé lors d\'une conférence",
        x == "Individual talk" ~ "Conférence individuelle"
      )
  }
  
  return(event)
  
}

translate_institutions <- function(x, lang) {
  
  if (lang == "en") institution <- x
  
  if (lang == "de") {
    institution <-
      case_when(
        x == "Cantonal universities and ETH domain" ~ "Kantonale Universitäten und ETH-Bereich",
        x == "Other institutions" ~ "Andere Institutionen"
      )
    
    institution <-
      fct(
        institution,
        levels =
          c("Kantonale Universitäten und ETH-Bereich",
            "Andere Institutionen")
      )
  }
  
  if (lang == "fr") {
    institution <-
      case_when(
        x == "Cantonal universities and ETH domain" ~ "Universités cantonales et\ninstitutions du domaine des EPF",
        x == "Other institutions" ~ "Autres institutions"
      )
    
    institution <-
      fct(
        institution,
        levels =
          c("Universités cantonales et\ninstitutions du domaine des EPF",
            "Autres institutions")
      )
  }
  
  return(institution)
  
}
