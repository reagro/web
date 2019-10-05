Modeling methods
================

In this part we present a variety of modeling methods that are relevant for Regional Agronomy. We discuss the conceptual underpinning of different approaches and show how they can be used to make spatial predictions.

We start with a chapter on 	statistical modeling <statistical.html>`__. This reviews the choices to made when fitting a regression type model (whether using traditional linear regression or "machine learning" algorithms). The emphasis is on the use of these models for prediction (not inference). We discuss general model diagnostic tools such as variable importance plots and partial response plots, and to model evaluation such as cross-validation.

The next chapter on `spatial modeling <spatial.html>`__ builds on the statistical modeling chapter to discuss predicting spatial patterns. It describes methods that take point based observations (e.g. from soil samples or household surveys) to estimate values at any location trough interpolation, spatial distribution modeling, or hybrid approaches. It continues with a chapter on the use of satellite remote sensing data; and ends with a section on downscaling methods to estimate higher resolution data.

The last two chapters are on mechanistic models. The mathematical form of these models is based on understanding of the processes of interest. These include relatively simple models such as the QUEFTS model to assess soil fertility and rather complex dynamic models to simulate crop growth or a crop disease.
  
  

.. toctree::
   :maxdepth: 5
   :hidden:

   statistical/index
   spatial/index
   mechanistic/index
