#' Logarithm of Truncated Normal Density
#'
#' @param x
#' @param mu
#' @param sigma
#'
#' @returns
#' @export
#'
#' @import torch
#' @examples
torch_log_truncnorm <- function(x, mu, sigma) {
  if (!inherits(x, "torch_tensor")) {
    stop("x must be a torch tensor.")
  }

  normal_cdf <- 0.5 * (1 + torch_erf((-mu/sigma) / sqrt(2)))
  log_num <- distr_normal(loc = mu, scale = sigma)$log_prob(x)
  Z <- (1-normal_cdf)
  Z <- torch_clamp(Z, min = 1e-12)
  log_denom <- torch_log(Z)
  log_num - log_denom
}
