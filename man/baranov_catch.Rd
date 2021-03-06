% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{baranov_catch}
\alias{baranov_catch}
\title{Baranov catch equation}
\usage{
baranov_catch(N, nat_mort, fish_mort)
}
\arguments{
\item{N}{population size}

\item{nat_mort}{instantaneous natural mortality}

\item{fish_mort}{instantaneous fishing mortality}
}
\description{
Returns catch for given F for population size N
with natural and fishing mortality M and F respectively
}
\details{
Based on code written by Bill de la Mare
}
