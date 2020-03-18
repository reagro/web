Explanatory models
==================

In this section we discuss explanatory models. These are models with a mathematical structure that is imposed by the model developer, based on a presumed partial understanding of the processes of interest. Given the model structure, model parameters may be based on from experiments or from model tuning with known input and output data. Under this definition, a linear regression model may be considered a very simple example of a rule-based model, but here we concerned with models that are a bit more complex. 

The first chapters introduce dynamic crop simulation models. These models provide a quantitative description of the mechanisms that cause the behavior of a system of interest (a system is a limited part of reality that contains interrelated elements). They are often referred to as *mechanistic* and *explanatory* because the model developer uses known mechanisms sub-system processes, such as leaf-level photosynthesis, to construct a model of the system of interest, such as crop growth. To make best use of crop simulation in a meaningful way, it is important to have some general knowledge of crop ecology. You may need to consult background texts in crop ecology and crop modeling [insert references]. 

A prime benefit of these models is that you can use them to learn about (explain) the processes of interest. They can also be particularly useful to as *what-if* questions. For example to investigate the potential benefit of a new variety with a particular trait. These models can be used to refine our thinking before venturing into expensive breeding programs and field experiments. They are also used to estimate things that are hard to observe, such as crop yield potential and the possible effect of future climate change.   

Currently we have two chapters in this section, the first explains the general use of `WOFOST <wofost/index.html>`__ and the second one shows how you can `use it with spatial data <wofost-spatial.html>`_. Stay tuned for updates on LINTUL, APSIM, and other models. 

The next chapters discuss the use of `QUEFTS`. QUEFTS is a static rule-based model to estimate crop yield given a few soil properties and the amount of fertilizer applied, or to estimate the amount of fertilizer needed to reach a particular yield. First, we provide an `introduction to the basic ideas <quefts.html>`__ of the model, and the model input and output. The second chapter shows how to use QUEFTS with spatial data on soil properties to make `predictions for regions <quefts_spatial.html>`__.


.. toctree::
   :hidden: 
   
   wofost/index
   wofost-spatial
   quefts
   quefts-spatial
   lateblight-forecast
   lateblight-simulate

