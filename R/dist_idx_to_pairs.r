#' Convert distance indices to pair indices
#'
#' @param idx
#' @param n
#'
#' @returns
#' @export
#'
#' @examples
dist_idx_to_pairs <- function(idx, n) {
  if (!inherits(idx, "torch_tensor")) {
    stop("Indices must be a torch tensor.")
  }
  idx <- idx$to(dtype = torch_double())
  n <- torch_tensor(n, device = idx$device, dtype = torch_double())

  i <- torch_ceil((2 * n - 1 - torch_sqrt((2 * n - 1)$pow(2) - 8 * idx)) / 2)
  j <- idx + i - n * (i - 1) + (i * (i - 1)) / 2

  list(
    i = i$to(dtype = torch_long()),
    j = j$to(dtype = torch_long())
  )
}

