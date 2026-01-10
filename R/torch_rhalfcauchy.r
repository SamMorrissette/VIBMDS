#' Generate samples from a Half-Cauchy distribution
#'
#' @param n
#' @param scale
#' @param device
#'
#' @returns
#' @export
#'
#' @import torch
#' @examples
torch_rhalfcauchy <- function(sample_shape, scale) {
  u <- torch_rand(sample_shape, device = scale$device)
  scale * torch_abs(torch_tan(pi * (u - 0.5)))
}
