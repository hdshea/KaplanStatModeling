Statistical Modeling: Confidence Intervals
================
H. David Shea
3 March 2021

### Data

Examples below use the mosaic SAT dataset. These data are SAT data
assembled for a statistics education journal article on the link between
SAT scores and measures of educational expenditures. Skimmed output
follows:

|                                                  |            |
|:-------------------------------------------------|:-----------|
| Name                                             | Piped data |
| Number of rows                                   | 50         |
| Number of columns                                | 8          |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |            |
| Column type frequency:                           |            |
| factor                                           | 1          |
| numeric                                          | 7          |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |            |
| Group variables                                  | None       |

Data summary

**Variable type: factor**

| skim\_variable | n\_missing | complete\_rate | ordered | n\_unique | top\_counts                    |
|:---------------|-----------:|---------------:|:--------|----------:|:-------------------------------|
| state          |          0 |              1 | FALSE   |        50 | Ala: 1, Ala: 1, Ari: 1, Ark: 1 |

**Variable type: numeric**

| skim\_variable | n\_missing | complete\_rate |   mean |    sd |     p0 |    p25 |    p50 |     p75 |    p100 | hist  |
|:---------------|-----------:|---------------:|-------:|------:|-------:|-------:|-------:|--------:|--------:|:------|
| expend         |          0 |              1 |   5.91 |  1.36 |   3.66 |   4.88 |   5.77 |    6.43 |    9.77 | ▆▇▆▁▂ |
| ratio          |          0 |              1 |  16.86 |  2.27 |  13.80 |  15.22 |  16.60 |   17.58 |   24.30 | ▇▇▃▁▁ |
| salary         |          0 |              1 |  34.83 |  5.94 |  25.99 |  30.98 |  33.29 |   38.55 |   50.05 | ▅▇▃▂▂ |
| frac           |          0 |              1 |  35.24 | 26.76 |   4.00 |   9.00 |  28.00 |   63.00 |   81.00 | ▇▂▂▃▃ |
| verbal         |          0 |              1 | 457.14 | 35.18 | 401.00 | 427.25 | 448.00 |  490.25 |  516.00 | ▇▇▃▇▇ |
| math           |          0 |              1 | 508.78 | 40.20 | 443.00 | 474.75 | 497.50 |  539.50 |  592.00 | ▆▇▃▆▃ |
| sat            |          0 |              1 | 965.92 | 74.82 | 844.00 | 897.25 | 945.50 | 1032.00 | 1107.00 | ▇▇▃▇▃ |

This shows the scatter plot of SAT scores versus estimated average
annual salary of teachers in each state. The liner model regression line
for the data is shown as well.

<img src="ConfidenceIntervals_files/figure-gfm/r population_scatter-1.png" width="70%" style="display: block; margin: auto;" />

The simple model doesn’t show a strong relationship between SAT scores
and teachers salaries and - maybe counter-intuitively - hints at higher
salaries being associated with lower SAT scores.

### Model: sat \~ salary + ratio + frac

Now fitting this potentially more robust and meaningful linear model for
the entire population. It includes `salary`, as well as average
pupil/teacher ratio per classroom (`ratio`) and percentage of all
eligible students taking the SAT (`frac`) in the state as explanatory
variables.

Model coefficients from entire population

``` r
sat_pop <- lm(sat ~ salary + ratio + frac, data = SAT)
format(coef(sat_pop), digits = 2, nsmall = 1)
#> (Intercept)      salary       ratio        frac 
#>    "1057.9"    "   2.6"    "  -4.6"    "  -2.9"
```

Standard Error estimates for entire population

``` r
summary.lm(sat_pop)$coefficients
#>                Estimate Std. Error    t value     Pr(>|t|)
#> (Intercept) 1057.898162 44.3286685  23.864876 1.496236e-27
#> salary         2.552470  1.0045183   2.540989 1.449126e-02
#> ratio         -4.639428  2.1215142  -2.186847 3.387652e-02
#> frac          -2.913350  0.2282436 -12.764215 1.007685e-16
```

This shows the confidence interval for `salary` is about 2.5 +/- 2.0 at
the 95% level (two standard deviations). So, the indication is higher
teach salaries are associated with higher test scores from this model
perspective. Also, the confidence interval for `ratio` is about -4.6 +/-
4.2 at the 95% level. Potentially indicative that higher student-faculty
ratios have a negative impact on SAT scores from this model perspective
since the interval does not cover zero. The tight confidence interval on
`frac` (-2.9 +/- 0.4) and the fact that the interval does not approach
positive territory shows the important negative impact of this
*covariate*.
