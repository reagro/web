Modeling methods
================

In this part we present a variety of modeling methods that are relevant for Regional Agronomy. We discuss the conceptual underpinning of different approaches and show how they can be used to make spatial predictions.

There are different kinds of models. Distinction can be made between mathematical and non-mathematical models. Non-mathematical models include, for example, maps and scale models of buildings. Mathematical models can be divided in statistical (descriptive) models and explanatory (deterministic, process) models.

We start with a section on `statistical modeling <statistical/index.html>`__. The chapters provide some of the basic ideas that you need to understand to be able to fit a regression type model (whether using traditional linear regression or "machine learning" algorithms). The emphasis is on the use of these models for prediction (not inference). We discuss general model diagnostic tools such as variable importance plots and partial response plots, and to model evaluation such as cross-validation.

The second section is introduces `explanatory <explanatory/index.html>`__ models. The mathematical form of these models is based on understanding of the processes of interest. These include relatively simple models such as the QUEFTS model to assess soil fertility and rather complex dynamic simulation models of crop growth or a crop disease.

  
The last section on `spatial modeling <spatial/index.html>`__ builds on the previous sections to discuss predicting spatial patterns. It describes methods that take point based observations (e.g. from soil samples or household surveys) to estimate values at any location. It continues with a chapter on the use of satellite remote sensing data; and ends with a chapter on downscaling methods to estimate higher resolution data.
  

.. toctree::
   :maxdepth: 10
   :hidden:

   statistical/index
   explanatory/index
   spatial/index
