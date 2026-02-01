#' Compute the logarithm of the joint density (CSS)
#'
#' @param z
#' @param prior_params
#' @param batch_index
#'
#' @returns
#' @export
#'
#' @examples
CSS_compute_log_joint <- function(dist_vec, z, prior_params, B, device) {
  log_lik <- log_lik_minibatch(dist_vec, z, B, device)

  p_sigma <- torch_log_halfcauchy(z$sigma, prior_params$scale_sigma)

  p_lambda <- torch_log_halfcauchy(z$lambda, prior_params$scale_lambda)$sum(dim=2)

  p_x_tilde <- distr_normal(0, z$lambda$unsqueeze(2))$log_prob(z$x_tilde)$sum(dim = c(2, 3))

  p_z_gates <- torch_log_binconcrete(z$z_gates, prior_params$loc, prior_params$temp)$sum(dim = 2)

  log_lik + p_sigma + p_lambda + p_x_tilde + p_z_gates
}
