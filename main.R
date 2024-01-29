# This script produces all the files required to deploy an SNSF data story.
#
# Data story template: https://github.com/snsf-data/datastory_template
#
# By running this file, the following components of a data story are generated
# and stored in the output directory:
#
# 1) a HTML file (self-contained), which contains all visualizations and
#   images in encoded form, one for every specified language.
# 2) one file "metadata.json", which contains the metadata essential for
#   the story (including all language versions in one file).
#
# The files are stored in output/xxx, where xxx stands for the title of the
# data story in English, how it can also be used for the vanity URL to the
# story, that means: no special characters, only lowercase.

# Unique name of this data story in English (all lowercase, underscore as
# space, no special characters etc.)
# -> Don't put "datastory" at the start or end!
datastory_name <- "contributions_to_academic_events"

# Language-specific names, do adapt! (used for vanity URL! Format: all
# lowercase, minus as white-space (!) and no special characters, no special
# characters etc.)
# -> Don't put "datastory" at the start or end!
datastory_name_en <- "contributions-to-academic-events"
datastory_name_de <- "praesentationen-an-wissenschaftlichen-veranstaltungen"
datastory_name_fr <- "contributions-aux-manifestations-scientifiques"

# English title and lead of the story (Mandatory, even if no EN version)
title_en <- "Academic events: SNSF grant recipients often contribute internationally"
lead_en <- "An analysis of 16,000 academic events associated with SNSF grants revealed a high degree of internationality. 67% of the contributions were made to events organised outside Switzerland, and the majority were in Europe."
# German title and lead of the story (Mandatory, even if no DE version)
title_de <- "Veranstaltungen: Vom SNF geförderte Forschende präsentieren ihre Ergebnisse sehr oft international"
lead_de <- "Eine Analyse von 16 000 wissenschaftlichen Veranstaltungen zeigt: Ergebnisse aus SNF-finanzierten Projekten werden sehr oft international präsentiert. Zwei Drittel der Veranstaltungen fanden ausserhalb der Schweiz statt."
# French title and lead of the story (Mandatory, even if no FR version)
title_fr <- "Manifestations scientifiques : nombreuses contributions issues de subsides du FNS sur la scène internationale"
lead_fr <- "L’analyse de 16 000 manifestations scientifiques liées aux subsides du FNS a révélé une internationalité élevée. 67% des contributions ont porté sur des manifestations organisées hors de Suisse, dont la majorité en Europe."
# Contact persons, always (first name + last name)
contact_person <- c("Simon Gorin")
# Mail address to be displayed as contact persons, put "datastories@snf.ch" for
# every name of a contact person listed above.
contact_person_mail <- c("datastories@snf.ch")
# One of the following categories:  "standard", "briefing", "techreport",
# "policybrief", "flagship", "figure". Category descriptions are
datastory_category <- "standard"
# Date, after which the story should be published. Stories not displayed if the
# date lies in the future.
publication_date <- "2024-01-30 04:00:00"
# Available language versions in lowercase, possible: "en", "de", "fr".
languages <- c("en", "de", "fr")
# Whether this story should be a "Feature Story" story
feature_story <- FALSE
# DOI URL of the story (optional) -> e.g. must be an URL, is used as link!
# e.g. https://doi.org/10.46446/datastory.leaky-pipeline
doi_url <- paste0("https://doi.org/10.46446/datastory.", gsub("_", "-", datastory_name))
# URL to Github page (optional)
github_url <- paste0("https://github.com/snsf-data/datastory_", datastory_name)
# Put Tag IDs here. Only choose already existing tags.
tags_ids <- c(
  150, # international cooperation
  160, # value of research
  180  # bibliometrics
)

# IMPORTANT: Put a title image (as .jpg) into the output directory.
# example: "output/datastory-template.jpg"

# Install snf.datastory package if not available, otherwise load it
if (!require("snf.datastory")) {
  if (!require("devtools")) {
    install.packages("devtools")
    library(devtools)
  }
  install_github("snsf-data/snf.datastory")
  library(snf.datastory)
}

# Load packages
library(tidyverse)
library(scales)
library(conflicted)
library(glue)
library(jsonlite)
library(here)

# Conflict preferences
conflict_prefer("filter", "dplyr")

# Function to validate a mandatory parameter value
is_valid <- function(param_value) {
  if (is.null(param_value)) {
    return(FALSE)
  }
  if (is.na(param_value)) {
    return(FALSE)
  }
  if (str_trim(param_value) == "") {
    return(FALSE)
  }
  return(TRUE)
}

all_params <-
  c(
    "datastory_name", "title_en", "title_de", "title_fr", "datastory_category",
    "publication_date", "languages", "lead_en", "lead_de", "lead_fr", "doi_url",
    "github_url", "tags_ids",
    "Placeholder value of datastory_name must be changed",
    "Placeholder value of datastory_name_en must be changed",
    "Placeholder value of datastory_name_de must be changed",
    "Placeholder value of datastory_name_fr must be changed",
    'datastory_name cannot start or end with "datastory"',
    'datastory_name_en cannot start or end with "datastory"',
    'datastory_name_de cannot start or end with "datastory"',
    'datastory_name_fr cannot start or end with "datastory"',
    "Placeholder value of title_en must be changed",
    "Placeholder value of lead_en must be changed",
    "Placeholder value of title_de must be changed",
    "Placeholder value of lead_de must be changed",
    "Placeholder value of title_fr must be changed",
    "Placeholder value of lead_fr must be changed",
    "contact_person",
    "Length of contact_person and contact_person_mail must be equal",
    'datastory_category must be one of "standard", "briefing", "techreport", "policybrief", "flagship", or "figure"'
  )

are_params_valid <-
  c(
    is_valid(datastory_name),
    is_valid(title_en),
    is_valid(title_de),
    is_valid(title_fr),
    is_valid(datastory_category),
    is_valid(publication_date),
    sum(languages %in% c("en", "de", "fr")) == 3,
    is_valid(lead_en),
    is_valid(lead_de),
    is_valid(lead_fr),
    is_valid(doi_url),
    is_valid(github_url),
    length(tags_ids) > 0,
    datastory_name != "template_datastory",
    datastory_name_en != "datastory-template",
    datastory_name_de != "datastory-vorlage",
    datastory_name_fr != "datastory-modele",
    !str_starts(datastory_name, "datastory") && !str_ends(datastory_name, "datastory"),
    !str_starts(datastory_name_en, "datastory") && !str_ends(datastory_name_en, "datastory"),
    !str_starts(datastory_name_de, "datastory") && !str_ends(datastory_name_de, "datastory"),
    !str_starts(datastory_name_fr, "datastory") && !str_ends(datastory_name_fr, "datastory"),
    title_en != "Template Title",
    lead_en != "English lead of story",
    title_de != "Template Titel",
    lead_de != "Deutscher Lead der Story",
    title_fr != "Template Titre",
    lead_fr != "Story lead en français",
    mean(map_lgl(contact_person, is_valid)) == 1,
    length(contact_person) == length(contact_person_mail),
    datastory_category %in% c("standard", "briefing", "techreport",
                              "policybrief", "flagship", "figure")
  )

# Validate parameters and throw error message when not correctly filled
if (any(!are_params_valid)) {
  stop(
    paste0(
      "\nIncorrect value for the following mandatory metadata values:\n",
      "- ", paste0(all_params[!are_params_valid], collapse = "\n- ")
    )
  )
}

# Check that the github repo is not
if (github_url == "https://github.com/snsf-data/datastory_template_datastory") {
  stop(
    "\nThe link to the Github repository corresponds to the placeholder from ",
    "the template. Please enter a valid link before continuing."
  )
}

# Check whether an image exists and throw a warning if there is a png or no
# image at all.
if (length(grep("jpg$", list.files(here("output", datastory_name)))) == 0) {
  warning(
    "It seems there is no thumbnail image in 'output/", datastory_name, "'."
  )
}
if (length(grep("png$", list.files(here("output", datastory_name)))) != 0) {
  warning(
    paste0(
      "It seems the thumbnail image in 'output/", datastory_name, "' ",
      "is a .png file. Only .jpg file are accepted.")
  )
}

# Create output directory in main directory
if (!dir.exists(here("output"))) {
  dir.create(here("output"))
}

# Create story directory in output directory
if (!dir.exists(here("output", datastory_name))) {
  dir.create(here("output", datastory_name))
}

# Create a JSON file with the metadata and save it in the output directory
tibble(
  title_en = title_en,
  title_de = title_de,
  title_fr = title_fr,
  author = paste(contact_person, collapse = ";"),
  datastory_category = datastory_category,
  publication_date = publication_date,
  languages = paste(languages, collapse = ";"),
  short_desc_en = lead_en,
  short_desc_de = lead_de,
  short_desc_fr = lead_fr,
  tags = paste(paste0("T", tags_ids, "T"), collapse = ","),
  author_url = paste(contact_person_mail, collapse = ";"),
  top_story = feature_story,
  github_url = github_url,
  doi = doi_url
) %>%
  toJSON() %>%
  write_lines(here("output", datastory_name, "metadata.json"))

for (idx in seq_len(length(languages))) {
  current_lang <- languages[idx]
  filename <- paste0(
    str_replace_all(
      get(paste0("datastory_name_", current_lang)), "_", "-"
    ),
    "-", current_lang, ".html"
  )
  output_file <- here(
    "output", datastory_name,
    filename
  )
  print(paste0("Generating output for ", current_lang, " version..."))
  quarto::quarto_render(
    input = here(paste0(current_lang, ".qmd")),
    output_file = filename,
    execute_params = list(
      title = get(paste0("title_", current_lang)),
      publication_date = publication_date,
      github_url = github_url,
      doi = doi_url,
      lang = current_lang
    )
  )
  fs::file_move(path = here(filename),new_path = output_file)
}
