log_lik_minibatch <- function(dist_vec, z, B) {
  n <- z$x$size()[2]
  m <- choose(n, 2)
  batch_idx <- torch_tensor(sample(m, size = B, replace = FALSE), device = device)
  pair_idx <- dist_idx_to_pairs(batch_idx, n)

  x_i <- z$x$index_select(dim = 2, index = pair_idx$i)
  x_j <- z$x$index_select(dim = 2, index = pair_idx$j)

  observed_distances  <- dist_vec[batch_idx]

  batch_delta <- (x_i - x_j)$pow(2)$sum(dim = 3)$sqrt()
  log_lik <- torch_log_truncnorm(observed_distances$unsqueeze(1), mu = batch_delta, sigma = z$sigma$unsqueeze(2))$sum(dim = 2)

  (m / B) * log_lik
}
