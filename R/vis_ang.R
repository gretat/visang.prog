#' Simple visual angle function
#'
#' Simple visual angle calculator for when the size of the screen is provided in centimeters
#'
#' @param size size of required item in pixels
#' @param scrW screen width in centimeters
#' @param resX screen width in pixels
#' @param vd visual distanc from screen
#'
#' @return
#'     \item{va}{The visual angle in degrees}
#'
#' @examples
#'
#'



vis_ang <- function(size, scrW, resX, vd){

  #get pix size
  pix_sz <- scrW / resX
  sz <- size * pix_sz

  #get visual angle
  va <- 2 * 180 * atan(sz / (2 * vd)) / pi
  return(va)

}
