#' Get variational parameters from theta. (CSS)
#'
#' @param device
#' @param theta
#'
#' @returns
#' @export
#'
#' @examples
CSS_get_phi <- function(theta) {
  phi <- list(
    a_sigma = torch_softplus(theta$a_sigma),
    b_sigma = torch_softplus(theta$b_sigma),
    a_lambda = torch_softplus(theta$a_lambda),
    b_lambda = torch_softplus(theta$b_lambda),
    a_z = torch_softplus(theta$a_z) + 1e-12,
    b_z = torch_softplus(theta$b_z) + 1e-12,
    m = theta$m,
    s = torch_softplus(theta$s)
  )
  phi
}
