# @file PackageMaintenance
#
# Copyright 2019 Accenture
#
# This file is part of SqlRender
# 


# Format and check codeP
OhdsiRTools::formatRFolder()
OhdsiRTools::checkUsagePackage("SQLCon")
OhdsiRTools::updateCopyrightYearFolder()

# Create manual and vignettes:
shell("rm extras/SqlRender.pdf")
shell("R CMD Rd2pdf ./ --output=extras/SQLCon.pdf")

rmarkdown::render("vignettes/UsingSQLCon.Rmd",
                  output_file = "../inst/doc/UsingSQLCon.pdf",
                  rmarkdown::pdf_document(latex_engine = "pdflatex",
                                          toc = TRUE,
                                          number_sections = TRUE))

pkgdown::build_site()

# Release package:
devtools::check_win_devel()

devtools::check_rhub()

devtools::release()
