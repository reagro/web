:orphan:

R packages
==========

Most of the R packages we used can be installed from `CRAN <https://cran.r-project.org/>__` with `install.packages`. For example, 

.. code:: r

    install.packages("randomForest")


There is a number of packages that we use that have not been released to CRAN yet. These packages, including `terra`, `predicts` and `reagro`, are on github and can be install from there as shown below. 

.. code:: r

    source("https://install-github.me/reagro/reagro")
    source("https://install-github.me/rspatial/predicts")
	

Installing the `terra` package can be more challanging because it needs to be compiled. That is not a problem on linux or mac, but on windows you first need to install `Rtools <https://cran.r-project.org/bin/windows/Rtools/>`__. This is for the time being. By the end of the year the packages that require compilation will be on CRAN. Or a compiled download will be made available. The package can be installed like this:


.. code:: r
    
	library(devtools)
	devtools::install.github("rspatial/terra")


