FinalProject.html: FinalProject.Rmd code/03_render_report.R \
data/coffee_data.RDS output/scatterplot.RDS output/regression_table.RDS \
output/regression_table.RDS
	Rscript code/03_render_report.R

# cleaned data
data/coffee.RDS: code/00_load_data.R data/synthetic_coffee_health_10000.csv
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
	rm -f output/*.rds && rm -f FinalProject.html