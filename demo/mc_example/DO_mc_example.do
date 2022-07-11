/*******************************************************************************
** Motne Carlo Experiments
** (C) Keisuke Kondo
** 
** [Reference]
** Kondo, K (2017) "Quantile approach for distinguishing agglomeration from firm
** selection in Stata," Mimeo
**
** [Contact]
** Email: kondo-keisuke@rieti.go.jp
** URL: https://keisukekondokk.github.io/
*******************************************************************************/

** Clear All
clear

** General Setting
local nobs = 20000
set matsize 10000
set obs `nobs'
gen lntfp = .
gen tfp_shdi = .
gen tfp_shditr = .

** Category: 0 and 1
gen id = _n
gen cat = .
replace cat = 1 if id > `nobs'/2
replace cat = 0 if id <= `nobs'/2
order id

/*
** Parameter Setting
** Relative Parameter: A, D, S
** Category 0 (Baseline): ** A_0 = 1, D_0 = 1, S_0 = 0.001
** Category 1: ** A_1 = D*A_0 + A, D_1 = D*D_0, S_1 = S_0 + (1-S_0)*S
*/
scalar dA = 0.1 /*TRUE VALUE of A*/
scalar dD = 1.2 /*TRUE VALUE of D*/
scalar dS = 0.1 /*TRUE VALUE of S*/
scalar dsig0 = sqrt(1)
scalar dsig1 = dsig0
scalar dsig1A = dsig1
scalar dsig1D = dD*dsig0
scalar dsig1AD = dsig1D
scalar dmu0 = 1
scalar dmu1 = dmu0
scalar dmu1A = dmu0 + dA
scalar dmu1AD = dD*dmu0 + dA
scalar dS0 = 0.001
scalar dS1 = dS0 + (1-dS0)*dS
scalar dz = invnormal(dS)
scalar db1 = dmu1 + dsig1*dz
scalar db1A = dmu1A + dsig1A*dz
scalar db1D = dmu1 + dsig1D*dz
scalar db1AD = dmu1AD + dsig1AD*dz


/***************************** 
** Monte Carlo Experiments
** DGP: Shift + Dilation + Truncation
*****************************/ 

** Random Number Generation
** DGP: Shift + Dilation
set seed 1234321
replace tfp_shdi = dmu0 + dsig0*invnormal(dS0 + runiform()*(1-dS0)) if cat == 0
replace tfp_shdi = dmu1AD + dsig1AD*invnormal(dS0 + runiform()*(1-dS0)) if cat == 1

** Random Number Generation
** DGP: Shift + Dilation + Truncation
set seed 1234321
replace tfp_shditr = dmu0 + dsig0*invnormal(dS0 + runiform()*(1-dS0)) if cat == 0
replace tfp_shditr = dmu1AD + dsig1AD*invnormal( dS1 + runiform()*(1-dS1) ) if cat == 1

** Set Variable
/*Choose One of Two DGP*/
/*DGP is "Shift + Dilation + Truncation" Below.*/
replace lntfp = tfp_shditr
sort cat lntfp 

** Display Time
disp "START: `c(current_time)' on `c(current_date)'"

** Estimation by Quantile Approach
** Model Specification: Shift + Dilation
** Misspecified Model: Upward bias for A, Downward bias for D
/*NOTE: This is the case of bvar(off).*/
estquant lntfp, cat(cat) sh di optech(nm)

** Estimation by Quantile Approach
** Model Specification: Shift + Dilation + Truncation
** Correctly Specified Model
/*NOTE: This is the case of bvar(off).*/
estquant lntfp, cat(cat) sh di tr optech(nm)
	
** Display Time
disp "END: `c(current_time)' on `c(current_date)'"

