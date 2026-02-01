#' VI_BMDS (CSS)
#'
#' @param dist_mat
#' @param p
#' @param prior_params
#' @param B
#' @param S
#' @param max_iter
#' @param device
#'
#' @returns
#' @export
#'
#' @examples
CSS_vi_bmds <- function(dist_mat, p = 10, prior_params, B, S, max_iter, device) {
  dist_mat <- as.matrix(dist_mat)
  n <- nrow(dist_mat)
  theta <- CSS_init_theta(n, p, device)
  opt <- optim_adam(params = theta, lr = 0.1)

  elbo <- numeric(max_iter)
  best_elbo <- -Inf
  stop_iter <- 0

  min_lr <- 1e-4
  scheduler <- lr_reduce_on_plateau(
    optimizer = opt,
    mode = "max",
    factor = 0.5,
    patience = 100,
    cooldown = 0,
    min_lr = min_lr
  )

  dist_vec <- torch_tensor(c(as.dist(dist_mat)), device = device)
  print("Starting VI")
  for (iter in 1:max_iter) {
    opt$zero_grad()

    phi <- CSS_get_phi(theta)

    z <- CSS_generate_z(phi, S)

    log_p <- CSS_compute_log_joint(dist_vec, z, prior_params, B, device)

    log_q <- CSS_compute_log_q(z, phi)

    loss <- -(log_p - log_q)$mean()

    loss$backward()

    nn_utils_clip_grad_norm_(theta, max_norm = 5.0)
    opt$step()

    elbo[iter] <- as.numeric(-loss$mean())
    scheduler$step(elbo[iter])

    if (iter %% 100 == 0) {
      print(paste("Iteration:", iter, "ELBO =", elbo[iter], "LR =", scheduler$get_last_lr()))
    }

    if (elbo[iter] > best_elbo) {
      best_elbo <- elbo[iter]
      best_iter <- iter
    }

    if ( scheduler$get_last_lr() <= (min_lr+1e-12) && (iter - best_iter) >= 100) {
      print("Stopping: LR at min since there has been no improvement for 100 iterations")
      stop_iter <- iter
      break
    }
  }

  phi <- CSS_get_phi(theta)
  list(phi = phi,
       stop_iter = stop_iter)
}
