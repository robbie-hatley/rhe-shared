
#define __INLINE_CPP_STANDARD_HEADERS 1
#define __INLINE_CPP_NAMESPACE_STD 1


#define __INLINE_CPP 1
#ifndef bool
#include <iostream>
#endif
extern "C" {
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "INLINE.h"
}
#ifdef bool
#undef bool
#include <iostream>
#endif

#include <memory>
#include <iostream>
#include <string>
#include <sstream>
#include <limits>
#undef seed
#include <algorithm>
#include <vector>
#include <math.h>
#include <unordered_map>
#include <ctime>
#include <ratio>
#include <chrono>
#undef do_open
#undef do_close
#include "jpcre2.hpp"
typedef jpcre2::select<char>::Regex regex;
typedef jpcre2::SIZE_T regexsize;
# 0 "/home/aragorn/Data/Celephais/Programming-Notes/_Inline/build/eval_62_cac1/Filters255619.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "/home/aragorn/Data/Celephais/Programming-Notes/_Inline/build/eval_62_cac1/Filters255619.c"



# 1 "/usr/share/perl5/site_perl/RPerl/HelperFunctions.h" 1



# 1 "/usr/share/perl5/site_perl/rperltypes_mode.h" 1
# 5 "/usr/share/perl5/site_perl/RPerl/HelperFunctions.h" 2
# 33 "/usr/share/perl5/site_perl/RPerl/HelperFunctions.h"
int RPerl_SvBOKp(SV* input_sv);
int RPerl_SvUIOKp(SV* input_sv);
int RPerl_SvIOKp(SV* input_sv);
int RPerl_SvNOKp(SV* input_sv);
int RPerl_SvCOKp(SV* input_sv);
int RPerl_SvPOKp(SV* input_sv);
int RPerl_SvAROKp(SV* input_avref);
int RPerl_SvHROKp(SV* input_hvref);

SV* RPerl_AV_ELEMENT(pTHX_ AV* av, SSize_t index);
void RPerl_object_property_init(SV* initee);





int RPerl__HelperFunctions__MODE_ID() { return 2; }
# 5 "/home/aragorn/Data/Celephais/Programming-Notes/_Inline/build/eval_62_cac1/Filters255619.c" 2


int RPerl_SvBOKp(SV* input_sv) { return((SvIOK(input_sv) && ((SvIV(input_sv) == 0) || (SvIV(input_sv) == 1)))); }
int RPerl_SvUIOKp(SV* input_sv) { return((SvIOK(input_sv) && (SvIV(input_sv) >= 0))); }
int RPerl_SvIOKp(SV* input_sv) { return(SvIOKp(input_sv)); }
int RPerl_SvNOKp(SV* input_sv) { return(SvNOKp(input_sv)); }
int RPerl_SvCOKp(SV* input_sv) { return((SvPOK(input_sv) && (strlen((char*) SvPV_nolen(input_sv)) == 1))); }
int RPerl_SvPOKp(SV* input_sv) { return(SvPOKp(input_sv)); }
int RPerl_SvAROKp(SV* input_avref) { return((SvROK(input_avref) && (SvTYPE(SvRV(input_avref)) == SVt_PVAV))); }
int RPerl_SvHROKp(SV* input_hvref) { return((SvROK(input_hvref) && (SvTYPE(SvRV(input_hvref)) == SVt_PVHV))); }

SV* RPerl_AV_ELEMENT(pTHX_ AV* av, SSize_t index) {
 SV** svp = av_fetch(av, index, 0);
 if(svp != NULL)
  return *svp;
 else
  return sv_newmortal();
}



void RPerl_object_property_init(SV* initee)
{
 dSP;
 PUSHMARK(SP);
 XPUSHs(initee);
 PUTBACK;
 call_pv("Dumper", G_SCALAR);

}

MODULE = eval_62_cac1        PACKAGE = main  

PROTOTYPES: DISABLE

int
RPerl_SvBOKp(input_sv)
	SV *	input_sv
    
int
RPerl_SvUIOKp(input_sv)
	SV *	input_sv
    
int
RPerl_SvIOKp(input_sv)
	SV *	input_sv
    
int
RPerl_SvNOKp(input_sv)
	SV *	input_sv
    
int
RPerl_SvCOKp(input_sv)
	SV *	input_sv
    
int
RPerl_SvPOKp(input_sv)
	SV *	input_sv
    
int
RPerl_SvAROKp(input_avref)
	SV *	input_avref
    
int
RPerl_SvHROKp(input_hvref)
	SV *	input_hvref
    
void
RPerl_object_property_init(initee)
	SV *	initee
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	RPerl_object_property_init(initee);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

int
RPerl__HelperFunctions__MODE_ID()
    