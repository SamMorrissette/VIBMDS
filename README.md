
<!-- README.md is generated from README.Rmd. Please edit that file -->

# VIBMDS

<!-- badges: start -->

<!-- badges: end -->

Variational Inference Bayesian Multidimensional Scaling (VIBMDS) is a
variational inference algorithm applied to the Bayesian Multidimensional
Scaling model.

## Installation

You can install the development version of VIBMDS from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("SamMorrissette/VIBMDS")
```

## Iris Example

A simple example showing how to apply VIBMDS to the Iris dataset for
dimension reduction.

``` r
library(VIBMDS)
library(torch)

device <- torch_device("cpu")
```

``` r
iris_dist <- as.matrix(dist(iris[,1:4]))

# Uninformative priors:
prior_params <- list(scale_lambda = torch_tensor(25.0, device = device),
                     scale_sigma = torch_tensor(25.0, device = device))

# Run VIBMDS
results <- VIBMDS::vi_bmds(iris_dist, 
                           p = 2, 
                           prior_params = prior_params,
                           B = 1000, S = 10, max_iter = 5000, 
                           device = device)
#> [1] "Iteration: 100 ELBO = 904.09033203125 LR = 0.1"
#> [1] "Iteration: 200 ELBO = 3394.22729492188 LR = 0.1"
#> [1] "Iteration: 300 ELBO = 2825.93603515625 LR = 0.1"
#> [1] "Iteration: 400 ELBO = 2557.43774414062 LR = 0.1"
#> [1] "Iteration: 500 ELBO = 3260.68359375 LR = 0.05"
#> [1] "Iteration: 600 ELBO = 3261.50341796875 LR = 0.025"
#> [1] "Iteration: 700 ELBO = 2423.28564453125 LR = 0.025"
#> [1] "Iteration: 800 ELBO = 3558.01879882812 LR = 0.0125"
#> [1] "Iteration: 900 ELBO = 3797.92529296875 LR = 0.00625"
#> [1] "Iteration: 1000 ELBO = 3288.77856445312 LR = 0.003125"
#> [1] "Iteration: 1100 ELBO = 4586.9248046875 LR = 0.0015625"
#> [1] "Iteration: 1200 ELBO = 4351.2119140625 LR = 0.0015625"
#> [1] "Iteration: 1300 ELBO = 5367.4130859375 LR = 0.0015625"
#> [1] "Iteration: 1400 ELBO = 2538.28344726562 LR = 0.00078125"
#> [1] "Iteration: 1500 ELBO = 2477.47216796875 LR = 0.000390625"
#> [1] "Iteration: 1600 ELBO = 4303.85400390625 LR = 0.0001953125"
#> [1] "Stopping: LR at min since there has been no improvement for 100 iterations"
```

``` r
# Generate object configurations from the variational approximation
var_samples <- generate_z(results, 1000) 
config <- as.matrix(var_samples$x$mean(dim = 1))
```

``` r
# Plot the final configuration
plot(config, col = iris$Species, main = "Object configuration",
     xlab = "Dimension 1", ylab = "Dimension 2")
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />
