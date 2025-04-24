
#| label: tab-1
#| echo: false

library(gt)
options(gt.html_tag_check = FALSE)
# gt_latex_dependencies() # For pdf rendering

# These table was copy-pasted from the manuscript word document into a xlsx file
# I slightly modifies its structure to work better with gt
t1 = readxl::read_excel('Table1.xlsx')

# Define an RGB colors (for compatibility between HTML and PDF)
# light_sand <- rgb(230, 221, 206, maxColorValue = 255)
# dark_sand <- rgb(228, 197, 144, maxColorValue = 255)

gt1 <- t1 |>
  # Remove the "manual" headers
  dplyr::filter(GenR != 'GenR (n = 4268)') |>
  dplyr::group_by(Group) |>
  gt() |>
  tab_header(title = "Sample descriptives", subtitle = "Generation R (GenR) and ALSPAC cohorts") |>
  opt_align_table_header(align = "left") |>
  # Redifine sub-headers (column labels)
  cols_label(Measure = "", 
             GenR = md("**GenR (n = 4268)**"),
             ALSPAC = md("**ALSPAC (n = 8428)**")) |>
  # Clean out missing sub_values
  sub_missing(missing_text = "")  |>
  # Change the background color of the group rows  #TODO: make it work with tatex
  tab_style(
    style = cell_fill(color = "lightgrey"), # light_sand# alpha=0.7 not supported in LaTex
    locations = cells_row_groups()) |>
#  Match grid color
  tab_style(
    style = cell_borders(sides = c("top", "bottom"),
                         color = dark_sand,
                         weight = px(0.5)),
    locations = list(cells_body(), cells_row_groups())) |>
  tab_style(
    style = cell_borders(sides = c("top", "bottom"),
                         color = dark_sand,
                         weight = px(1)),
    locations = cells_stubhead()) |>
  cols_width(Measure ~ pct(50), 
             GenR ~ pct(25), 
             ALSPAC ~ pct(25)) |>
  # Add a footer with footnotes 
  tab_source_note(
    source_note = md("<ins>Note</ins>: Sample descriptives pooled across 30 imputed datasets. BMI = Body-mass index.")
  ) |> 
  tab_footnote(
    locations = cells_body(
        columns = "Measure", 
        rows = Measure %in% c('Africa and Middle East', 'Europe', 'Latin America', 'North America')),
    footnote = md("**Ethnic backgroung grouping**:<br><ins>Africa and Middle East</ins> = Iran (n=11); Iraq (10); South Africa (8); Angola (7); Eritrea (7); Israel (6); Cameroon (5); Egypt (5); Nigeria (5); Ethiopia (4); Algeria (3); Ghana (3); Lebanon (3); Liberia (3); Syria (3); Tanzania (3); Côte d'Ivoire (2); Guinea (2); Mozambique (2); Saudi Arabia (2); Senegal (2); Zimbabwe (2); Africa (1); Armenia (1); Burundi (1); Congo (1); French Congo (1); Gambia (1); Kenya (1); Mali (1); Mauritania (1); Palestine (1); Sierra Leone (1); Somalia (1); Sudan (1); Togo (1); Tunisia (1); Uganda (1); Yemen (1).<br><ins>Asia and Oceania</ins> = Indonesia (n=23); Pakistan (9); Australia (6); China (6); Japan (6); Philippines (6); Thailand (6); India (5); Afghanistan (4); Hongkong (4); South Korea (4); Vietnam (4); Bangladesh (3); Korea (3); Taiwan (3); Kazakhstan (2); New Zealand (2); Dutch New Guinea (1); East Timor (1); Singapore (1); Sri Lanka (1).<br><ins>Europe</ins> = Germany (n=55); Belgium (35); United Kingdom (30); France (29); Portugal (22); Spain (18); Yugoslavia (18); Poland (16); Italy (12); Bosnia-Herzegovina (11); Russia (10); Croatia (7); Czech Republic (7); Switzerland (7); Hungary (6); North Macedonia (6); Serbia-Montenegro (5); Denmark (4); Ireland (4); Norway (4); Sweden (4); Greece (3); Lithuania (3); Romania (3); Austria (2); Kosovo (2); Ukraine (2); Canary Islands (1); Estonia (1); Finland (1); Luxembourg (1); Madeira Islands (1); Moldova (1); Monaco (1); Slovakia (1); Slovenia (1).<br><ins>Latin America</ins> = Colombia (n=18); Brazil (11); Dominican Republic (8); Chile (6); Venezuela (6); Cuba (4); Mexico (4); Argentina (3); Peru (3); Ecuador (2); Guyana (2); Belize (1); Bolivia (1); Haiti (1); Paraguay (1); Trinidad and Tobago (1).<br><ins>North America</ins> = United States of America (n=16); Canada (9).")) |> 
  tab_footnote(
    locations = cells_row_groups(groups = "Maternal education, n (%)"),
    footnote = md("**Maternal education**: low = “secondary, phase 2” or lower in GenR, “None”, “CSE”, “Vocational” or “O level” in ALSPAC; medium = “higher, phase 1” in GenR, “A level” in ALSPAC; high = “higher, phase 2” in GenR, “(College or university) degree” in ALSPAC. Categorization based on ISCED 2011.")) |> 
  tab_footnote(
    locations = cells_row_groups(groups = "Household income, n (%)"),
    footnote = md("**Household income**: low = < €1600 /month in GenR, < £200 /week in ALSPAC; medium = between €1600 and € 4000 /month in GenR, between £200 and £400 /week in ALSPAC; high = > € 4000 /month in GenR, > £400 /week in ALSPAC.")) |> 
  opt_footnote_marks("letters")


hgt1 = as_raw_html(gt1)

writeLines(hgt1, "table1_gt.html")

  # as_raw_latex(gt1, 
  #             align = "left", 
  #             latex_tag = "table", 
  #             latex_class = "table table-responsive")