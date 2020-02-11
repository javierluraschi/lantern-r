.globals <- new.env(parent = emptyenv())
.globals$lantern_started <- FALSE

lantern_default <- function() {
  "1.3.0"
}

lantern_start <- function(version = lantern_default()) {
  if (!lantern_installed()) {
    # stop("Torch is not installed, please run 'torch_install()'.")
  }
  
  if (.globals$lantern_started) return()
  
  lantern_lib <- file.path(lantern_install_path(), "liblantern.dylib")
 
  rcpp_lantern_init(lantern_lib)
  
  .globals$lantern_started <- TRUE
}

lantern_test <- function() {
  lantern_start()
  
  rcpp_lantern_test()
}