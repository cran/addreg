\name{addreg}
\alias{addreg}
\title{
Additive Regression for Discrete Data
}
\concept{Binomial regression}
\concept{Poisson regression}
\concept{CEM algorithm}
\description{
\code{addreg} fits additive (identity-link) Poisson and binomial
regression models using a stable combinatorial EM algorithm.
}
\usage{
addreg(formula, mono = NULL, family, data, standard, subset, na.action,
start = NULL, offset, control = list(...), model = TRUE, warn = TRUE, ...)
}
\arguments{
  \item{formula}{
	an object of class "\code{\link{formula}}"
  (or one that can be coerced into that class): a symbolic
  description of the model to be fitted. The details of
  model specification are given under 'Details'.  Note that
  the model must contain an intercept, and 2nd-order terms
  (such as interactions) or above are currently not supported
  - see "Note".
}
  \item{mono}{
	a vector indicating which terms in
  \code{formula} should be restricted to have a
  monotonically non-decreasing relationship with the
  outcome. May be specified as names or indices of the
  terms.
}
  \item{family}{
	a description of the error distribution to
  be used in the model. This can be a character string
  naming a family function, a family function or the result
  of a call to a family function (see
  \code{\link[stats]{family}} for details of family
  functions), but here it is restricted to be \code{poisson} or
  \code{binomial} family with identity-link.
}
  \item{data}{
	an optional data frame, list or environment
  (or object coercible by \code{\link{as.data.frame}} to a
  data frame) containing the variables in the model. If not
  found in \code{data}, the variables are taken from
  \code{environment(formula)}, typically the environment
  from which \code{addreg} is called.
}
  \item{standard}{
	a numeric vector of length equal to the
  number of cases, where each element is a positive
  constant that (multiplicatively) standardizes the fitted
  value of the corresponding element of the response
  vector. Ignored for binomial family (two-column
  specification of response should be used instead).
}
  \item{subset}{
	an optional vector specifying a subset of
  observations to be used in the fitting process.
}
  \item{na.action}{
  a function which indicates what should happen with the data
  contain \code{NA}s. The default is set be the \code{na.action}
  setting of \code{\link{options}}, and is \code{\link{na.fail}}
  if that is unset. The 'factory-fresh' default is \code{\link{na.omit}}.
  Another possible value is \code{NULL}, no action. Value
  \code{\link{na.exclude}} can be useful.
}
  \item{start}{
	starting values for the parameters in the
  linear predictor.
}
  \item{offset}{
	this can be used to specify an \emph{a
  priori} known component to be included in the linear
  predictor during fitting. This should be NULL or a
  \emph{non-negative} numeric vector of length equal to the number of cases.
  One or more \code{\link{offset}} terms can be included in
  the formula instead or as well, and if more than one is
  specified their sum is used. See
  \code{\link{model.offset}}.
  
	Ignored for binomial family.
}
  \item{control}{
	list of parameters for controlling the
  fitting process, passed to
  \code{\link{addreg.control}}.
}
  \item{model}{
	a logical value indicating whether \emph{model frame} 
	(and, for binomial models, the equivalent Poisson model)
	should be included as a component of the returned value.
}
  \item{warn}{
	a logical indicating if warnings should be
  provided for non-convergence or boundary values.
}
  \item{\dots}{
	arguments to be used to form the default
  \code{control} argument if it is not supplied directly.
}
}
\details{
\code{addreg} fits a generalized linear model (GLM) with a
Poisson or binomial error distribution and identity-link
function. Predictors are assumed to be continuous, unless
they are of class \code{\link{factor}}, or are character or
logical (in which case they are converted to
\code{factor}s). Specifying a predictor as monotonic using
the \code{mono} argument means that for continuous terms,
the associated coefficient will be restricted to be
non-negative, and for categorical terms, the coefficients
will be non-decreasing in the order of the factor
\code{levels}. This allows semi-parametric monotonic regression
functions, in the form of unsmoothed step-functions. For 
smooth regression functions see \code{\link{addreg.smooth}}.

As well as allowing monotonicity constraints, the function 
is useful when a standard GLM routine, such as
\code{glm}, fails to converge with an identity-link Poisson
or binomial model. Note that the results may be slightly
different to those produced by \code{glm}, because the
covariate space in which the parameter constraints must
hold is different. \code{addreg} considers the Cartesian
product of the observed range of covariate values, whereas
\code{glm} only considers the observed covariate
combinations.

The computational method is a combinatorial EM algorithm
(Marschner (2014)) which accommodates the parameter
contraints in the model and is more stable than iteratively
reweighted least squares. A collection of restricted
parameter spaces is defined which covers the full parameter
space, and the EM algorithm is applied within each
restricted parameter space in order to find a collection of
restricted maxima of the log-likelihood function, from
which can be obtained the global maximum over the full
parameter space. See Marschner (2010) and Donoghoe and 
Marschner (2014) for further details.
}
\value{
\code{addreg} returns an object of class \code{"addreg"},
which inherits from classes \code{"glm"} and \code{"lm"}.
The function \code{\link{summary.addreg}} can be used 
to obtain or print a summary of the results.

The generic accessor functions \code{\link{coefficients}},
\code{fitted.values} and \code{residuals} can be used to
extract various useful features of the value returned by
\code{addreg}. Note that \code{effects} will not work.

An object of class \code{"addreg"} is a list containing the
same components as an object of class \code{"glm"} (see the
"Value" section of \code{\link{glm}}), but without
\code{contrasts}, \code{qr}, \code{R} or \code{effects}
components. It also includes: 
\item{loglik}{the maximized log-likelihood.}
\item{aic.c}{a small-sample corrected
version of Akaike's \emph{An Information Criterion}
(Hurvich, Simonoff and Tsai (1998)). This is used by
\code{\link{addreg.smooth}} to choose the optimal number of
knots for smooth terms.} 
\item{xminmax}{the minimum and maximum observed values
for each of the continuous covariates, to help define
the covariate space of the model.}

As well as, for Poisson models:
\item{nn.coefficients}{estimated coefficients associated
with the non-negative parameterization corresponding to the
MLE.} 
\item{nn.x}{non-negative model matrix associated with
\code{nn.coefficients}.} 
\item{standard}{the \code{standard} argument.} 

Or, for binomial models:
\item{model.addpois}{if requested, the \code{addreg} object for the associated identity-link
Poisson model.}
}
\references{
Donoghoe, M.W. and I.C. Marschner (2014): "Stable computational methods
for additive binomial models with application to adjusted risk differences", 
\emph{Computational Statistics & Data Analysis}, 80, 184--196.

Hurvich, C.M., J.S. Simonoff and C.-L. Tsai (1998): "Smoothing parameter selection
in nonparametric regression using an improved Akaike information criterion,"
\emph{Journal of the Royal Statistical Society: Series B}, 60, 271--293.

Marschner, I.C. (2010): "Stable computation of maximum
likelihood estimates in identity-link Poisson regression,"
\emph{Journal of Computational and Graphical Statistics},
19, 666--683.

Marschner, I.C. (2014): "Combinatorial EM algorithms,"
\emph{Statistics and Computing}, 24, 921--940.
}
\author{
Mark Donoghoe \email{Mark.Donoghoe@mq.edu.au}
}
\note{
Due to the way the covariate space is defined in the CEM algorithm,
specifying interactions in the formula is not currently supported 
by \code{addreg}. 2-way interactions between factors can be
included by calculating a new factor term that has levels
corresponding to all possible combinations of the factor
levels. See the Example.
}
\examples{
require(glm2)
data(crabs)

#============================================================================
#  identity-link Poisson model with periodic non-convergence when glm is used
#============================================================================

crabs.boot <- crabs[crabs$Rep1,-c(5:6)]
crabs.boot$width.shifted <- crabs.boot$Width - min(crabs$Width)

fit.glm <- glm(Satellites ~ width.shifted + factor(Dark) + factor(GoodSpine),
  family = poisson(identity), data = crabs.boot, start = rep(1,4), 
  control = glm.control(trace = TRUE))
  
fit.addreg <- addreg(formula(fit.glm), family = poisson, data = crabs.boot,
  trace = 1)
summary(fit.addreg)
vcov(fit.addreg)
confint(fit.addreg)
summary(predict(fit.addreg), type = "response")

fit.addreg2 <- addreg(update(formula(fit.glm), ~ . - factor(GoodSpine)),
  family = poisson, data = crabs.boot, trace = 1)
anova(fit.addreg2, fit.addreg, test = "LRT")
}
\keyword{ models }
\keyword{ regression }
