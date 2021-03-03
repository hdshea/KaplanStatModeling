Statistical Modeling: Sampling Distribution & Model Coefficients
================
H. David Shea
3 March 2021

Use the mosaic TenMileRace data for examples (skimmed output follows)

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

Coefficients from entire population

``` r
tmr_model1 <- lm(net ~ age + sex, data = TenMileRace)
format(coef(tmr_model1), digits = 2, nsmall = 1)
#> (Intercept)         age        sexM 
#>    "5339.2"    "  16.9"    "-726.6"
```

Coefficients from 10 random samples of n = 100 observations

``` r
for(x in 1:10) {
    cat(x,
        format(coef(lm(net ~ age + sex, data = slice_sample(TenMileRace, n = 100))), digits = 2, nsmall = 1),
        sep = " "
        )
    cat("\n")
}
#> 1 5304.1   21.1 -698.6
#> 2 5714.5    8.8 -925.0
#> 3 5338.7   16.8 -839.5
#> 4  5798.4     7.7 -1036.4
#> 5 5069.2   24.3 -655.6
#> 6 5228.1   26.8 -993.6
#> 7 5268.7   15.4 -651.0
#> 8 4834.3   36.1 -982.6
#> 9 5367.9   19.0 -798.9
#> 10 5170.7   19.8 -674.6
```

Density plots for sampling distributions of the coefficients of 1000
random samples of n = 100 observations

<img src="SamplingExamples_files/figure-gfm/r intercept_plot-1.png" width="70%" style="display: block; margin: auto;" />

<img src="SamplingExamples_files/figure-gfm/r age_coefficient_plot-1.png" width="70%" style="display: block; margin: auto;" />

<img src="SamplingExamples_files/figure-gfm/r sexM_coefficient_plot-1.png" width="70%" style="display: block; margin: auto;" />
