renv::use(
  askpass           = "askpass@1.2.1",
  base64enc         = "base64enc@0.1-3",
  bslib             = "bslib@0.9.0",
  cachem            = "cachem@1.1.0",
  censusxy          = "chris-prener/censusxy@bdcb5141fe6a9dfc15c6b1fee6dde24376ef2bda",
  cli               = "cli@3.6.5",
  codetools         = "codetools@0.2-20",
  crosstalk         = "crosstalk@1.2.1",
  curl              = "curl@6.4.0",
  digest            = "digest@0.6.37",
  doParallel        = "doParallel@1.0.17",
  dplyr             = "dplyr@1.1.4",
  evaluate          = "evaluate@1.0.4",
  farver            = "farver@2.1.2",
  fastmap           = "fastmap@1.2.0",
  fontawesome       = "fontawesome@0.5.3",
  foreach           = "foreach@1.5.2",
  fs                = "fs@1.6.6",
  generics          = "generics@0.1.4",
  glue              = "glue@1.8.0",
  highr             = "highr@0.11",
  htmltools         = "htmltools@0.5.8.1",
  htmlwidgets       = "htmlwidgets@1.6.4",
  httr              = "httr@1.4.7",
  iterators         = "iterators@1.0.14",
  jquerylib         = "jquerylib@0.1.4",
  jsonlite          = "jsonlite@2.0.0",
  knitr             = "knitr@1.50",
  labeling          = "labeling@0.4.3",
  lattice           = "lattice@0.22-6",
  lazyeval          = "lazyeval@0.2.2",
  leaflet           = "leaflet@2.2.2",
  leaflet.providers = "leaflet.providers@2.0.0",
  lifecycle         = "lifecycle@1.0.4",
  magrittr          = "magrittr@2.0.3",
  memoise           = "memoise@2.0.1",
  mime              = "mime@0.13",
  openssl           = "openssl@2.3.3",
  pillar            = "pillar@1.11.0",
  pkgconfig         = "pkgconfig@2.0.3",
  png               = "png@0.1-8",
  R6                = "R6@2.6.1",
  rappdirs          = "rappdirs@0.3.3",
  raster            = "raster@3.6-32",
  RColorBrewer      = "RColorBrewer@1.1-3",
  Rcpp              = "Rcpp@1.1.0",
  renv              = "renv@1.1.1",
  rlang             = "rlang@1.1.6",
  rmarkdown         = "rmarkdown@2.29",
  sass              = "sass@0.4.10",
  scales            = "scales@1.4.0",
  sp                = "sp@2.2-0",
  sys               = "sys@3.4.3",
  terra             = "terra@1.8-54",
  tibble            = "tibble@3.3.0",
  tidyselect        = "tidyselect@1.2.1",
  tinytex           = "tinytex@0.57",
  utf8              = "utf8@1.2.6",
  vctrs             = "vctrs@0.6.5",
  viridisLite       = "viridisLite@0.4.2",
  withr             = "withr@3.0.2",
  xfun              = "xfun@0.52",
  yaml              = "yaml@2.3.10"
)

library(renv)
library(leaflet)
# library(lubridate)
library(censusxy)
library(dplyr)

renv::snapshot()
renv::embed()



# https://github.com/chris-prener/censusxy
# install.packages("https://github.com/chris-prener/censusxy")



# map----
leaflet() %>%
  addTiles() %>%  # Adds OpenStreetMap tiles
  setView(lng = -78.8986, lat = 35.9940, zoom = 13)  # Durham, NC
