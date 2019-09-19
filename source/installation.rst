R packages
==========

`terra` is the main package for spatial data we use in this book. This is a simpler and faster replacement of the `raster` package. You can learn about `using terra here <https://rspatial.org/terra>`__ .



Installation
============

For installations from github, via `install_github` you need to first install the devtools package from CRAN

.. code:: r

	install.packages("devtools")


Now you can do 

.. code:: r
	
	devtools::install.github("reagro/reagro")


The following packages need a compiler. You will have one on linux or mac, but on windows you first need to install `Rtools <https://cran.r-project.org/bin/windows/Rtools/>`__. This is for the time being. By the end of the year the packages that require compilation will be on CRAN.


.. code:: r

	devtools::install.github("rspatial/terra")
	devtools::install.github("cropmodels/Rquefts")
	devtools::install.github("rspatial/geodata")


