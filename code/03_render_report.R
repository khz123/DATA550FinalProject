here::i_am("code/03_render_report.R")

rmarkdown::render(
  here::here("code/FinalProject.Rmd"),
  output_file = "FinalProject.html",
  output_dir = here::here("report")
)