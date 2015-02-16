# Toy example of a Gibbs sampler using MCMC
# Goal is so simulate from the joint pdf f(x,y)=(G(alpha)x!)^(-1)y^(alpha+x-1)e^(-2y)
# where G(.) is the gamma function.

library( compiler )
library( microbenchmark )
library( ggplot2 )

rToyGibbs <- function ( n, alpha )
{
  gibbsSample <- matrix( ncol = 2, nrow = n )
  x <- 0
  y <- 0
  gibbsSample[1, ] <- c(x, y)
  for (i in 2:n) {
    x <- rpois(1, y)
    y <- rgamma(1, alpha + x, 2)
    gibbsSample[i, ] <- c(x, y)
  }
  gibbsSample
}

CompRToyGibbs <- cmpfun(rToyGibbs)

res <- microbenchmark(rToyGibbs( 1000, 0.6 ),
                      CompRToyGibbs( 1000, 0.6 ),
                      times=1000)

windows()
autoplot(res)
