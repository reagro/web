:orphan:

R packages
==========

Most of the R packages we used can be installed from `CRAN <https://cran.r-project.org/>__` with `install.packages`. For example, 

.. code:: r

    install.packages("randomForest")


There is a number of packages that we use that have not been released to CRAN yet. These packages, including `terra`, `luna`, `predicts`, `agro`, `geodata`, and `phenorice` packages on windows, download the packages `here <https://gfc.ucdavis.edu/R>`__, and use the downloaded zip files to install the package "from a local file". 





are on github and can be install from there as shown below. 

.. code:: r

    source("https://install-github.me/reagro/reagro")
    source("https://install-github.me/rspatial/predicts")
	

Installing the `terra` package from source can be more challenging because it needs to be compiled. That is not a problem on linux or mac, but on windows you first need to install `Rtools <https://cran.r-project.org/bin/windows/Rtools/>`__. This is for the time being. 


You always need to install `terra` first.


By the end of the year the packages that require compilation will be on CRAN. Or a compiled download will be made available. The package can be installed like this:


.. code:: r
    
	library(devtools)
	devtools::install.github("rspatial/terra")


