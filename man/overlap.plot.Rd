% Generated by roxygen2 (4.0.1): do not edit by hand
\name{overlap.plot}
\alias{overlap.plot}
\title{Plot the overlap metric}
\usage{
overlap.plot(over.stat, nbreaks = 50, equal.axis = FALSE, species.names,
  col, mean.cred = TRUE, mean.cred.col = "green", xlab)
}
\arguments{
\item{over.stat}{an array with \code{dim(over.stat) = c(nspecies, nspecies, nreps)} containing \code{nreps} calculations}

\item{nbreaks}{number of breaks in the histogram. Defaults to 50.}

\item{equal.axis}{logical. If \code{TRUE}, all histograms in a given column of the output (corresponding to different Species \eqn{A} for the same Species \eqn{B}) are plotted on the same range.}

\item{species.names}{a vector of species names. Defaults to \code{dimnames(over.stat)[[1]]}.}

\item{col}{a vector of the colours in which each species will be drawn.}

\item{mean.cred}{logical. If \code{TRUE}, vertical lines for mean and 95\% credible intervals will be
included in the historgram of each overlap metric.}

\item{mean.cred.col}{colour of the mean and credible interval lines in the histogram.}

\item{xlab}{optional plot title, located on the bottom.  Default is no title.}
}
\value{
Returns a series of histograms illustrating the probability of pairwise species overlap.
}
\description{
Plots the posterior distribution of the niche region overlap metric calculated for
each pairwise combination of species.
}
\details{
This function uses the overlap metric information in \code{over.stat} calculated by \code{\link{overlap}}
to create 2-dimensional plots of interspecific niche region overlap.
}
\examples{
# fish data
data(fish)

# parameter draws from the "default" posteriors of each fish
nsamples <- 500
system.time({
 fish.par <- tapply(1:nrow(fish), fish$species,
                    function(ii) niw.post(nsamples = nsamples, X = fish[ii,2:4]))
})

# overlap calculation
system.time({
 over <- overlap(fish.par, nreps = nsamples, nprob = nsamples, alpha = c(.95, .99))
})

# overlap plot
clrs <- c("black", "red", "blue", "orange") # color for each species
ii <- 1 # which niche region alpha level to use
overlap.plot(over[,,,ii], col = clrs, mean.cred.col = "turquoise",
            xlab = paste0("Overlap Probability (\%) -- Niche Region Size: ",
                          dimnames(over)[[4]][ii]))
}
\seealso{
\code{\link{overlap}}, \code{\link{niw.post}}, \code{\link{niiw.post}}.
}

