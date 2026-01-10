#' Get variational parameters from theta.
#'
#' @param device
#' @param theta
#'
#' @returns
#' @export
#'
#' @examples
get_phi <- function(theta) {
  phi <- list(
    a_sigma = torch_softplus(theta$a_sigma),
    b_sigma = torch_softplus(theta$b_sigma),
    a_lambda = torch_softplus(theta$a_lambda),
    b_lambda = torch_softplus(theta$b_lambda),
    m = theta$m,
    s = torch_softplus(theta$s)
  )
  phi
}
