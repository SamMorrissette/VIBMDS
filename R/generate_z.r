#' Generate samples of z from the variational distribution q
#'
#' @param phi
#' @param S
#'
#' @returns
#' @export
#'
#' @import torch
#' @examples
generate_z <- function(phi, S) {
  sigma <- torch_reciprocal(distr_gamma(phi$a_sigma, phi$b_sigma)$rsample(sample_shape = c(S)))
  lambda <- torch_reciprocal(distr_gamma(phi$a_lambda, phi$b_lambda)$rsample(sample_shape = c(S)))

  x <- distr_normal(phi$m, phi$s)$rsample(sample_shape=c(S))

  list(sigma = sigma$squeeze(),
       lambda = lambda,
       x = x)
}
