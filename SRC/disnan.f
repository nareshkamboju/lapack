*> \brief \b DISNAN
*
*  =========== DOCUMENTATION ===========
*
* Online html documentation available at 
*            http://www.netlib.org/lapack/explore-html/ 
*
*> Download DISNAN + dependencies 
*> <a href="http://www.netlib.org/cgi-bin/netlibfiles.tgz?format=tgz&filename=/lapack/lapack_routine/disnan.f"> 
*> [TGZ]</a> 
*> <a href="http://www.netlib.org/cgi-bin/netlibfiles.zip?format=zip&filename=/lapack/lapack_routine/disnan.f"> 
*> [ZIP]</a> 
*> <a href="http://www.netlib.org/cgi-bin/netlibfiles.txt?format=txt&filename=/lapack/lapack_routine/disnan.f"> 
*> [TXT]</a> 
*
*  Definition
*  ==========
*
*       LOGICAL FUNCTION DISNAN( DIN )
* 
*       .. Scalar Arguments ..
*       DOUBLE PRECISION   DIN
*       ..
*  
*  Purpose
*  =======
*
*>\details \b Purpose:
*>\verbatim
*>
*> DISNAN returns .TRUE. if its argument is NaN, and .FALSE.
*> otherwise.  To be replaced by the Fortran 2003 intrinsic in the
*> future.
*>
*>\endverbatim
*
*  Arguments
*  =========
*
*> \param[in] DIN
*> \verbatim
*>          DIN is DOUBLE PRECISION
*>          Input to test for NaN.
*> \endverbatim
*>
*
*  Authors
*  =======
*
*> \author Univ. of Tennessee 
*> \author Univ. of California Berkeley 
*> \author Univ. of Colorado Denver 
*> \author NAG Ltd. 
*
*> \date November 2011
*
*> \ingroup auxOTHERauxiliary
*
*  =====================================================================
      LOGICAL FUNCTION DISNAN( DIN )
*
*  -- LAPACK auxiliary routine (version 3.2.2) --
*  -- LAPACK is a software package provided by Univ. of Tennessee,    --
*  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
*     November 2011
*
*     .. Scalar Arguments ..
      DOUBLE PRECISION   DIN
*     ..
*
*  =====================================================================
*
*  .. External Functions ..
      LOGICAL DLAISNAN
      EXTERNAL DLAISNAN
*  ..
*  .. Executable Statements ..
      DISNAN = DLAISNAN(DIN,DIN)
      RETURN
      END
