
#include <Rcpp.h>
#include "lantern/lantern.h"

using namespace Rcpp;

// [[Rcpp::export]]
void init(std::string path) {
  std::string error;
  if (!lanternInit(path, &error))
    Rcpp::stop(error);
}

// [[Rcpp::export]]
List rcpp_hello_world() {

    CharacterVector x = CharacterVector::create( "foo", "bar" )  ;
    NumericVector y   = NumericVector::create( 0.0, 1.0 ) ;
    List z            = List::create( x, y ) ;
    
    lanternPrint();

    return z ;
}
