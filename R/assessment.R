#' Survey a population
#'
#' Wrapper for functions to obtain estimates of population size
#' during a simulation
#' @param control a control file
#' @param model a tempory file created by \code{\link{run_sim}}
#' @param year survey year
#' @export
do_assessment <- function(control, model, year){
  ## some checks
  ## could calculate the true (stratified) population size
  switch(control[["assess_pars"]]$type,
    tag = {
    ## Petersen estimate of abundance
      if(year<=2){
        est <- 0
      }else{
        est <- single_release(tags = sum(model$tags[year-1,]),
                              catch = round(sum(model$catch[year,])),
                              recaps = sum(model$recaps[year,]),
                              method = "Petersen",
                              unit = "numbers",
                              type = control[["harvest_pars"]]$ricker,
                              tag_mort = control[["tag_pars"]]$mort,
                              reporting = control[["tag_pars"]]$report,
                              nat_mort = control[["pop_pars"]]$nat_mort,
                              chronic_shed = control[["tag_pars"]]$shed)
      }
  },
  strat_tag = {
    ## add a stratifed estimator see Darroch, 1961. The Two-Sample Capture-
    ## Recapture Census when Tagging and Sampling are Stratified Biometrika, 48,
    ## 241-260
    warning("this method is not yet implemented, NA estimate is returned")
    est <- NA
  },
  ## survey a structured population
  survey = {
    ## estimate biomass with some error
    pop_size <- sum(model$N[year,])
    rand_norm <- max(rnorm(1, 1, control[["assess_pars"]]$cv), 0)
    est <- pop_size * rand_norm
  },
  ## survey a hcr population
  survey_hcr = {
    ## estimate biomass with some error
    pop_size <- model$N[year]
    rand_norm <- max(rnorm(1, 1, control[["assess_pars"]]$cv), 0)
    return(pop_size * rand_norm)
  })
  ## if a single estimate
  if(length(est)==1){
   est <- rep(est / control[["n_regions"]], control[["n_regions"]])
  }
  ## return the estimate
  est
}
