.globals <- new.env(parent = emptyenv())
.globals$lantern_started <- FALSE

lantern_default <- function() {
  "1.3.0"
}

lantern_start <- function(version = lantern_default()) {
  if (!torch_installed(version = version)) {
    stop("Torch is not installed, please run 'torch_install()'.")
  }
  
  if (.globals$lantern_started) return()
  
  torch_lib <- file.path(torch_home(version = version), "lib", "liblantern.dylib")
  
  rcpp_lantern_init(torch_lib)
  
  .globals$lantern_started <- TRUE
}

lantern_test <- function() {
  lantern_start()
  
  rcpp_lantern_test()
}