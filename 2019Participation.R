

library(here)
library(tidyverse)
library(readxl)


### Load data ------


math <- read_excel(here("data","mathpratedownload2019.xlsx") )

ela <- read_excel(here("data","elapratedownload2019.xlsx") )


elpac <- read_excel(here("data","elpacpart2019.xlsx") )

### Clean and merge ----

elpac <- elpac %>%
    mutate(studentgroup = "EL") %>%
    mutate(test = "elpac")

math <- math %>%
    mutate(test = "math")

ela <- ela %>%
    mutate(test = "ela")

participation <- math %>%
    bind_rows(ela) %>%
    bind_rows(elpac) %>%
    mutate(prate = as.numeric(prate),
           enrolled = as.numeric(enrolled),
           tested = as.numeric(tested))


participation.mry <- participation %>%
    filter(countyname == "Monterey")

participation.mry.low <- participation.mry %>%
    filter(prate < 95,
           enrolled >= 30)


