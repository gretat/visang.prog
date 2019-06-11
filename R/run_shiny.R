#' Run the visang Shiny App
#'
#' Runs the visang Shiny App, with optional additional arguments.
#'
#' @param ... optional arguments to `shiny::runApp()`
#'
#' @export

run_shiny <- function(...) {
  appDir <- system.file("shiny-app", package = "visang")
  if (appDir == "") {
    stop("Could not find the directory for the visang Shiny App. Try re-installing `visang`.")
  }
  shiny::runApp(appDir, ...)
}

