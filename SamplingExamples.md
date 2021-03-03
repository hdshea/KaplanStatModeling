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
#> 1 5323.1   23.5 -855.1
#> 2 5142.2   20.0 -440.4
#> 3 5197.8   20.7 -868.6
#> 4 5503.7    6.6 -342.0
#> 5 4975.3   24.5 -662.8
#> 6 5146.6   17.9 -256.1
#> 7 5237.2   15.9 -799.7
#> 8 5643.8    6.4 -669.6
#> 9 5133.5   20.9 -463.2
#> 10 5333.7   14.9 -753.2
```

Density plots for sampling distributions of the model coefficients of
1000 random samples of n = 100 observations

<img src="SamplingExamples_files/figure-gfm/r intercept_plot-1.png" width="70%" style="display: block; margin: auto;" />

<img src="SamplingExamples_files/figure-gfm/r age_coefficient_plot-1.png" width="70%" style="display: block; margin: auto;" />

<img src="SamplingExamples_files/figure-gfm/r sexM_coefficient_plot-1.png" width="70%" style="display: block; margin: auto;" />

Standard Error estimates for three random samples of n = 100 from the r
regression report function `summary.lm()`

    #> Coefficients:
    #>               Estimate Std. Error   t value     Pr(>|t|)
    #> (Intercept) 4874.91012 360.240412 13.532380 4.563344e-24
    #> age           32.10327   9.211475  3.485138 7.401836e-04
    #> sexM        -780.29911 212.532646 -3.671432 3.946657e-04
    #> 
    #> Coefficients:
    #>               Estimate Std. Error   t value     Pr(>|t|)
    #> (Intercept) 5232.71664 266.389810 19.643081 1.407808e-35
    #> age           15.53432   7.185632  2.161858 3.308929e-02
    #> sexM        -816.37002 152.179922 -5.364505 5.515730e-07
    #> 
    #> Coefficients:
    #>               Estimate Std. Error   t value     Pr(>|t|)
    #> (Intercept) 5388.84522   376.9586 14.295589 1.294870e-25
    #> age           18.98975    10.9600  1.732642 8.633763e-02
    #> sexM        -831.86970   228.8950 -3.634286 4.481498e-04
