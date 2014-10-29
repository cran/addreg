\name{summary.addreg}
\alias{summary.addreg}
\alias{print.summary.addreg}
\title{
Summarizing addreg Model Fits
}
\description{
These functions are all \code{\link{methods}} for class \code{addreg}
or \code{summary.addreg} objects.
}
\usage{
\method{summary}{addreg}(object, correlation = FALSE, ...)

\method{print}{summary.addreg}(x, digits = max(3L, getOption("digits") - 3L), 
signif.stars = getOption("show.signif.stars"), ...)
}
\arguments{
  \item{object}{
	an object of class \code{"addreg"}, usually from a call to \code{\link{addreg}}
	or \code{\link{addreg.smooth}}.
}
  \item{x}{
	an object of class \code{"summary.addreg"}, usually from a call to
	\code{summary.addreg}.
}
  \item{correlation}{
	logical; if \code{TRUE}, the correlation matrix of the estimated parameters is
	returned and printed.
}
  \item{digits}{
	the number of significant digits to use when printing.
}
  \item{signif.stars}{
	logical; if \code{TRUE}, 'significance stars' are printed for each coefficient.
}
  \item{\dots}{
	further arguments passed to or from other methods.
}
}
\details{
These perform the same function as \code{\link{summary.glm}} and \code{\link{print.summary.glm}},
producing similar results for \code{addreg} models. \code{print.summary.addreg} additionally prints 
the small-sample corrected AIC (\code{aic.c}), and the number of EM iterations for the parameterization 
corresponding to the MLE.

The dispersion used in calculating standard errors is fixed as \code{1} for binomial and Poisson
models.
}
\value{
\code{summary.addreg} returns an object of class \code{"summary.addreg"}, a list with components
\item{call}{the component from \code{object}.}
\item{family}{the component from \code{object}.}
\item{deviance}{the component from \code{object}.}
\item{aic}{the component from \code{object}.}
\item{aic.c}{the component from \code{object}.}
\item{df.residual}{the component from \code{object}.}
\item{null.deviance}{the component from \code{object}.}
\item{df.null}{the component from \code{object}.}
\item{iter}{the component from \code{object}.}
\item{deviance.resid}{the deviance residuals: see \code{\link{residuals.glm}}.}
\item{coefficients}{the matrix of coefficients, standard errors, z-values and p-values.}
\item{aliased}{included for compatability -- always \code{FALSE}.}
\item{dispersion}{the inferred/estimated dispersion.}
\item{df}{included for compatability -- a 3-vector of the number of coefficients,
the number of residual degrees of freedom, and the number of coefficients (again).}
\item{cov.unscaled}{the unscaled (\code{dispersion = 1}) estimated covariance
matrix of the estimated coefficients. \code{NaN} if \code{object$boundary == TRUE}.}
\item{cov.scaled}{ditto, scaled by \code{dispersion}.}
\item{correlation}{if \code{correlation} is \code{TRUE}, the estimated correlations
of the estimated coefficients. \code{NaN} if \code{object$boundary == TRUE}.}
}
\author{
Mark Donoghoe \email{Mark.Donoghoe@mq.edu.au}
}
\note{
If \code{object$boundary == TRUE}, the standard errors of the coefficients
are not valid, and a matrix of \code{NaN}s is returned by \code{\link{vcov.addreg}}.
}

\seealso{
\code{\link{addreg}}, \code{\link{summary.glm}}
}
\examples{
## For an example, see example(addreg)
}
\keyword{ models }
\keyword{ regression }
