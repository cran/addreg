\name{addreg-package}
\alias{addreg-package}
\docType{package}
\title{
Additive Regression for Discrete Data
}
\description{
Methods for fitting identity-link GLMs and GAMs for discrete data. The package uses EM-type
algorithms with more stable convergence properties than standard methods.
}
\details{
\tabular{ll}{
Package: \tab addreg\cr
Type: \tab Package\cr
Version: \tab 1.2\cr
Date: \tab 2014-10-29\cr
License: \tab GPL (>= 2)\cr
}
This package provides methods to fit generalized linear models (GLMs) and generalized additive
models (GAMs) with identity-link functions to discrete data using binomial and Poisson
models. Further releases are planned to incorporate other discrete distributions, including
the negative binomial and multinomial distributions. It has two primary functions: 
\code{\link{addreg}} and \code{\link{addreg.smooth}}, together with various supporting functions.

It is useful in two main situations. The first is when a standard GLM routine, such as
\code{\link{glm}}, fails to converge with such a model. The second is when a flexible
semi-parametric component is desired in these models. One of the main purposes of this
package is to provide parametric and semi-parametric adjustment of risk differences
and rate differences.

The computational method is a combinatorial EM algorithm (Marschner, 2014), 
which accommodates the parameter constraints and is more stable than iteratively
reweighted least squares. A collection of restricted parameter spaces is defined
which covers the full parameter space, and the EM algorithm is applied within each
restricted parameter space in order to find a collection of restricted maxima of
the log-likelihood function, from which can be obtained the global maximum over the
full parameter space.
}
\author{
Mark Donoghoe \email{Mark.Donoghoe@mq.edu.au}

Maintainer: Mark Donoghoe \email{Mark.Donoghoe@mq.edu.au}
}
\references{
Donoghoe, M.W. and I.C. Marschner (2014): "Stable computational methods
for additive binomial models with application to adjusted risk differences", 
\emph{Computational Statistics & Data Analysis}, 80, 184--196.

Donoghoe, M.W. and I.C. Marschner (2014): "Smooth semi-parametric adjustment of rate 
differences, risk differences and relative risks," \emph{Proceedings of the 29th 
International Workshop on Statistical Modelling}, 1, 105--110.

Marschner, I.C. (2010): "Stable computation of maximum likelihood estimates
in identity-link Poisson regression," \emph{Journal of Computational and 
Graphical Statistics}, 19, 666--683.

Marschner, I.C. (2014): "Combinatorial EM algorithms,"
\emph{Statistics and Computing}, 24, 921--940.
}
\keyword{ package }
\keyword{ regression }
\seealso{
\code{\link{glm}}
}
\examples{
## For examples, see example(addreg) and example(addreg.smooth)
}
