install_config <- list(
  "1.3.0" = list(
    "cpu" = list(
      "darwin" = list(
        "libtorch" = "https://download.pytorch.org/libtorch/cpu/libtorch-macos-1.3.0.zip"
      )
    )
  )
)

#' @export
torch_home <- function(version = "1.3.0") {
  normalizePath(file.path("~/libtorch", version), mustWork = FALSE)
}

torch_install_library <- function(library_name, library_url, install_path, filter) {
  library_extension <- tools::file_ext(library_url)
  temp_file <- tempfile(fileext = library_extension)
  temp_path <- tempfile()
  
  download.file(library_url, temp_file)
  
  uncompress <- if (identical(library_extension, "tgz")) untar else unzip
  
  uncompress(temp_file, exdir = temp_path)
  source_files <- dir(dir(temp_path, full.names = T), full.names = T)
  
  if (!is.null(filter)) source_files <- Filter(filter, source_files)
  
  file.copy(source_files, install_path, recursive = TRUE)
}

torch_installed <- function(version = "1.3.0") {
  install_path <- torch_home(version = version)
  dir.exists(install_path)
}

#' @export
torch_install <- function(version = "1.3.0", type = "cpu") {
  if (torch_installed(version = version)) {
    message("Torch ", version, " is already installed.")
    return(install_path)
  }
  
  install_path <- torch_home(version = version)
  dir.create(install_path)
  
  current_os <- tolower(Sys.info()[["sysname"]])
  
  if (!version %in% names(install_config))
    stop("Version ", version, " is not available, available versions: ",
         paste(names(install_config), collapse = ", "))
  
  if (!type %in% names(install_config[[version]]))
    stop("The ", type, " installation type is currently unsupported.")
  
  if (!current_os %in% names(install_config[[version]][[type]]))
    stop("The ", current_os, " operating system is currently unsupported.")
  
  install_info <- install_config[[version]][[type]][[current_os]]
  
  for (library_name in names(install_info)) {
    library_info <- install_info[[library_name]]
    
    if (!is.list(library_info)) library_info <- list(url = library_info, filter = "")
    
    torch_install_library(library_name = library_name,
                          library_url = library_info$url,
                          install_path = install_path,
                          filter = function(e) grepl(library_info$filter, e))
  }
  
  invisible(install_path)
}

#' @export
torch_uninstall <- function(version = "1.3.0") {
  torch_home <- torch_home(version = version)
  
  if (!dir.exists(torch_home)) {
    message("Torch ", version, " is not installed.")
    return()
  }
  
  unlink(torch_home, recursive = TRUE)
}
