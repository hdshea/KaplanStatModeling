#' ---
#' title: "Statistical Modeling:  Sampling Distribution & Model Coefficients"
#' author: "H. David Shea"
#'
#' date: "3 March 2021"
#' output: github_document
#' ---
#'

#+ r setup, include = FALSE
library(mosaicData)
library(skimr)
library(tidyverse)

knitr::opts_chunk$set(
    comment = "#>",
    collapse = TRUE,
    message = FALSE,
    fig.width = 8,
    fig.asp = ((1 + sqrt(5)) / 2) - 1, # hadley wickam's version of the golden ratio
    out.width = "70%",
    fig.align = "center"
)
#+

#' Use the mosaic TenMileRace data for examples (skimmed output follows)
#+ r data_set, warning = FALSE, echo = FALSE
TenMileRace %>% skim()
#+

#' Coefficients from entire population
#+ r population_coefficients
tmr_model1 <- lm(net ~ age + sex, data = TenMileRace)
format(coef(tmr_model1), digits = 2, nsmall = 1)
#+

#' Coefficients from 10 random samples of n = 100 observations
#+ r random_sample_coefficients
for(x in 1:10) {
    cat(x,
        format(coef(lm(net ~ age + sex, data = slice_sample(TenMileRace, n = 100))), digits = 2, nsmall = 1),
        sep = " "
        )
    cat("\n")
}
#+

#' Density plots for sampling distributions of the coefficients of 1000 random samples of n = 100 observations
#+ r random_set, echo = FALSE
tmr_set <- tibble(data.frame(matrix(ncol = 4, nrow = 1000, dimnames = list(NULL, c("Intercept", "age", "sexM", "model")))))
for(x in 1:1000) {
    mdl <- lm(net ~ age + sex, data = slice_sample(TenMileRace, n = 100))
    tmr_set$Intercept[x] <- coef(mdl)[1]
    tmr_set$age[x] <- coef(mdl)[2]
    tmr_set$sexM[x] <- coef(mdl)[3]
    tmr_set$model[x] <- list(mdl)
}
#+

#+ r intercept_plot, echo = FALSE
tmr_set %>%
    ggplot(aes(Intercept)) +
    geom_density() +
    geom_vline(xintercept = coef(tmr_model1)[1]) +
    labs(
        title = "Intercept Sampling Distribution",
        subtitle = str_c("Standard Error = ", format(sd(tmr_set$Intercept), digits = 2, nsmall = 1)),
        x = "Intercept",
        y = "Density",
        caption = "Vertical line is value for entire population"
    )
#+

#+ r age_coefficient_plot, echo = FALSE
tmr_set %>%
    ggplot(aes(age)) +
    geom_density() +
    geom_vline(xintercept = coef(tmr_model1)[2]) +
    labs(
        title = "Age Coefficient Sampling Distribution",
        subtitle = str_c("Standard Error = ", format(sd(tmr_set$age), digits = 2, nsmall = 1)),
        x = "Age Coefficient",
        y = "Density",
        caption = "Vertical line is value for entire population"
    )
#+

#+ r sexM_coefficient_plot, echo = FALSE
tmr_set %>%
    ggplot(aes(sexM)) +
    geom_density() +
    geom_vline(xintercept = coef(tmr_model1)[3]) +
    labs(
        title = "Sex(Male) Coefficient Sampling Distribution",
        subtitle = str_c("Standard Error = ", format(sd(tmr_set$sexM), digits = 2, nsmall = 1)),
        x = "Sex(Male) Coefficient",
        y = "Density",
        caption = "Vertical line is value for entire population"
    )
#+
