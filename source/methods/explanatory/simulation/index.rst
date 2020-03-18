Simulation Models
=================

Introduction
------------

This sub-section has chapters on dynamic crop simulation models. These models provide a quantitative description of the mechanisms that cause the behavior of a system of interest (a system is a limited part of reality that contains interrelated elements). They are often referred to as *mechanistic* and *explanatory*. These terms refer to the idea that the model developer uses known mechanisms sub-system processes, such as leaf-level photosynthesis, to construct a model of the system of interest, such as crop growth. 

The simulation models discussed here are *dynamic* meaning that they simulate a process over time using feedback mechanisms. At each time step *t*, **rate variables** (e.g. leaf biomass increase, or leaf area increase) are computed from **state variables** (e.g. total biomass, or leaf area index) driving variables such as temperature and solar radiation. After computing the rate variables, the state variables are updated, so that in the next time step *t+1* the conditions are different (there might be more leaf area). 

To be able to use crop simulation in a meaningful way, it is important to have some general knowledge of plant growth and development and of the environmental factors that influence them is a prerequisite. You may need to consult background texts in crop ecology and crop modeling [insert references]. 

A prime benefit of these models is that we can use them to learn about (explain) the processes of interest. They can also be particularly useful to as *what-if* questions. For example to investigate the potential benefit of a new variety with a particular trait. These models can be used to refine our thinking before venturing into expensive breeding programs and field experiments. They are also used to estimate things that are hard to observe, such as crop yield potential and the effect of future climate change.   

Currently we have one chapter in this section, explaining how to use the `WOFOST <wofost.html>`__  model. But stay tuned for updates on LINTUL, APSIM, and other models. 


Production levels
-----------------

To be able to deal with the ecological diversity of agriculture, three theoretical levels of crop growth can be distinguished: potential growth, limited growth and reduced growth. Each of these growth levels corresponds to a level of crop production: potential, limited and reduced production.

*Potential production* refers to a situation where crop growth is determined by irradiation, temperature, CO2 concentration, and plant characteristics. All other factors are assumed to be in ample supply. It represents the highest possible yield that can be achieved in a location, given a variety and a planting date. Usually, this ceiling can only be reached with a high input of fertilizers, irrigation and thorough pest control. In *limited production* levels, in addition to variables influencding potential production, the effect of the availability of water and plant nutrients is considered as well. Finally, *reduced production* also considers the effect of mostly biotic factors like weeds, pests and diseases on a crop. 

Reality rarely corresponds exactly to one of these growth/production levels, but it is useful to reduce specific cases to one of them, because this enables you to  focus on the principal environmental constraints to crop production, such as light, temperature, water or the macronutrients nitrogen, phosphorus and potassium. 



.. toctree::
   :hidden: 
   :maxdepth: 4
   
   wofost

