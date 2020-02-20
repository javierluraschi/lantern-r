
#include <Rcpp.h>

#define LANTERN_HEADERS_ONLY
#include "lantern/lantern.h"

using namespace Rcpp;

// [[Rcpp::export]]
void rcpp_lantern_test() {
  lanternTest();
}
