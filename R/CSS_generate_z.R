#' Generate samples of z from the variational distribution q (CSS)
#'
#' @param phi
#' @param S
#'
#' @returns
#' @export
#'
#' @examples
CSS_generate_z <- function(phi, S) {
  sigma <- torch_reciprocal(distr_gamma(phi$a_sigma, phi$b_sigma)$rsample(sample_shape = c(S)))
  lambda <- torch_reciprocal(distr_gamma(phi$a_lambda, phi$b_lambda)$rsample(sample_shape = c(S)))

  x_tilde <- distr_normal(phi$m, phi$s)$rsample(sample_shape=c(S))
  z_gates <- torch_rbeta(S, phi$a_z, phi$b_z)
  z_gates <- z_gates$clamp(1e-12, 1 - 1e-12)
  x <- z_gates$unsqueeze(2) * x_tilde

  list(sigma = sigma$squeeze(),
       lambda = lambda,
       x_tilde = x_tilde,
       z_gates = z_gates,
       x = x)
}
