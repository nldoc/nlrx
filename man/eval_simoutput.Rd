% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eval_simoutput.R
\name{eval_simoutput}
\alias{eval_simoutput}
\title{Evaluate input/output integrity}
\usage{
eval_simoutput(nl)
}
\arguments{
\item{nl}{nl object with attached simulation output}
}
\description{
Evaluate input/output integrity
}
\details{
This function checks if the attached simulation output in the simoutput slot of the simdesign,
corresponds to the defined siminput matrix.

Warning messages are thrown if data is missing in the simoutput tibble.
Additionally, missing combinations of siminputrow and random seed for which no data was found can be reported as tibble.
Such a tibble can then be used directly to rerun missing combinations conveniently (see examples below)
}
\examples{
\dontrun{
# Check eval_simoutput for testdata nl_lhs:
nl <- nl_lhs
eval_simoutput(nl)

# Now remove one row of simoutput and check output:
nl <- nl_lhs
nl@simdesign@simoutput <- nl@simdesign@simoutput[-1,]
check <- eval_simoutput(nl)
check

# Rerun missing combinations within check tibble:
rerun <- purrr::map_dfr(seq(nrow(check)), function(x) {
  res <- run_nl_one(nl, siminputrow=check$siminputrow[x], seed=check$seed[x])
    return(res)
    }) \%>\%
      dplyr::bind_rows(., nl@simdesign@simoutput)


}

}
