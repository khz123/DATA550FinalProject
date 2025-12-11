# final report (inside container)
FinalProject.html: code/FinalProject.Rmd code/03_render_report.R \
data/coffee_data.RDS output/scatterplot.RDS output/regression_table.RDS \
output/regression_table.RDS
	Rscript code/03_render_report.R
	
# set up environment
install:
	Rscript -e "renv::restore(prompt = FALSE)"

# cleaned data
data/coffee_data.RDS: code/00_load_data.R data/synthetic_coffee_health_10000.csv
	Rscript code/00_load_data.R
	
# figure1
output/scatterplot.RDS: code/01_scatterplot.R data/coffee_data.RDS
	Rscript code/01_scatterplot.R
	
# regression model
output/regression_table.RDS: code/02_regression_table.R data/coffee_data.RDS
	Rscript code/02_regression_table.R

output/regression_model.RDS: code/02_regression_table.R data/coffee_data.RDS
	Rscript code/02_regression_table.R

.PHONY: clean
clean:
	rm -f output/*.RDS && rm -f data/*.RDS && rm -f report/FinalProject.html
	
# docker associated rules which run on local machine
.PHONY: build_image
build_image:
	docker build -t final_report .
	
.PHONY: final_report
final_report: 
	docker run -v "$$(pwd)/report":/home/rstudio/project/report mengkhz0/final_report
	
