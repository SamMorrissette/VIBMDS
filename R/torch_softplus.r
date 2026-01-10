#' Softplus function
#'
#' @param x
#'
#' @returns
#' @export
#'
#' @import torch
#' @examples
torch_softplus <- function(x) {
  if (!inherits(x, "torch_tensor")) {
    stop("x must be a torch tensor.")
  }
  nnf_softplus(x)
}
