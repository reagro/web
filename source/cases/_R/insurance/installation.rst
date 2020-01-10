:orphan:

R packages
==========

Most of the R packages we used can be installed from `CRAN <https://cran.r-project.org/>`__ with `install.packages`. For example, 

.. code:: r

    install.packages("randomForest")


There is a number of packages that we use that have not been released to CRAN yet. These packages, including `terra`, `predicts`, `phenorice` and `agrins`, are on github. Below are instructions on how to install them.

First install package dependencies

.. code:: r

   install.packages(c("Rcpp", "httr", "readr", "xml2", "jsonlite", "signal"))


To install the `terra`, `luna`, `agrins`, `geodata`, `predicts` and `phenorice` packages on windows, download the packages `here <https://gfc.ucdavis.edu/R>`__, and use the downloaded zip files to install the package "from a local file". 

You always need to install `terra` first.
   
On other platforms than windows, you can install `agrins`, `predicts`, and `phenorice` like this:

.. code:: r

   source("https://install-github.me/aginsurance/agrins")
   source("https://install-github.me/cropmodels/phenorice")
   source("https://install-github.me/rspatial/predicts")



To install  `terra` and `luna` on linux or mac do this:

.. code:: r
    
	library(devtools)
	devtools::install_github("rspatial/terra")


You can also do that on windows after you first install `Rtools <https://cran.r-project.org/bin/windows/Rtools/>`__. 


