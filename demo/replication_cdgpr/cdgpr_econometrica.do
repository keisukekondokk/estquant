/*******************************************************************************
** Qunatile Approach by Combes et al. (2012)
** Replication code used in Kondo (2017)
** (C) Keisuke Kondo
** 
** [References]
** Combes, P.P., Duranton, G., Gobillon, L., Puga, D., and Roux, S., (2012) 
** "The Productivity Advantages of Large Cities: Distinguishing Agglomeration
** From Firm Selection," Econometrica 80(6), pp. 2543-2594
** 
** Kondo, K (2017) "Quantile approach for distinguishing agglomeration from firm
** selection in Stata," Mimeo
** 
** [Required Package]
** mat2txt is required to save matrix data.
**
** [Contact]
** Email: kondo-keisuke@rieti.go.jp
** URL: https://sites.google.com/site/keisukekondokk/
*******************************************************************************/

** Log
log using "log/LOG_cdgpr_econometrica.smcl", replace

** Display Time
disp "START: `c(current_time)' on `c(current_date)'"

** Setting
set matsize 1000

** Load Data
*insheet using "cdgprdata.csv", comma clear /* Stata ver. 12 */
import delimited "cdgprdata.csv", delimiter(comma) varnames(1) clear
save "cdgprdata.dta", replace
use "cdgprdata.dta", clear

** Bootstrap Sampling for bvariable(on)
set seed 1010101
forvalue i = 1(1)100 {
	qui: preserve
	qui: bsample /*Without strata option*/
	*qui: bsample, strata(cat) /*With strata option*/
	qui: rename tfp_ols tfp_ols`i'
	qui: rename cat cat`i'
	qui: save "bvariable/DTA_bvariable`i'.dta", replace
	qui: restore
}

** Merge
forvalue i = 1(1)100 {
	qui: merge 1:1 _n using "bvariable/DTA_bvariable`i'.dta", keepusing(tfp_ols`i' cat`i')
	qui: drop _merge
}

** 
tab cat

** Sort
sort cat tfp_ols

** Cleaning Outliers
egen l_c1 = pctile(tfp_ols) if cat == 1, p(1)
egen u_c1 = pctile(tfp_ols) if cat == 1, p(99)
egen l_c2 = pctile(tfp_ols) if cat == 2, p(1)
egen u_c2 = pctile(tfp_ols) if cat == 2, p(99)

replace tfp_ols = . if tfp_ols < l_c1 & cat == 1
replace tfp_ols = . if tfp_ols > u_c1 & cat == 1
replace tfp_ols = . if tfp_ols < l_c2 & cat == 2
replace tfp_ols = . if tfp_ols > u_c2 & cat == 2

** Conditional mean of category=0 put to 0, shift of every observations
sum tfp_ols if cat == 1
scalar mean_tfp_cat1 = r(mean)
replace tfp_ols = tfp_ols - mean_tfp_cat1


** Cleaning Outliers for Bootstrap Samples
forvalue i = 1(1)100 {
	** Sort
	qui: sort cat`i' tfp_ols`i'

	** Cleaning Outliers
	qui: egen l`i'_c1 = pctile(tfp_ols`i') if cat`i' == 1, p(1)
	qui: egen u`i'_c1 = pctile(tfp_ols`i') if cat`i' == 1, p(99)
	qui: egen l`i'_c2 = pctile(tfp_ols`i') if cat`i' == 2, p(1)
	qui: egen u`i'_c2 = pctile(tfp_ols`i') if cat`i' == 2, p(99)

	qui: replace tfp_ols`i' = . if tfp_ols`i' < l`i'_c1 & cat`i' == 1
	qui: replace tfp_ols`i' = . if tfp_ols`i' > u`i'_c1 & cat`i' == 1
	qui: replace tfp_ols`i' = . if tfp_ols`i' < l`i'_c2 & cat`i' == 2
	qui: replace tfp_ols`i' = . if tfp_ols`i' > u`i'_c2 & cat`i' == 2

	** Conditional mean of category=0 put to 0, shift of every observations
	qui: sum tfp_ols`i' if cat`i' == 1
	qui: scalar mean_tfp`i'_cat1 = r(mean)
	qui: replace tfp_ols`i' = tfp_ols`i' - mean_tfp`i'_cat1

}


/***************************** 
** Estimation
*****************************/ 

** Estimation
estquant tfp_ols, cat(cat) sh bvar(on) brep(100) eps2(1e-8)
est store reg1
matrix mB1 = e(B)

estquant tfp_ols, cat(cat) sh di bvar(on) brep(100) eps2(1e-8)
est store reg2
matrix mB2 = e(B)

estquant tfp_ols, cat(cat) sh tr bvar(on) brep(100) eps2(1e-8)
est store reg3
matrix mB3 = e(B)

estquant tfp_ols, cat(cat) tr bvar(on) brep(100) eps2(1e-8)
est store reg4
matrix mB4 = e(B)

estquant tfp_ols, cat(cat) sh di tr bvar(on) brep(100) eps2(1e-8)
est store reg5
matrix mB5 = e(B)

** Summary
est tab reg1 reg2 reg3 reg4 reg5, /*
	*/ b(%12.3f) se(%12.3f) stats(N N1 N2 r2) stfmt(%12.3f) 

** Summary
est tab reg1 reg2 reg3 reg4 reg5, /*
	*/ b(%12.6f) se(%12.6f) stats(N N1 N2 r2) stfmt(%12.6f) 

	
** Save Results by mat2txt
forvalues i = 1(1)5 {
	qui: mat2txt, matrix(mB`i') saving("bootstrap/mB`i'.txt") format("%16.12f") replace
}


** Display Time
disp "END: `c(current_time)' on `c(current_date)'"

** End Log
log close
