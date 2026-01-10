#' Logarithm of Half-Cauchy Density
#'
#' @param x
#' @param scale
#'
#' @returns
#' @export
#'
#' @import torch
#' @examples
torch_log_halfcauchy <- function(x, scale) {
  if (!inherits(x, "torch_tensor")) {
    stop("x must be a torch tensor.")
  }
  torch_log(2/(pi*scale)) + torch_log(1 / (1 + (x/scale)$pow(2)))
}
