#' Compute the logarithm of the variational density (CSS)
#'
#' @param z
#' @param phi
#'
#' @returns
#' @export
#'
#' @examples
CSS_compute_log_q <- function(z, phi) {
  q_x_tilde <- distr_normal(loc = phi$m, scale = phi$s)$log_prob(z$x_tilde)$sum(dim = c(2, 3))

  q_lambda <- torch_log_invgamma(z$lambda, phi$a_lambda, phi$b_lambda)$sum(dim = 2)
  q_sigma <- torch_log_invgamma(z$sigma, phi$a_sigma, phi$b_sigma)

  q_z_gates <- torch_log_beta(z$z_gates, phi$a_z, phi$b_z)$sum(dim = 2)

  q_x_tilde + q_lambda + q_sigma + q_z_gates
}
