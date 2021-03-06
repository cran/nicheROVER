% Generated by roxygen2 (4.0.1): do not edit by hand
\name{rniw}
\alias{rniw}
\title{Random draws from a Normal-Inverse-Wishart distribution.}
\usage{
rniw(n, lambda, kappa, Psi, nu)
}
\arguments{
\item{n}{number of samples to draw.}

\item{lambda}{location parameter. See Details.}

\item{kappa}{scale parameter. See Details.}

\item{Psi}{scale matrix.  See Details}

\item{nu}{degrees of freedom.  See Details.}
}
\value{
Returns a list with elements \code{mu} and \code{Sigma} of sizes \code{c(n,length(lambda))} and \code{c(nrow(Psi),ncol(Psi),n)}.
}
\description{
Generates random draws from a Normal-Inverse-Wishart (NIW) distribution.
Can be used to compare prior to posterior parameter distributions.
}
\details{
The NIW distribution \eqn{p(\mu, \Sigma | \lambda, \kappa, \Psi, \nu)} is defined as
\deqn{\Sigma \sim W^{-1}(\Psi, \nu), \quad \mu | \Sigma \sim N(\lambda, \Sigma/\kappa).}
}
\examples{
d <- 4 # number of dimensions
nu <- 7 # degrees of freedom
Psi <- crossprod(matrix(rnorm(d^2), d, d)) # scale
lambda <- rnorm(d)
kappa <- 2
n <- 1e4

niw.sim <- rniw(n, lambda, kappa, Psi, nu)

# diagonal elements of Sigma^{-1} are const * chi^2
S <- apply(niw.sim$Sigma, 3, function(M) diag(solve(M)))

ii <- 2
const <- solve(Psi)[ii,ii]
hist(S[ii,], breaks = 100, freq = FALSE,
    main = parse(text = paste0("\\"Histogram of \\"*(Sigma^{-1})[", ii,ii,"]")),
    xlab = parse(text = paste0("(Sigma^{-1})[", ii,ii,"]")))
curve(dchisq(x/const, df = nu)/const,
     from = min(S[ii,]), to = max(S[ii,]), col = "red", add = TRUE)

# elements of mu have a t-distribution
mu <- niw.sim$mu

ii <- 4
const <- sqrt(Psi[ii,ii]/(kappa*(nu-d+1)))
hist(mu[,ii], breaks = 100, freq = FALSE,
    main = parse(text = paste0("\\"Histogram of \\"*mu[", ii, "]")),
    xlab = parse(text = paste0("mu[", ii, "]")))
curve(dt((x-lambda[ii])/const, df = nu-d+1)/const, add = TRUE, col = "red")
}
\seealso{
\code{\link{rwish}}, \code{\link{niw.mom}}, \code{\link{niw.coeffs}}.
}

