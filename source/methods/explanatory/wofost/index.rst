WOFOST
======

WOFOST is a computer model that simulates growth and development of annual field crops `De Wit et al., 2019 <https://www.sciencedirect.com/science/article/pii/S0308521X17310107?via%3Dihub>`_. It can be used to estimate potential crop productivity for a given variety, and under specified soil and weather conditions. Such estimates are the basis for the assessment of options for regional agricultural production, or can be used for the analysis of variability and trends in crop yields.

In this chapter we explain *how* to use WOFOST, but we only provide very scant information on the concepts or algorithms on which the model is based. See `this document <https://wofost.readthedocs.io/en/latest/_downloads/3c9337e7ab23207e5a5819689c79a889/WOFOST_system_description.pdf>`_ for a detailed description of how WOFOST works. 

Like all models, WOFOST is a simplification of reality. In practice, crop yield is a result of the interaction of many ecological and crop management factors. In WOFOST, only a number of these are considered. It is thus very important to understand which these are. 

With WOFOST, you can calculate potential and water-limited production. In the current version, nutrient-limited production and yield reducing factors are not taken into account. In each model run, WOFOST simulates the growth of a specific crop, given the selected soil and weather data. For each simulation, you must select specific boundary conditions, which comprise, amongst others, of the crop planting date and the  soil's water status. 

Crop growth is simulated using daily weather data of many years and different parameters for each relevant soil type within a region.

Variation in timing of crop production can be taken into account by varying the starting date of the growing season and/or by choosing crop varieties with different growth duration. 


.. toctree::
   
   principles
   example
   weather
   crop
   soil
   control
   output   
   

