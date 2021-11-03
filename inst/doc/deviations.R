## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  fig.width=7, fig.height=5,
  collapse = TRUE,
  comment = "#>"
)
library(dplyr)
library(ggplot2)
library(NHSRplotthedots)
library(NHSRdatasets)

## -----------------------------------------------------------------------------
data <- c(1, 2, 1, 2, 10, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1)
date <- seq(as.Date("2021-03-22"), by = 1, length.out = 18)
df <- tibble(data, date)

# screen_outliers = TRUE by default
spc_data <- ptd_spc(df, value_field = data, date_field = date)
spc_data %>%
  plot() + 
  labs(
    caption = paste(
      "UPL = ", round(spc_data$upl[1], 2),
      ", Mean = ", round(spc_data$mean[1], 2),
      ", LPL = ", round(spc_data$lpl[1], 2))
  )

## -----------------------------------------------------------------------------

# setting screen_outliers = FALSE produces the same output as excel
spc_data <- ptd_spc(df, value_field = data, date_field = date, screen_outliers = FALSE)
spc_data %>%
  plot() + 
  labs(
    caption = paste(
      "UPL = ", round(spc_data$upl[1], 2),
      ", Mean = ", round(spc_data$mean[1], 2),
      ", LPL = ", round(spc_data$lpl[1], 2))
  )


## -----------------------------------------------------------------------------
spc_data <- ae_attendances %>%
  group_by(period) %>%
  summarise(across(attendances, sum)) %>%
  ptd_spc(attendances, period, rebase = as.Date(c("2017-04-01", "2018-04-01")))

plot(spc_data, break_lines = "both")

## -----------------------------------------------------------------------------
plot(spc_data, break_lines = "limits")

## -----------------------------------------------------------------------------
plot(spc_data, break_lines = "process")

## -----------------------------------------------------------------------------
plot(spc_data, break_lines = "none")

