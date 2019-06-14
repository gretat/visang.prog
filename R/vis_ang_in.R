#' Simple visual angle function
#'
#' Simple visual angle calculator for when the size of the screen is provided in inches
#'
#' @param size size of required item in pixels
#' @param scrW screen width in inches
#' @param resX screen width in pixels
#' @param vd visual distanc from screen
#'
#' @return
#'     \item{va}{The visual angle in degrees}
#'
#'


vis_ang_in <- function(size, scrW, resX, vd){

  #get size in cm
  size_cm <- scrW * 2.54
  #get pix size
  pix_sz <- size_cm / resX
  sz <- size * pix_sz

  #get visual angle
  va <- 2 * 180 * atan(sz / (2 * vd)) / pi
  return(va)

}
