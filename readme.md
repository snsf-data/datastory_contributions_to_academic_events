# Datastory: *Academic events: SNSF grant recipients often contribute internationally*

*An analysis of 16,000 academic events associated with SNSF grants revealed a high degree of internationality. 67% of the contributions were made to events organised outside Switzerland, and the majority were in Europe.*

[English](https://data.snf.ch/stories/contributions-to-academic-events-en.html)\
[German](https://data.snf.ch/stories/praesentationen-an-wissenschaftlichen-veranstaltungen-de.html)\
[French](https://data.snf.ch/stories/contributions-aux-manifestations-scientifiques-fr.html)

**Author(s)**: Simon Gorin

**Publication date**: 30.01.2024

--

## Data description

The data used in this data story are available in the folder `data`. The data consist of two files (`data/acad_event.csv` and `international_collab.csv`), providing for \~1300 grants decided on 2017 and 2018 in project funding and careers funding schemes, information about 16000 contributions to academic events and project partners/collaborators.

The raw data, before processing, can be found in the [datasets section of the SNSF Data Portal](https://data.snf.ch/datasets).

### `acad_event.csv`

This file includes information that can also be found in the `Output data: Academic events` and `Grants` datasets available in the [datasets section of the SNSF Data Portal](https://data.snf.ch/datasets). Each line represents a contribution to an academic event. Here follows a description of the variables included in the data:

-   `grant_number`: SNSF unique identifier of the grant associated to the contribution (can be used in the [search grant](https://data.snf.ch/grants) of the SNSF Data Portal).
-   `year`: year in which the grant associated to the event contribution was decided.
-   `research_institution`: applicant's research institution of the grant associated with the contribution.
-   `research_institution_type`: applicant's research institution type of the grant associated with the contribution, according to the following classification: Cantonal university, University of applied sciences, University of Teacher Education, institutions from the ETH Domain (coded as "ETH domain"), other institutions (coded as "Other").
-   `funding_instrument_ga_level1`: funding scheme of the grant associated to the contribution (including only "Projects" and "Careers" funding schemes).
-   `event`: name of the academic event.
-   `event_date`: date when the academic event took place.
-   `event_year`: year when the academic event took place.
-   `event_location`: where the academic event took place.
-   `event_contribution_title`: title of the contribution.
-   `event_all_involved_person`: people involved in the contribution.
-   `event_contribution_type`: type of contribution ("Poster", "Talk given at a conference", or "Individual talk").
-   `event_country`: country where the academic event took place (in English).
-   `event_country_de`: country where the academic event took place (in German).
-   `event_country_fr`: country where the academic event took place (in French).
-   `event_world_region`: part of the world where the academic event took place (Africa, Asia, Europe (excl. CH), Latin America, North America, Oceania, or Switzerland).

### `international_collab.csv`

This file includes information that can also be found in the `Persons` and `Grants` datasets available in the [datasets section of the SNSF Data Portal](https://data.snf.ch/datasets). Each line represents a single grant. Here follows a description of the variables included in the data:

-   `grant_number`: the SNSF unique identifier of the grant associated to the publication (can be used in the [search grant](https://data.snf.ch/grants) of the SNSF Data Portal).
-   `year`: year in which the grant was decided.
-   `research_area`: the SNSF distinguishes three major research domains (Humanities and Social Sciences (SSH), Mathematics, Natural and Engineering Sciences (MINT), and Life Sciences (LS)).
-   `research_institution_type`: applicant's research institution type, according to the following classification: Cantonal university, University of applied sciences, University of Teacher Education, institutions from the ETH Domain (coded as "ETH domain"), other institutions (coded as "Other").
-   `has_collab_switzerland`: whether the grant had a project partner/co-applicant located in Switzerland (boolean).
-   `has_collab_europe`: whether the grant had a project partner/co-applicant located in Europe (excluding Switzerland) (boolean).
-   `has_collab_north_am`: whether the grant had a project partner/co-applicant located in North America (USA and Canada) (boolean).
-   `has_collab_asia`: whether the grant had a project partner/co-applicant located in Asia (boolean).
-   `has_collab_latin_am`: whether the grant had a project partner/co-applicant located in Latin America (South America and Mexcio) (boolean).
-   `has_collab_oceania`: : whether the grant had a project partner/co-applicant located in Oceania (boolean).
-   `has_collab_africa`: whether the grant had a project partner/co-applicant located in Africa (boolean).
