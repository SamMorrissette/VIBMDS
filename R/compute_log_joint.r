#' Compute the logarithm of the joint density
#'
#' @param z
#' @param prior_params
#' @param batch_index
#'
#' @returns
#' @export
#'
#' @import torch
#' @examples
compute_log_joint <- function(dist_vec, z, prior_params, B) {
  log_lik <- log_lik_minibatch(dist_vec, z, B)
  p_sigma <- torch_log_halfcauchy(z$sigma, prior_params$scale_sigma)
  p_lambda <- torch_log_halfcauchy(z$lambda, prior_params$scale_lambda)$sum(dim=2)
  p_x <- torch::distr_normal(loc = 0, scale = z$lambda$unsqueeze(2))$log_prob(z$x)$sum(dim=c(2,3))

  log_lik + p_sigma + p_lambda + p_x
}
