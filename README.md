# ESTQUANT: Stata module to implement Quantile approach by Combes et al. (2012)

The `estquant` command implements the Quantile approach by Combes et al. (*Econometrica*, 2012).

## Install

### GitHub

```
net install estquant, replace from("https://raw.githubusercontent.com/keisukekondokk/estquant/main/")
```

### SSC

```
ssc install estquant, replace
```

## Documents
See [`doc`](./doc) directory.

<pre>
.
|-- estquant.pdf //Manual
</pre>

## Demo Files
See [`demo`](./demo) directory. There are two examples.

<pre>
.
|-- demo_cdgpr //Stata replication code for Combes et al. (2012)
|-- demo_mc //Monte Carlo experiment in Kondo (2016)
</pre>

## Source Files
See [`ado`](./ado) directory. There are `estquant.ado` and `estquant.sthlp` files. 

<pre>
.
|-- estquant.ado //Stata ado file
|-- estquant.sthlp //Stata help file
</pre>

## Terms of Use
Users (hereinafter referred to as the User or Users depending on context) of the content on this web site (hereinafter referred to as the "Content") are required to conform to the terms of use described herein (hereinafter referred to as the Terms of Use). Furthermore, use of the Content constitutes agreement by the User with the Terms of Use. The contents of the Terms of Use are subject to change without prior notice.

### Copyright
The copyright of the developed code belongs to Keisuke Kondo.

### Copyright of Third Parties
The code and data in the demo file are based on Combes et al. (2012). Users must confirm the terms of use of the original files developed by Combes et al. (2012), prior to using the Content.

### Licence
The developed code is released under the MIT Licence.

### Disclaimer 
- Keisuke Kondo makes the utmost effort to maintain, but nevertheless does not guarantee, the accuracy, completeness, integrity, usability, and recency of the Content.
- Keisuke Kondo and any organization to which Keisuke Kondo belongs hereby disclaim responsibility and liability for any loss or damage that may be incurred by Users as a result of using the Content. 
- Keisuke Kondo and any organization to which Keisuke Kondo belongs are neither responsible nor liable for any loss or damage that a User of the Content may cause to any third party as a result of using the Content
The Content may be modified, moved or deleted without prior notice.

## Acknowledgements
I thank Diego Puga for his helpful advice on the program code. I also thank Luigi Aldieri for his bug reporting. The estquant command fundamentally relies on the SAS program code of Combes et al. (2012).  

## Author
Keisuke Kondo  
Senior Fellow, Research Institute of Economy, Trade and Industry  
Email: kondo-keisuke@rieti.go.jp  
URL: https://keisukekondokk.github.io/  

## Reference
Combes, P.-P., G. Duranton, L. Gobillon, D. Puga, and S. Roux. (2012) The productivity advantages of large cities: Distinguishing agglomeration from firm selection. *Econometrica* 80(6): 2543-2594. DOI: https://doi.org/10.3982/ECTA8442

Kondo, K. (2017) "ESTQUANT: Stata module to implement Quantile approach by Combes et al," Statistical Software Components S458343, Boston College Department of Economics.  
URL: https://ideas.repec.org/c/boc/bocode/s458343.html  
