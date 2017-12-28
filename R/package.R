#' upgrstuserv
#'
#' \emph{upgrstuserv} is an R package to simplify the upgrade process of RStudio Server.
#'
#' @details This package lets you check if there is a new version of RStudio Server.
#' If required, one can perform an upgrade. If you perform an upgrade of RStudio Server and an existing version of the server is currently
#' running, then the upgrade process will also ensure that active sessions are immediately migrated to
#' the new version. This includes the following behavior:
#'
#' \describe{
#' \item{}{Running R sessions are suspended so that future interactions with the server automatically launch the updated R session binary}
#' \item{}{Currently connected browser clients are notified that a new version is available and automatically refresh themselves.}
#' \item{}{The core server binary is restarted}
#' }
#'
#' @name upgrstuserv-package
#' @aliases upgrstuserv
#' @docType package
#' @title Convience functions to upgrade your RStudio Server
#' @author Marco Sciaini \email{msciain@@gmail.com}
#' @keywords package
#'

NULL


utils::globalVariables(c("."))

