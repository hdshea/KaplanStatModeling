Statistical Modeling: Sampling Distribution & Model Coefficients
================
H. David Shea
3 March 2021

Examples below use the mosaic TenMileRace data set. These data are
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

### net \~ age + sex

Now fitting this linear model for the entire population and random
samples of n = 100 from the entire population.

Model coefficients from entire population

``` r
tmr_model1 <- lm(net ~ age + sex, data = TenMileRace)
format(coef(tmr_model1), digits = 2, nsmall = 1)
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
#> 1 5411.7   15.9 -620.8
#> 2 5702.3    2.4 -549.6
#> 3 5643.1    8.4 -697.0
#> 4 5290.2   19.8 -832.1
#> 5 5430.6   16.9 -563.8
#> 6 4759.3   35.3 -919.4
#> 7 5660.3    7.9 -686.1
#> 8 4960.3   24.7 -824.8
#> 9 5399.9   10.8 -533.8
#> 10 5402.7   12.6 -629.4
```

Density plots for sampling distributions of the model coefficients of
1000 random samples of n = 100 observations

<img src="SamplingExamples_files/figure-gfm/r intercept_plot-1.png" width="70%" style="display: block; margin: auto;" />

<img src="SamplingExamples_files/figure-gfm/r age_coefficient_plot-1.png" width="70%" style="display: block; margin: auto;" />

<img src="SamplingExamples_files/figure-gfm/r sexM_coefficient_plot-1.png" width="70%" style="display: block; margin: auto;" />

Standard Error estimates for three random samples of n = 100 from the r
regression report function `summary.lm()`

    #> Coefficients:
    #>                Estimate Std. Error    t value     Pr(>|t|)
    #> (Intercept) 5838.308881 326.956704 17.8565199 2.011476e-32
    #> age           -1.120241   8.989144 -0.1246215 9.010811e-01
    #> sexM        -451.094578 180.442459 -2.4999359 1.409967e-02
    #> 
    #> Coefficients:
    #>               Estimate Std. Error   t value     Pr(>|t|)
    #> (Intercept) 5666.85433 343.215160 16.511084 6.230320e-30
    #> age           10.16118   9.098073  1.116849 2.668177e-01
    #> sexM        -593.33891 191.198123 -3.103267 2.507871e-03
    #> 
    #> Coefficients:
    #>               Estimate Std. Error   t value     Pr(>|t|)
    #> (Intercept) 5208.24699 366.031400 14.228962 1.762445e-25
    #> age           22.09115   9.363239  2.359350 2.031096e-02
    #> sexM        -883.41790 190.842481 -4.629042 1.139051e-05
