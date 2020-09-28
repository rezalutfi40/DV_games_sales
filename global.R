library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(scales)
library(glue)
library(DT)

vg <- read_csv("data/vgsales/vgsales.csv")

vg <- vg %>% 
  filter(!Year == "N/A")
