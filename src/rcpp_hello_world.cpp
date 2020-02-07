
#include <Rcpp.h>
#include "lantern/lantern.h"

using namespace Rcpp;

// [[Rcpp::export]]
void rcpp_lantern_init(std::string path) {
  std::string error;
  if (!lanternInit(path, &error))
    Rcpp::stop(error);
}

// [[Rcpp::export]]
void rcpp_lantern_test() {
    lanternTest();
}
