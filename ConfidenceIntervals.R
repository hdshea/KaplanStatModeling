#' ---
#' title: "Statistical Modeling:  Confidence Intervals"
#' author: "H. David Shea"
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

#' ### Data
#'
#' Examples below use the mosaic SAT dataset.
#' These data are SAT data assembled for a statistics education journal article on the link between SAT scores and measures of educational expenditures.
#' Skimmed output follows:
#+ r data_set, warning = FALSE, echo = FALSE
SAT %>% skim()
#+

#' This shows the scatter plot of SAT scores versus estimated average annual salary of teachers in each state.
#' The liner model regression line for the data is shown as well.
#+ r population_scatter, echo = FALSE, warning = FALSE
mdl_base <- lm(sat ~ salary, data = SAT)
gf_point(sat ~ salary, data = SAT, alpha = 0.2, color = "blue") %>%
    gf_abline(slope = coef(mdl_base)[2], intercept = coef(mdl_base)[1], color = "gray40") %>%
    gf_labs(
        title = "Average SAT Scores Versus Estimated Average Annual Salary of Teachers",
        subtitle = "For each state",
        x = "Salary",
        y = "SAT Score"
    )
rm(mdl_base)
#+

#' The simple model doesn't show a strong relationship between SAT scores and teachers salaries and - maybe counter-intuitively -
#' hints at higher salaries being associated with lower SAT scores.
#'

#' ### Model:  sat ~ salary + ratio + frac
#'
#' Now fitting this potentially more robust and meaningful linear model for the entire population.
#' It includes `salary`, as well as average pupil/teacher ratio per classroom (`ratio`) and percentage of all eligible students taking the SAT (`frac`) in the state as explanatory variables.
#'
#' Model coefficients from entire population
#+ r population_coefficients
sat_pop <- lm(sat ~ salary + ratio + frac, data = SAT)
format(coef(sat_pop), digits = 2, nsmall = 1)
#+

#' Standard Error estimates for entire population
#+ r reg_rpt_std_err_estimates
summary.lm(sat_pop)$coefficients
#+

#' This shows the confidence interval for `salary` is about 2.5 +/- 2.0 at the 95% level (two standard deviations).
#' So, the indication is higher teach salaries are associated with higher test scores from this model perspective.
#' Also, the confidence interval for `ratio` is about -4.6 +/- 4.2 at the 95% level.
#' Potentially indicative that higher student-faculty ratios have a negative impact on SAT scores from this model perspective since the interval does not cover zero.
#' The tight confidence interval on `frac` (-2.9 +/- 0.4) and the fact that the interval does not approach positive territory shows the
#' important negative impact of this *covariate*.
#'
