#' upgrade_server
#'
#' @name upgrade_server
#'
#' @description Upgrades your RStudio Server
#'
#' @details
#' Checks again if an upgrade is needed. If so, it downloads the newest .deb
#' file and installs it over the the older version. You must reload the window
#' in your browser and RStudio Server should inform you about the upgrade after
#' that.
#'
#' If you perform an upgrade of RStudio Server and an existing version of the server is currently
#' running, then the upgrade process will also ensure that active sessions are immediately migrated to
#' the new version. This includes the following behavior:
#'
#' \describe{
#' \item{}{Running R sessions are suspended so that future interactions with the server automatically launch the updated R session binary}
#' \item{}{Currently connected browser clients are notified that a new version is available and automatically refresh themselves.}
#' \item{}{The core server binary is restarted}
#' }
#'
#' @importFrom magrittr "%>%"
#' @name upgrade_server
NULL

# upgrade_server <- function() {
#
#   info <- devtools::session_info()$platform$ui
#
#   url <- 'https://www.rstudio.com/products/rstudio/download-server/'
#   webpage <- xml2::read_html(url)
#   pattern <- "\\d\\.\\d\\.\\d\\d\\d"
#
#   online_version <- webpage %>%
#     rvest::html_node("br+ code") %>%
#     rvest::html_text() %>%
#     stringr::str_extract(pattern) %>%
#     .[[1]]
#
#   local_version <- info %>%
#     stringr::str_extract(pattern) %>%
#     .[[1]]
#
#   check_version <- utils::compareVersion(local_version, online_version)
#
#   if (check_version == -1){
#
#     # fetch link for 64bit rstudio server preview .deb
#     wget_link <- webpage %>%
#       html_node(".callbox:nth-child(17) code:nth-child(3) a") %>%
#       html_attr("href")
#
#     # download into user home directory
#     system(paste("wget ", wget_link, " -P /home/$USER/", sep = " "))
#
#     # install
#     system("sudo -kS gdebi --non-interactive  /home/$USER/rstudio-server-*.deb", input=readline("Enter your password: "))
#
#     # remove .deb file
#     system("rm  /home/$USER/rstudio-server-*.deb")
#
#   } else {
#     message("Your current version of RStudio Server is up-to-date.")
#   }
#
# }


#' @rdname upgrade_server
#' @export
upgrade_server_preview <- function() {

  pattern <- "\\d\\.\\d\\.\\d\\d\\d"

  # get local version
  info <- devtools::session_info()$platform$ui
  local_version <- info %>%
    stringr::str_extract(pattern) %>%
    .[[1]]

  # fetch current online version
  url <- "https://www.rstudio.com/products/rstudio/download/preview/"
  webpage <- xml2::read_html(url)
  online_version <- webpage %>%
    rvest::html_node("br+ code") %>%
    rvest::html_text() %>%
    stringr::str_extract(pattern) %>%
    .[[1]]

  check_version <- utils::compareVersion(local_version, online_version)

  if (check_version == -1){

    # fetch link for 64bit rstudio server preview .deb
    wget_link <- webpage %>%
      rvest::html_node(".downloads:nth-child(13) tr:nth-child(2) td a") %>%
      rvest::html_attr("href")

    # download into user home directory
    system(paste("wget ", wget_link, " -P /home/$USER/", sep = " "))

    # install
    system("sudo -kS gdebi --non-interactive  /home/$USER/rstudio-server-*.deb", input=readline("Enter your password: "))

    # remove .deb file
    system("rm  /home/$USER/rstudio-server-*.deb")

  } else {
    message("Your current version of RStudio Server is up-to-date.")
  }

}
