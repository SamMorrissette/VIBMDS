#' Logarithm of Binary Concrete Density
#'
#' @param x
#' @param alpha
#' @param temperature
#'
#' @returns
#' @export
#'
#' @examples
torch_log_binconcrete <- function(x, alpha, temperature) {
  if (!inherits(x, "torch_tensor")) {
    stop("x must be a torch tensor.")
  }
  x <- x$clamp(1e-7, 1 - 1e-7)
  alpha <- alpha$clamp_min(1e-7)
  temperature <- temperature$clamp_min(1e-7)

  log_temp <- torch_log(temperature)
  log_location <- torch_log(alpha)
  log_x <- torch_log(x)
  log_num <-  (log_temp + log_location + ((-temperature - 1) * log_x)) + (-temperature - 1) * torch_log1p(-x)
  log_denom <-  2 * torch_logsumexp(torch_stack(list(log_location - temperature * log_x,
                                                     -temperature * torch_log1p(-x)), dim = 1), dim = 1)
  log_num - log_denom
}
