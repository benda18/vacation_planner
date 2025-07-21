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
# library(tigris)

renv::snapshot()
renv::embed()


rm(list=ls());cat('\f')

# Functions----

gen_dest <- function(name, addr = NA, desc, 
                     lon = NA, lat = NA){
  require(dplyr)
  out <- data_frame(loc_name = as.character(name), 
                    loc_addr = as.character(addr), 
                    loc_desc = as.character(desc), 
                    x        = as.numeric(lon), 
                    y        = as.numeric(lat))
  
  return(out)
}

# chatgpt  prompts----

df_hotels <- data.frame(city = c("Atlanta", 
                                 "Montgomery", 
                                 "birmingham", "huntsville", "asheville"), 
                        dow = c("Monday", "Tuesday", "Wednesday", 
                                "Thursday", "Friday"))

gemini_all <- "plan a road trip. i'll be driving a 2019 chevrolet bolt ev with DC fast charging. 

Depart Durham NC at 9am on July 21st, 2025.  
Spend 2 hours at carowinds 
arrive in atlanta, GA near the georgia aquarium.
stay at a hotel overnight. 


On Tuesday, depart the hotel around 9am. 
Visit the georgia aquarium. 
visit Six Flags Over Georgia for 2-3 hours. 
Drive to Toomer's Corner in Auburn, Al.  Have a meal in Auburn. 
Drive to Montgomery, Al.  Stay in a hotel in Montgomery. 

On Wednesday, visit the civil rights meorial in montgomery. 
visit the national memorial for peace and justice.
drive to Selma and spend 30-60 minutes exploring the city. 
stop at orr park to view the tinglewood carvings. 
drive to Birmingham, Al. stay in a hotel in birmingham. 

On Thursday spend time exploring Birmingham Al. 
Visit the Museum of Fond Memories at Reed Books.
Visit the Sloss Furnaces visitor museum and site. 
Drive to Huntsville, Al and visit the US Rocket and Space Center.
Stay in hotel in Huntsville. 

On Friday, drive from Huntsville to Asheville, NC.  
along the way, stop at the unclaimed luggage store at 509 W Willow St, Scottsboro, AL 35768 for an hour. 
Along the way, drive the tail of the dragon and stop at deal's gap motorcycle resort for 30 minutes.
Stay in a hotel in Asheville.

On Saturday, drive from Asheville to Durham, NC."


# gpt_monday <- "plan a road trip.  
# i'll be driving a 2019 chevrolet bolt ev with a 60kWh battery pack that charges max speed at 50kW and about 30kW on average from 20% SoC to 80% Soc.  
# Depart 1210 laurel meadows drive, durham nc tomorrow morning at 9am. 
# 
# spend 2 hours at carowinds
# arrive in atlanta, GA near the georgia aquarium"
# 
# gpt_tuesday <- "plan a road trip.  
# i'll be driving a 2019 chevrolet bolt ev.  
# depart georgia aquarium around 9am. 
# spend 2-3 hours at Six Flags Over georgia. 
# drive to toomer's corner in Auburn, Al.
# drive to Montgomery Alabama"
# 
# gpt_wednesday <- "plan a road trip.  
# i'll be driving a 2019 chevrolet bolt ev.
# 
# depart Montgomery, Al around 2pm. 
# drive to Selma, Al for 30-60 minutes. 
# drive to Birmingham, Al"
# 
# gpt_thursday <- "plan a road trip.  
# i'll be driving a 2019 chevrolet bolt ev.
# 
# depart Birmingham, Al around 2pm. 
# drive to Huntsville, Al"
# 
# gpt_friday <- "plan a road trip.  
# i'll be driving a 2019 chevrolet bolt ev.
# 
# depart Huntsville, Al around 2pm. 
# drive to Deals Gap motorcycle resort. 
# drive to Asheville, NC"
# 
# gpt_saturday <- "plan a road trip.  
# i'll be driving a 2019 chevrolet bolt ev.
# 
# depart Asheville, NC around 9am. 
# drive to Durham, NC"
# 
# cgpt_prompt <- "plan a road trip for me leaving durham, nc, returning to durham, nc and visiting the following locations:
# 
# 1. georgia aquarium in atlanta
# 
# 2. majestic caverns in alabama
# 
# 3. the unclaimed baggage store in alabama
# 
# 4. huntsville alabama rocket center
# 
# 5. birmingham, al
# 
# 6. montgomery, al
# 
# 7. selma, al
# 
# vehicle type is 2019 chevrolet bolt ev. optimize the route for the shortest travel time





# Locations----
map_skateparks <- c("")

map_stops <- c("509 W Willow St, Scottsboro, AL 35768", #Unclaimed Baggage Center, Scottsdale AL", 
               "5181 Desoto Caverns Pkwy, Childersburg, AL 35044", # majestic caverns
               NA)

map_dests <- rbind(gen_dest("NASA US Space and Rocket Center", 
                            "1 Tranquility Base, Huntsville, AL 35805", 
                            desc = "visit", 
                            lon = -86.65417, 
                            lat = 34.71139), 
                   gen_dest("Toomer's Corner", 
                            desc = "Iconic, murdered trees near Auburn University", 
                            lon = -85.48169, lat = 32.60661),
                   gen_dest(name = "Edmund Pettus Bridge", 
                            addr = "Selma, AL", 
                            desc = "visit", 
                            lat = 32.40536, 
                            lon = -87.018485), 
                   gen_dest(name = "Six Flags Over Georgia", 
                            addr = "275 Riverside Pkwy, Austell, GA 30168", 
                            desc = "visit", 
                            lon = -84.5500, 
                            lat = 33.7683),
                   gen_dest(name = "Home", 
                            addr = "1210 Laurel Meadows Drive, Durham, NC", 
                            desc = "visit", 
                            lon = -78.91775, 
                            lat = 36.04909), 
                   gen_dest(name = "Georgia Aquarium", 
                            addr = "225 Baker St, Atlanta, GA 30313", 
                            desc = "visit", 
                            lon = NA, 
                            lat = NA), 
                   gen_dest(name = "Carowinds", 
                            addr = NA, 
                            desc = "visit", 
                            lon = -80.94167, 
                            lat = 35.10278))

map_cities <- rbind(gen_dest("Montgomery, AL", 
                       addr = NA, 
                       desc = "city", 
                       lon = -86.3, 
                       lat = 32.3675), 
                    gen_dest("Atlanta, GA", 
                             addr = "100 auburn St, Atlanta, GA", 
                             desc = "city", 
                             lon = -84.3842, 
                             lat = 33.75563), 
                    # gen_dest("Montgomery, AL", desc = "city", 
                    #          addr = NA, 
                    #          lon = -86.05203, 
                    #          lat = 32.3646), 
                    gen_dest("Birmingham, AL", desc = "city",
                             addr = NA,
                             lon = -86.7548,
                             lat = 33.50583),
                    gen_dest("Huntsville, AL", desc = "city", 
                             lon = -86.48078, lat = 34.76076),
                    gen_dest("Selma, NC", desc = "city",
                             lon = -87.04213, lat = 32.5173),
                    gen_dest("Charlotte, NC", desc = "city",
                             lon = -80.85885, 
                             lat = 35.21265)
                    )

censusxy::cxy_oneline("275 Riverside, Austell, GA")[c("coordinates.x", 
                                                      "coordinates.y")]

# Data Tidy----
for(i in 1:nrow(map_dests)){
  if(is.na(map_dests$x[i] & !is.na(map_dests$loc_addr[i]))){
    out1 <- (censusxy::cxy_oneline(map_dests$loc_addr[i]))
    print(out1)
    map_dests$x[i] <- out1$coordinates.x
    map_dests$y[i] <- out1$coordinates.y
    out1$coordinates.y
  }
}

# High-level days

# Mapping----

leaflet() %>%
  addTiles() %>%
  addMarkers(lng = map_dests$x,
             lat = map_dests$y,
             label = map_dests$loc_name) #%>%
  addCircleMarkers(lng = map_cities$x, 
             lat = map_cities$y, 
             label = map_cities$loc_name, 
             radius = 5)
