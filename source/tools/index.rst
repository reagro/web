Methods and Tools
=================

This section shows how you can use a variety of tools that are relevant for Regional Agronomy. We discuss the conceptual underpinning of different modeling methods and show how they can be used to make spatial predictions.

We start with a chapter on statistical modeling and prediction <statistical.html>`__. This reviews the choices to made when fitting a regression type model (whether using traditional linear regression or "machine learning" algorithms). The emphasis is on the use of these models for prediction (not inference). We discuss general model diagnostic tools such as variable importance plots and partial response plots, and to model evaluation such as cross-validation.

The next chapter on `spatial interpolation <spatial.html>`__ describes methods that take point based observations (e.g. from soil samples or household surveys) to estimate values at any location. It illustrates some of the techniques discussed in the previous chapter, and describes some specialized algorithms such as Kriging.  

Another situation is where we have areal data that is complete, but at a low resolution. The `downscaling <donwscaling.html>`__ chapter discusses ways to estimate higher resolution data.

The final chapter that builds on the statistical modeling methods is on the use of `remote sensing <remote-sensing/index.html>`__ data to map crop distribution and to estimate crop yield. 

The last two chapters are on `rule-based <rule-based.html/index.html>`__ models such as QUEFTS and on dynamic crop growth simulation models. 

  
.. This is the table of contents, must be here, but can be hidden so we can format how we like above.


.. toctree::
   :maxdepth: 3
   :hidden:

   statistical/index
   interpolation
   downscaling
   remote-sensing/index 
   rule-based/index
   simulation
