#' Initialize variational parameters
#'
#' @param n
#' @param p
#' @param device
#'
#' @returns
#' @export
#'
#' @examples
init_theta <- function(n, p, device) {
  theta <- list(
    a_sigma = torch_zeros(1, device = device, requires_grad = TRUE),
    b_sigma = torch_zeros(1, device = device, requires_grad = TRUE),
    a_lambda = torch_zeros(p, device = device, requires_grad = TRUE),
    b_lambda = torch_zeros(p, device = device, requires_grad = TRUE),

    m = torch_zeros(c(n, p), device = device, requires_grad = TRUE),
    s = torch_zeros(c(n, p), device = device, requires_grad = TRUE)
  )
  theta
}
