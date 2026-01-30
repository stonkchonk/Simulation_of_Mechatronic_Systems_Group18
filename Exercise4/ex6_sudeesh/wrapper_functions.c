/* Includes_BEGIN */
#include <math.h>
/* Includes_END */

/* Externs_BEGIN */
/* extern double func(double a); */
/* Externs_END */

void exer6com_Start_wrapper(real_T *xC,
                            const real_T *L, const int_T p_width0,
                            const real_T *cm, const int_T p_width1,
                            const real_T *J, const int_T p_width2,
                            const real_T *R, const int_T p_width3,
                            const real_T *D, const int_T p_width4)
{
/* Start_BEGIN */
/*
 * Custom Start code goes here.
 */
/* Start_END */
}

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
/* Output_BEGIN */
y0[0] = xC[0];   // current i
y1[0] = xC[1];   // angular speed omega(t)
/* Output_END */
}

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
/* Derivatives_BEGIN */
dx[0] = (u0[0] - R[0]*xC[0] - cm[0]*xC[1]) / L[0];
dx[1] = (cm[0]*xC[0] - D[0]*xC[1]) / J[0];
/* Derivatives_END */
}

void exer6com_Terminate_wrapper(real_T *xC,
                                const real_T *L, const int_T p_width0,
                                const real_T *cm, const int_T p_width1,
                                const real_T *J, const int_T p_width2,
                                const real_T *R, const int_T p_width3,
                                const real_T *D, const int_T p_width4)
{
/* Terminate_BEGIN */
/*
 * Custom Terminate code goes here.
 */
/* Terminate_END */
}
