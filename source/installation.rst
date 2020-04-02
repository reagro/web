:orphan:

R packages
==========

Most of the R packages we used can be installed from `CRAN <https://cran.r-project.org/>`_ with ``install.packages``. For example, 

.. code:: r

    install.packages("terra")
    install.packages("randomForest")
    install.packages("Rquefts")
    install.packages("Rwofost")


We use a few packages that are not on CRAN yet: ``luna``, ``predicts``, ``geodata``, ``agro``, and ``agrodata``. These packages are on github and can be installed from there with the ``remotes`` package, as shown below. 

First install the ``remotes`` package if you do not have it.

.. code:: r

	install.packages("remotes")

Then use it to install the packages from github as shown below.


.. code:: r

    Sys.setenv(R_REMOTES_UPGRADE="never")
    remotes::install_github("reagro/agro")
    remotes::install_github("reagro/agrodata)	
    remotes::install_github("rspatial/luna")
    remotes::install_github("rspatial/predicts")
    remotes::install_github("rspatial/geodata")
    remotes::install_github("cropmodels/ecocrop")

