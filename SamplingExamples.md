Statistical Modeling: Sampling Distribution & Model Coefficients
================
H. David Shea
3 March 2021

### Data

Examples below use the mosaic TenMileRace dataset. These data are
running times for 8636 registered participants in the Cherry Blossom Ten
Mile Race held in Washington, D.C. in April 2005. Skimmed output
follows:

|                                                  |            |
|:-------------------------------------------------|:-----------|
| Name                                             | Piped data |
| Number of rows                                   | 8636       |
| Number of columns                                | 5          |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |            |
| Column type frequency:                           |            |
| factor                                           | 2          |
| numeric                                          | 3          |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |            |
| Group variables                                  | None       |

Data summary

**Variable type: factor**

| skim\_variable | n\_missing | complete\_rate | ordered | n\_unique | top\_counts                           |
|:---------------|-----------:|---------------:|:--------|----------:|:--------------------------------------|
| state          |          0 |              1 | FALSE   |        62 | VA: 3689, MD: 2166, DC: 1642, PA: 273 |
| sex            |          0 |              1 | FALSE   |         2 | F: 4325, M: 4311                      |

**Variable type: numeric**

| skim\_variable | n\_missing | complete\_rate |    mean |      sd |   p0 |  p25 |    p50 |  p75 |  p100 | hist  |
|:---------------|-----------:|---------------:|--------:|--------:|-----:|-----:|-------:|-----:|------:|:------|
| time           |          0 |              1 | 5813.15 | 1038.35 | 2816 | 5125 | 5806.5 | 6455 | 10603 | ▂▇▇▁▁ |
| net            |          0 |              1 | 5599.07 |  969.66 | 2814 | 4950 | 5555.0 | 6169 | 10536 | ▁▇▅▁▁ |
| age            |          0 |              1 |   36.86 |   10.60 |   10 |   28 |   35.0 |   44 |    87 | ▂▇▅▁▁ |

This shows the 2D density plots of net running times by age for Females
and Males

<img src="SamplingExamples_files/figure-gfm/r population_density-1.png" width="70%" style="display: block; margin: auto;" />

### Model: net \~ age + sex

Now fitting this linear model for the entire population and random
samples of n = 100 from the entire population.

Model coefficients from entire population

``` r
tmr_pop <- lm(net ~ age + sex, data = TenMileRace)
format(coef(tmr_pop), digits = 2, nsmall = 1)
#> (Intercept)         age        sexM 
#>    "5339.2"    "  16.9"    "-726.6"
```

Model coefficients from 10 random samples of n = 100 observations

``` r
for(x in 1:10) {
    cat(x,
        format(coef(lm(net ~ age + sex, data = slice_sample(TenMileRace, n = 100))), digits = 2, nsmall = 1),
        sep = " "
        )
    cat("\n")
}
#> 1 5577.4    7.5 -456.2
#> 2 5525.6   11.2 -765.3
#> 3 5527.7   10.4 -571.5
#> 4 5973.8    3.6 -669.8
#> 5 5980.0    4.9 -538.6
#> 6 5183.8   25.2 -802.1
#> 7 5417.1   15.4 -726.9
#> 8 5464.9   11.6 -705.2
#> 9  5215.4    29.6 -1087.7
#> 10 5652.4    4.8 -714.8
rm(x)
```

### Sampling

Density plots for sampling distributions of the model coefficients of
1000 random samples of n = 100 observations

<img src="SamplingExamples_files/figure-gfm/r intercept_plot-1.png" width="70%" style="display: block; margin: auto;" />

<img src="SamplingExamples_files/figure-gfm/r age_coefficient_plot-1.png" width="70%" style="display: block; margin: auto;" />

<img src="SamplingExamples_files/figure-gfm/r sexM_coefficient_plot-1.png" width="70%" style="display: block; margin: auto;" />

Standard Error estimates for three random samples of n = 100 from the r
regression report function `summary.lm()`

    #> Coefficients:
    #>                Estimate Std. Error    t value     Pr(>|t|)
    #> (Intercept) 5419.388643 298.182102 18.1747617 5.356313e-33
    #> age            8.540484   8.741814  0.9769693 3.310146e-01
    #> sexM        -280.544773 171.998924 -1.6310845 1.061153e-01
    #> 
    #> Coefficients:
    #>               Estimate Std. Error   t value     Pr(>|t|)
    #> (Intercept) 4839.33184  382.58704 12.648970 3.052723e-22
    #> age           33.69693   10.69243  3.151476 2.161154e-03
    #> sexM        -718.04456  225.32862 -3.186655 1.936897e-03
    #> 
    #> Coefficients:
    #>               Estimate Std. Error   t value     Pr(>|t|)
    #> (Intercept) 5024.66680 316.265479 15.887497 9.613690e-29
    #> age           25.44376   9.215788  2.760888 6.894168e-03
    #> sexM        -966.80253 192.291545 -5.027795 2.270746e-06
