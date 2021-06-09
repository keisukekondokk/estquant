/*******************************************************************************
** (C) Keisuke KONDO
** Date: February 23, 2017
** 
** Program and Replication Codes for
** Kondo, K (2017) "Quantile approach for distinguishing agglomeration from firm
** selection in Stata," Mimeo
** 
** [Contact]
** Email: kondo-keisuke@rieti.go.jp
** URL: https://sites.google.com/site/keisukekondokk/
*******************************************************************************/
[Table of Contents]
1. Contents
2. Implement Stata Do-files


+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
1. Contents
- bootstrap
    Directory for stored bootstrapped estimates
- bvariable
    Directory to save bootstrapped variables
- fig
    Directory for figures
- log
    Directory for log files
- cdgpr_econometrica.do
    Replication code of Combes et al. (2012)
Note: The original data file is NOT INCLUDED in this directory.
      Please download the original replication file of Combes et al. (2012) 
      from the following URL:
https://www.econometricsociety.org/publications/econometrica/2012/11/01/productivity-advantages-large-cities-distinguishing

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
2. Implement Stata Do-files
   (a). Download and unzip supplemental zip file of Combes et al. (2012).
   (b). Move "cdgprdata.csv" in the unzipped folder to this folder.
   (c). Do "cdgpr_econometrica.do" on Stata.

