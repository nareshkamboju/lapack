*> \brief \b SGEBRD
*
*  =========== DOCUMENTATION ===========
*
* Online html documentation available at 
*            http://www.netlib.org/lapack/explore-html/ 
*
*> Download SGEBRD + dependencies 
*> <a href="http://www.netlib.org/cgi-bin/netlibfiles.tgz?format=tgz&filename=/lapack/lapack_routine/sgebrd.f"> 
*> [TGZ]</a> 
*> <a href="http://www.netlib.org/cgi-bin/netlibfiles.zip?format=zip&filename=/lapack/lapack_routine/sgebrd.f"> 
*> [ZIP]</a> 
*> <a href="http://www.netlib.org/cgi-bin/netlibfiles.txt?format=txt&filename=/lapack/lapack_routine/sgebrd.f"> 
*> [TXT]</a> 
*
*  Definition
*  ==========
*
*       SUBROUTINE SGEBRD( M, N, A, LDA, D, E, TAUQ, TAUP, WORK, LWORK,
*                          INFO )
* 
*       .. Scalar Arguments ..
*       INTEGER            INFO, LDA, LWORK, M, N
*       ..
*       .. Array Arguments ..
*       REAL               A( LDA, * ), D( * ), E( * ), TAUP( * ),
*      $                   TAUQ( * ), WORK( * )
*       ..
*  
*  Purpose
*  =======
*
*>\details \b Purpose:
*>\verbatim
*>
*> SGEBRD reduces a general real M-by-N matrix A to upper or lower
*> bidiagonal form B by an orthogonal transformation: Q**T * A * P = B.
*>
*> If m >= n, B is upper bidiagonal; if m < n, B is lower bidiagonal.
*>
*>\endverbatim
*
*  Arguments
*  =========
*
*> \param[in] M
*> \verbatim
*>          M is INTEGER
*>          The number of rows in the matrix A.  M >= 0.
*> \endverbatim
*>
*> \param[in] N
*> \verbatim
*>          N is INTEGER
*>          The number of columns in the matrix A.  N >= 0.
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
*> \ingroup realGEcomputational
*
*
*  Further Details
*  ===============
*>\details \b Further \b Details
*> \verbatim
*          See Further Details.
*>
*>  LDA     (input) INTEGER
*>          The leading dimension of the array A.  LDA >= max(1,M).
*>
*>  D       (output) REAL array, dimension (min(M,N))
*>          The diagonal elements of the bidiagonal matrix B:
*>          D(i) = A(i,i).
*>
*>  E       (output) REAL array, dimension (min(M,N)-1)
*>          The off-diagonal elements of the bidiagonal matrix B:
*>          if m >= n, E(i) = A(i,i+1) for i = 1,2,...,n-1;
*>          if m < n, E(i) = A(i+1,i) for i = 1,2,...,m-1.
*>
*>  TAUQ    (output) REAL array dimension (min(M,N))
*>          The scalar factors of the elementary reflectors which
*>          represent the orthogonal matrix Q. See Further Details.
*>
*>  TAUP    (output) REAL array, dimension (min(M,N))
*>          The scalar factors of the elementary reflectors which
*>          represent the orthogonal matrix P. See Further Details.
*>
*>  WORK    (workspace/output) REAL array, dimension (MAX(1,LWORK))
*>          On exit, if INFO = 0, WORK(1) returns the optimal LWORK.
*>
*>  LWORK   (input) INTEGER
*>          The length of the array WORK.  LWORK >= max(1,M,N).
*>          For optimum performance LWORK >= (M+N)*NB, where NB
*>          is the optimal blocksize.
*>
*>          If LWORK = -1, then a workspace query is assumed; the routine
*>          only calculates the optimal size of the WORK array, returns
*>          this value as the first entry of the WORK array, and no error
*>          message related to LWORK is issued by XERBLA.
*>
*>  INFO    (output) INTEGER
*>          = 0:  successful exit 
*>          < 0:  if INFO = -i, the i-th argument had an illegal value.
*>
*>
*>  The matrices Q and P are represented as products of elementary
*>  reflectors:
*>
*>  If m >= n,
*>
*>     Q = H(1) H(2) . . . H(n)  and  P = G(1) G(2) . . . G(n-1)
*>
*>  Each H(i) and G(i) has the form:
*>
*>     H(i) = I - tauq * v * v**T  and G(i) = I - taup * u * u**T
*>
*>  where tauq and taup are real scalars, and v and u are real vectors;
*>  v(1:i-1) = 0, v(i) = 1, and v(i+1:m) is stored on exit in A(i+1:m,i);
*>  u(1:i) = 0, u(i+1) = 1, and u(i+2:n) is stored on exit in A(i,i+2:n);
*>  tauq is stored in TAUQ(i) and taup in TAUP(i).
*>
*>  If m < n,
*>
*>     Q = H(1) H(2) . . . H(m-1)  and  P = G(1) G(2) . . . G(m)
*>
*>  Each H(i) and G(i) has the form:
*>
*>     H(i) = I - tauq * v * v**T  and G(i) = I - taup * u * u**T
*>
*>  where tauq and taup are real scalars, and v and u are real vectors;
*>  v(1:i) = 0, v(i+1) = 1, and v(i+2:m) is stored on exit in A(i+2:m,i);
*>  u(1:i-1) = 0, u(i) = 1, and u(i+1:n) is stored on exit in A(i,i+1:n);
*>  tauq is stored in TAUQ(i) and taup in TAUP(i).
*>
*>  The contents of A on exit are illustrated by the following examples:
*>
*>  m = 6 and n = 5 (m > n):          m = 5 and n = 6 (m < n):
*>
*>    (  d   e   u1  u1  u1 )           (  d   u1  u1  u1  u1  u1 )
*>    (  v1  d   e   u2  u2 )           (  e   d   u2  u2  u2  u2 )
*>    (  v1  v2  d   e   u3 )           (  v1  e   d   u3  u3  u3 )
*>    (  v1  v2  v3  d   e  )           (  v1  v2  e   d   u4  u4 )
*>    (  v1  v2  v3  v4  d  )           (  v1  v2  v3  e   d   u5 )
*>    (  v1  v2  v3  v4  v5 )
*>
*>  where d and e denote diagonal and off-diagonal elements of B, vi
*>  denotes an element of the vector defining H(i), and ui an element of
*>  the vector defining G(i).
*>
*> \endverbatim
*>
*  =====================================================================
      SUBROUTINE SGEBRD( M, N, A, LDA, D, E, TAUQ, TAUP, WORK, LWORK,
     $                   INFO )
*
*  -- LAPACK computational routine (version 3.3.1) --
*  -- LAPACK is a software package provided by Univ. of Tennessee,    --
*  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
*     November 2011
*
*     .. Scalar Arguments ..
      INTEGER            INFO, LDA, LWORK, M, N
*     ..
*     .. Array Arguments ..
      REAL               A( LDA, * ), D( * ), E( * ), TAUP( * ),
     $                   TAUQ( * ), WORK( * )
*     ..
*
*  =====================================================================
*
*     .. Parameters ..
      REAL               ONE
      PARAMETER          ( ONE = 1.0E+0 )
*     ..
*     .. Local Scalars ..
      LOGICAL            LQUERY
      INTEGER            I, IINFO, J, LDWRKX, LDWRKY, LWKOPT, MINMN, NB,
     $                   NBMIN, NX
      REAL               WS
*     ..
*     .. External Subroutines ..
      EXTERNAL           SGEBD2, SGEMM, SLABRD, XERBLA
*     ..
*     .. Intrinsic Functions ..
      INTRINSIC          MAX, MIN, REAL
*     ..
*     .. External Functions ..
      INTEGER            ILAENV
      EXTERNAL           ILAENV
*     ..
*     .. Executable Statements ..
*
*     Test the input parameters
*
      INFO = 0
      NB = MAX( 1, ILAENV( 1, 'SGEBRD', ' ', M, N, -1, -1 ) )
      LWKOPT = ( M+N )*NB
      WORK( 1 ) = REAL( LWKOPT )
      LQUERY = ( LWORK.EQ.-1 )
      IF( M.LT.0 ) THEN
         INFO = -1
      ELSE IF( N.LT.0 ) THEN
         INFO = -2
      ELSE IF( LDA.LT.MAX( 1, M ) ) THEN
         INFO = -4
      ELSE IF( LWORK.LT.MAX( 1, M, N ) .AND. .NOT.LQUERY ) THEN
         INFO = -10
      END IF
      IF( INFO.LT.0 ) THEN
         CALL XERBLA( 'SGEBRD', -INFO )
         RETURN
      ELSE IF( LQUERY ) THEN
         RETURN
      END IF
*
*     Quick return if possible
*
      MINMN = MIN( M, N )
      IF( MINMN.EQ.0 ) THEN
         WORK( 1 ) = 1
         RETURN
      END IF
*
      WS = MAX( M, N )
      LDWRKX = M
      LDWRKY = N
*
      IF( NB.GT.1 .AND. NB.LT.MINMN ) THEN
*
*        Set the crossover point NX.
*
         NX = MAX( NB, ILAENV( 3, 'SGEBRD', ' ', M, N, -1, -1 ) )
*
*        Determine when to switch from blocked to unblocked code.
*
         IF( NX.LT.MINMN ) THEN
            WS = ( M+N )*NB
            IF( LWORK.LT.WS ) THEN
*
*              Not enough work space for the optimal NB, consider using
*              a smaller block size.
*
               NBMIN = ILAENV( 2, 'SGEBRD', ' ', M, N, -1, -1 )
               IF( LWORK.GE.( M+N )*NBMIN ) THEN
                  NB = LWORK / ( M+N )
               ELSE
                  NB = 1
                  NX = MINMN
               END IF
            END IF
         END IF
      ELSE
         NX = MINMN
      END IF
*
      DO 30 I = 1, MINMN - NX, NB
*
*        Reduce rows and columns i:i+nb-1 to bidiagonal form and return
*        the matrices X and Y which are needed to update the unreduced
*        part of the matrix
*
         CALL SLABRD( M-I+1, N-I+1, NB, A( I, I ), LDA, D( I ), E( I ),
     $                TAUQ( I ), TAUP( I ), WORK, LDWRKX,
     $                WORK( LDWRKX*NB+1 ), LDWRKY )
*
*        Update the trailing submatrix A(i+nb:m,i+nb:n), using an update
*        of the form  A := A - V*Y**T - X*U**T
*
         CALL SGEMM( 'No transpose', 'Transpose', M-I-NB+1, N-I-NB+1,
     $               NB, -ONE, A( I+NB, I ), LDA,
     $               WORK( LDWRKX*NB+NB+1 ), LDWRKY, ONE,
     $               A( I+NB, I+NB ), LDA )
         CALL SGEMM( 'No transpose', 'No transpose', M-I-NB+1, N-I-NB+1,
     $               NB, -ONE, WORK( NB+1 ), LDWRKX, A( I, I+NB ), LDA,
     $               ONE, A( I+NB, I+NB ), LDA )
*
*        Copy diagonal and off-diagonal elements of B back into A
*
         IF( M.GE.N ) THEN
            DO 10 J = I, I + NB - 1
               A( J, J ) = D( J )
               A( J, J+1 ) = E( J )
   10       CONTINUE
         ELSE
            DO 20 J = I, I + NB - 1
               A( J, J ) = D( J )
               A( J+1, J ) = E( J )
   20       CONTINUE
         END IF
   30 CONTINUE
*
*     Use unblocked code to reduce the remainder of the matrix
*
      CALL SGEBD2( M-I+1, N-I+1, A( I, I ), LDA, D( I ), E( I ),
     $             TAUQ( I ), TAUP( I ), WORK, IINFO )
      WORK( 1 ) = WS
      RETURN
*
*     End of SGEBRD
*
      END
