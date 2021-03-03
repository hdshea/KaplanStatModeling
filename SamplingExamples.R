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
library(ggformula)

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

#' Examples below use the mosaic TenMileRace data set.
#' These data are running times for 8636 registered participants in the Cherry Blossom Ten Mile Race held in Washington, D.C. in April 2005.
#' Skimmed output follows:
#+ r data_set, warning = FALSE, echo = FALSE
TenMileRace %>% skim()
#+

#' This shows the 2D density plots of net running times by age for Females and Males
#+ r population_density, echo = FALSE
gf_point(net ~ age | sex, data = TenMileRace, color = ~sex, alpha = 0.2) %>%
    gf_density2d(color = "gray40") %>%
    gf_labs(
        title = "Net Running Times 2D Density Plots",
        subtitle = "By Age and Sex",
        x = "Age",
        y = "Net Running Time",
        color = "Sex",
        caption = "Source: Cherry Blossom Ten Mile Race, April 2005"
        )
#+

#' ### net ~ age + sex
#'
#' Now fitting this linear model for the entire population and random samples of n = 100 from the entire population.
#'
#' Model coefficients from entire population
#+ r population_coefficients
tmr_model1 <- lm(net ~ age + sex, data = TenMileRace)
format(coef(tmr_model1), digits = 2, nsmall = 1)
#+

#' Model coefficients from 10 random samples of n = 100 observations
#+ r random_sample_coefficients
for(x in 1:10) {
    cat(x,
        format(coef(lm(net ~ age + sex, data = slice_sample(TenMileRace, n = 100))), digits = 2, nsmall = 1),
        sep = " "
        )
    cat("\n")
}
#+

#' Density plots for sampling distributions of the model coefficients of 1000 random samples of n = 100 observations
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

#' Standard Error estimates for three random samples of n = 100 from the r regression report function `summary.lm()`
#+ r reg_rpt_std_err_estimates, echo = FALSE
cat("Coefficients:\n")
summary.lm(slice_sample(tmr_set, n = 1)$model[[1]])$coefficients
cat("\nCoefficients:\n")
summary.lm(slice_sample(tmr_set, n = 1)$model[[1]])$coefficients
cat("\nCoefficients:\n")
summary.lm(slice_sample(tmr_set, n = 1)$model[[1]])$coefficients
#+
