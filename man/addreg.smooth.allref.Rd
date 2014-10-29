\name{addreg.smooth.allref}
\alias{addreg.smooth.allref}
\title{
Parametrization for CEM Algorithm with Smooth Terms
}
\description{
A workhorse function for \code{\link{addreg.smooth}},
\code{addreg.smooth.allref} takes the formula and data
for an identity-link GLM with smooth terms and produces a
list of all parameterizations needed for the CEM algorithm
associated with the semi-parametric part of the model.
}
\usage{
addreg.smooth.allref(object, data = environment(object), mono, family, 
  addreg.smooth.spec, num.knots)
}
\arguments{
  \item{object}{
	a \code{\link{terms}} object for the "\code{fake.formula}"
		associated with an \code{\link{addreg.smooth}} model
		(see \code{\link{interpret.addreg.smooth}}).
}
  \item{data}{
	a data frame created with \code{\link{get_all_vars}} for
	the \code{fake.formula}.
}
  \item{mono}{
		a vector indicating which terms in
  \code{fake.formula} should be restricted to have a
  monotonically non-decreasing relationship with the
  outcome. May be specified as names or indices of the
  terms.
}
  \item{family}{
	the \code{\link{family}} object for the \code{\link{addreg.smooth}}
	model.
}
  \item{addreg.smooth.spec}{
	details of the smooth terms in the formula; must be a list in the format returned
	by \code{\link{interpret.addreg.smooth}}.
}
  \item{num.knots}{
	a vector containing the number of interior knots to be used for
	each smooth term in the model (\code{NA} for \code{\link{Iso}} terms).
}
}
\details{
Semi-parametric models in \code{\link{addreg.smooth}} use an extended CEM algorithm 
by partioning the parameter space associated with the smooth terms into a
collection of restricted parameter spaces, each corresponding to a
restricted fully parametric model that can be fit using \code{\link{addreg}}.
The workhorse function \code{addreg.smooth.allref} creates the list of possible parameterizations of
each smooth term.

Isotonic terms and monotonic B-spline terms have only one parameterization: where
the minimum fitted value occurs at the minimum of the covariate range.

For Poisson models, general B-spline terms have \code{k + 3} parameterizations each
(where \code{k} is the number of internal knots), corresponding to the possible 
locations of the minimum of the smooth curve along the range of the covariate.

For binomial models, general B-spline terms have \code{factorial(k + 3)}
parameterizations, corresponding to the permutations of the coefficients.

\code{\link{addreg.smooth}} considers all possible combinations of the number of 
knots for each smooth term, and all possible combinations of the associated
parameterizations, and \code{\link{addreg.smooth.design}} creates the appropriate
formula and design matrix to be used in the call to \code{\link{addreg}}.
}
\value{
A list with components:
\item{allref}{a named list, with one component for each smooth term in
the model. Each component is itself a list, whose components
are each of the parameterizations for that term.}
\item{terms}{the \code{\link{terms}} component of \code{object}.}
\item{data}{the object passed into the \code{data} argument.}
\item{monotonic}{a named logical vector indicating which
components of \code{terms} are restricted to be
monotonically non-decreasing.}
}
\references{
Donoghoe, M.W. and I.C. Marschner (2014): "Smooth semi-parametric adjustment of rate 
differences, risk differences and relative risks," \emph{Proceedings of the 29th 
International Workshop on Statistical Modelling}, 1, 105--110.
}
\author{
Mark Donoghoe \email{Mark.Donoghoe@mq.edu.au}
}
\seealso{
\code{\link{addreg.smooth}}
}
\keyword{ misc }
