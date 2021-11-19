unit_circle <- function() {
  xi_pos <- seq(from = -1, to = 1, by = 0.01) # top half circle
  xi_neg <- seq(from = 1, to = -1, by = -0.01) # bottom half circle
  vec_stack <- rbind(
    cbind(
      xi_pos,
      yi = sqrt(1 - xi_pos**2)
    ),
    cbind(
      xi_neg,
      yi = -sqrt(1 - xi_neg**2)
    )
  )
  return(vec_stack)
}

plot_unit_circle <- function(unit_circle, annotate = TRUE) {
  # prepare the drawing canvas
  lines(x = unit_circle[, 1], y = unit_circle[, 2], col = "#0072B2", lwd = 2)
  if (annotate) {
    text(0.5, 1.5, expression(bold(x)), col = "#0072B2", cex = 2)
  }
}

transform <- function(matrix) {
  # transformation matrix
  mat_trans <- matrix

  # multiply mat_trans with each vector from vec_stack,
  # effectively transforming the circule represented by vec_stack
  # Not a transparent solution, to optimize
  vec_stack_trans <- t(apply(unit_circle(), MARGIN = 1, FUN = `%*%`, t(mat_trans)))

  return(vec_stack_trans)
  }

plot_transformed <- function(vec_stack_trans, mat, xpos, ypos) {
  lines(
    x = vec_stack_trans[, 1],
    y = vec_stack_trans[, 2],
    col = "#56B4E9",
    lwd = 2
  )
  if (!missing(mat)) {
  text(xpos, ypos,
    bquote(paste(bold(.(mat)), bold(x))),
    col = "#56B4E9",
    cex = 2)
  }
}
# <https://stackoverflow.com/q/28370249/2271797>

empty_canvas <- function(
  xlim = c(-4, 4),
  ylim = c(-4, 4),
  ...
  ) {
  plot(xlim, ylim,
    type = "n", xlab = "x", ylab = "y",
    asp = 1,
    ...
  )
  abline(v = 0, h = 0, col = "gray")
  grid()
}
