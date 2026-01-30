
/*
 * Include Files
 *
 */
#if defined(MATLAB_MEX_FILE)
#include "tmwtypes.h"
#include "simstruc_types.h"
#else
#define SIMPLIFIED_RTWTYPES_COMPATIBILITY
#include "rtwtypes.h"
#undef SIMPLIFIED_RTWTYPES_COMPATIBILITY
#endif



/* %%%-SFUNWIZ_wrapper_includes_Changes_BEGIN --- EDIT HERE TO _END */
#include <math.h>
/* %%%-SFUNWIZ_wrapper_includes_Changes_END --- EDIT HERE TO _BEGIN */
#define u_width 1
#define y_width 1
#define y_1_width 1

/*
 * Create external references here.  
 *
 */
/* %%%-SFUNWIZ_wrapper_externs_Changes_BEGIN --- EDIT HERE TO _END */
/* extern double func(double a); */
/* %%%-SFUNWIZ_wrapper_externs_Changes_END --- EDIT HERE TO _BEGIN */

/*
 * Output function
 *
 */
extern "C" void exer6com_Outputs_wrapper(const real_T *u0,
			real_T *y0,
			real_T *y1,
			const real_T *xC,
			const real_T *L, const int_T p_width0,
			const real_T *cm, const int_T p_width1,
			const real_T *J, const int_T p_width2,
			const real_T *R, const int_T p_width3,
			const real_T *D, const int_T p_width4);

void exer6com_Outputs_wrapper(const real_T *u0,
			real_T *y0,
			real_T *y1,
			const real_T *xC,
			const real_T *L, const int_T p_width0,
			const real_T *cm, const int_T p_width1,
			const real_T *J, const int_T p_width2,
			const real_T *R, const int_T p_width3,
			const real_T *D, const int_T p_width4)
{
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_BEGIN --- EDIT HERE TO _END */
y0[0] = xC[0];   // current i
y1[0] = xC[1];   // angular speed omega(t)
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_END --- EDIT HERE TO _BEGIN */
}

/*
 * Derivatives function
 *
 */
extern "C" void exer6com_Derivatives_wrapper(const real_T *u0,
			real_T *y0,
			real_T *y1,
			real_T *dx,
			real_T *xC,
			const real_T *L, const int_T p_width0,
			const real_T *cm, const int_T p_width1,
			const real_T *J, const int_T p_width2,
			const real_T *R, const int_T p_width3,
			const real_T *D, const int_T p_width4);

void exer6com_Derivatives_wrapper(const real_T *u0,
			real_T *y0,
			real_T *y1,
			real_T *dx,
			real_T *xC,
			const real_T *L, const int_T p_width0,
			const real_T *cm, const int_T p_width1,
			const real_T *J, const int_T p_width2,
			const real_T *R, const int_T p_width3,
			const real_T *D, const int_T p_width4)
{
/* %%%-SFUNWIZ_wrapper_Derivatives_Changes_BEGIN --- EDIT HERE TO _END */
dx[0] = (u0[0] - R[0]*xC[0] - cm[0]*xC[1]) / L[0];
dx[1] = (cm[0]*xC[0] - D[0]*xC[1]) / J[0];
/* %%%-SFUNWIZ_wrapper_Derivatives_Changes_END --- EDIT HERE TO _BEGIN */
}

