#' Generate samples from a Binary Concrete distribution
#'
#' @param sample_shape
#' @param alpha
#' @param temperature
#'
#' @returns
#' @export
#'
#' @examples
torch_rbinconcrete <- function(sample_shape, alpha, temperature) {
  device <- alpha$device
  u <- torch_rand(c(S, p), device = device)
  l <- torch_log(u) - torch_log1p(-u)
  torch_sigmoid((l + torch_log(alpha)) / temperature)
}
