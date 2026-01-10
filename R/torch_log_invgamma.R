#' Logarithm of Inverse-Gamma Density
#'
#' @param x
#' @param a
#' @param b
#'
#' @returns
#' @export
#'
#' @examples
torch_log_invgamma <- function(x, a, b) {
  if (!inherits(x, "torch_tensor")) {
    stop("x must be a torch tensor.")
  }
   a * torch_log(b) - torch_lgamma(a) - (a + 1) * torch_log(x) - b / x
}
