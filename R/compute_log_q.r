#' Compute the logarithm of the variational density
#'
#' @param z
#' @param phi
#'
#' @returns
#' @export
#'
#' @import torch
#' @examples
compute_log_q <- function(z, phi) {
  q_lambda <- torch_log_invgamma(z$lambda, phi$a_lambda, phi$b_lambda)$sum(dim = 2)
  q_sigma <- torch_log_invgamma(z$sigma, phi$a_sigma, phi$b_sigma)
  q_x <- torch::distr_normal(loc = phi$m, scale = phi$s)$log_prob(z$x)$sum(dim = c(2, 3))

  q_x + q_lambda + q_sigma
}
