#' Generate samples from a Beta distribution
#'
#' @param sample_shape
#' @param shape1
#' @param shape2
#'
#' @returns
#' @export
#'
#' @examples
torch_rbeta <- function(sample_shape, shape1, shape2) {
  device <- shape1$device
  gamma_scale <- torch_tensor(1.0, device=shape1$device)

  gamma_x <- distr_gamma(shape1, gamma_scale)$rsample(sample_shape = c(sample_shape))
  gamma_y <- distr_gamma(shape2, gamma_scale)$rsample(sample_shape = c(sample_shape))
  gamma_x / (gamma_x + gamma_y)
}
