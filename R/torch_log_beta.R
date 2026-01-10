#' Logarithm of Beta Density
#'
#' @param x
#' @param shape1
#' @param shape2
#'
#'
#' @returns
#' @export
#'
#' @examples
torch_log_beta <- function(x, shape1, shape2) {
  if (!inherits(x, "torch_tensor")) {
    stop("x must be a torch tensor.")
  }
  x <- x$clamp(1e-6, 1 - 1e-6)
  (shape1 - 1) * torch_log(x) + (shape2 - 1) * torch_log1p(-x) - (torch_lgamma(shape1) + torch_lgamma(shape2) - torch_lgamma(shape1 + shape2))
}
