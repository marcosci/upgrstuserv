#' new_serverversion
#'
#' @name new_serverversion
#'
#' @description Check if RStudio Server can be upgraded
#'
#' @details
#'
#' Fetches the version number from
#' \url{https://www.rstudio.com/products/rstudio/download-server/} and
#' \url{https://www.rstudio.com/products/rstudio/download/preview/}.
#' Compares it to the local version number and throws a message if the an
#' upgrade can be performed.
#'
#'
#' @examples
#' # check if your RStudio Server Preview versions can be upgraded
#' new_serverversion_preview()
#'
#' @importFrom magrittr "%>%"
#' @name new_serverversion
NULL

#' @rdname new_serverversion
#' @export
new_serverversion <- function() {

  info <- devtools::session_info()$platform$ui

  url <- 'https://www.rstudio.com/products/rstudio/download-server/'
  webpage <- xml2::read_html(url)
  pattern <- "\\d\\.\\d\\.\\d\\d\\d"

  online_version <- webpage %>%
    rvest::html_node("br+ code") %>%
    rvest::html_text() %>%
    stringr::str_extract(pattern) %>%
    .[[1]]

  local_version <- info %>%
    stringr::str_extract(pattern) %>%
    .[[1]]

  check_version <- utils::compareVersion(local_version, online_version)

  if (check_version == -1){
    message("You should consider an update of your RStudio Server version.")} else {
      message("Your current version of RStudio Server is up-to-date.")
    }

}


#' @rdname new_serverversion
#' @export
new_serverversion_preview <- function() {

  info <- devtools::session_info()$platform$ui

  url <- "https://www.rstudio.com/products/rstudio/download/preview/"
  webpage <- xml2::read_html(url)
  pattern <- "\\d\\.\\d\\.\\d\\d\\d"

  online_version <- webpage %>%
    rvest::html_node("td") %>%
    rvest::html_text() %>%
    stringr::str_extract(pattern) %>%
    .[[1]]

  local_version <- info %>%
    stringr::str_extract(pattern) %>%
    .[[1]]

  check_version <- utils::compareVersion(local_version, online_version)

  if (check_version == -1){
    message("You should consider an update of your RStudio Server version.")} else {
      message("Your current version of RStudio Server is up-to-date.")
    }

}
