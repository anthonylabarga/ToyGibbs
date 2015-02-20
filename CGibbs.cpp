#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
NumericMatrix Gibbs_Rcpp(int n, double alp) {
    Rcpp::NumericMatrix out(n,2);
  
    RNGScope scope;
    double x = 0;
    double y = 0;
    
    for (int i = 0; i < n; i++) {
	    x = R::rpois(y);
      y = R::rgamma(alp + x, .5);
      out(i,0) = x;
      out(i,1) = y;
    }
    return(out);
}