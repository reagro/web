Introduction
============

This book provides a practical introduction to the new discipline of *Regional Agronomy*. We present concepts, methods, tools, and workflows to study spatial and temporal variation in crop production across large areas. Understanding this type of variation is increasingly important in guiding business, research, development, and policy. For example, it provides the basis for location-based farmer advisory services; it essential to the operation of agricultural index insurance programs; and it can help in identifying research and development needs for, and potential benefit from, new technology. 

*Regional Agronomy* is the study of crop production across large regions. It is departure from the traditional *Field Agronomy* in which research focuses on variation between and within fields, using well-managed trials at experimental stations. *Field Agronomy* remains of fundamental importance, but it can be difficult to directly use the results of such research to solve practical problems across large areas. *Regional Agronomy* addresses this problem, by building on *FIeld Agronomy* and on other disciplines such as Economics and Spatial Data Science.


Agronomy at scale
-----------------

Oftentimes, what seem to be important agronomic advances, never get used on farms, and investments in research and development do not have the postive impact one might have expected. Why is that? Is it that the research results do not apply to the conditions that farmers face? Are we even doing the right research? Or is it a problem of communication? How can we be more efficient in reaching farmers? How can we make agronomy more effective *at scale*?

A fundamental challenge is that agriculture is highly site-specific --- much more than any other economic activity. Car factories can look the same, no matter where they are. In contrast, every field and every farm is a little, or a lot, different from another in its abiotic, biotic, social and economic conditions. To understand problems and opportunities for crop production across large areas, we need to take into account the spatial and temporal variability that shapes farming. 

This is not a new insight. For example, in 1928, Karl Klages argued for the incorporation of "crop ecology" and "ecological crop geography" into the `agronomy curriculum <https://dl.sciencesocieties.org/publications/aj/abstracts/20/4/AJ0200040336?access=0&view=pdf>`__. In his book "Ecological Crop Geography", Klages (`1949 <https://archive.org/stream/ecologicalcropge032678mbp/ecologicalcropge032678mbp_djvu.txt>`__) described the geographical distribution of crops, and the social and ecological factors that explain these patterns. 


Big data for small farmers?
---------------------------

What *has* changed is the availability of data and computational tools. This includes spatial data from satellites, and large quantities of farm household data from surveys. Much research data is now `openly available <https://gardian.bigdata.cgiar.org/>`__ and can be aggregated and used for new purposes. Computing tools like *R* allow for the easy integration of these data with more specialized algorithms, such as crop models, or machine learning.

So there is a lot of promise. But there is also a lot of hype. Press-releases suggest that satellite images and "deep-learning" are to solve all our problems. While smart use of data has become an indispensable part of modern research and business --- there are major unanswered questions about how to best use these new tools, and when and where they are most appropriate, or not appropriate. How do we integrate these new approaches with time-tested existing practices? How do we make data science relevant for agricultural development?

Our aim is to help you acquire some of the skills you need to apply some of these new methods, but also to do the research needed to better understand their applications, shortcomings, and benefits. 

The methods and concepts we discuss apply anywhere, but our emphasis and examples are mostly from Africa and South Asia. Many of the techniques we discuss are also relevant for precision farming --- that is, the study and management of variation *within* agricultural fields; but we focus on variation across larger areas: variation between fields, within entire regions, or countries.


Before you start
----------------

This book is intended for students, practitioners and researchers in agricultural research and development. To be able to understand the materials presented, you need to have a basic understanding of agronomy. We assume that you have studied how different environmental, biological, and human factors affect crop production. If you do not have that background, you can still read this book and learn from it, particularly if you have a science degree. But in that case you will need to look up some terms, and study some background materials. Where practical, we point you to materials for further reading.

You also need to have a basic understand of the *R* `computing language and environment <https://www.r-project.org/>`__. We use *R* in the examples throughout this book. If you are new to *R* you can look at this `introduction <https://rspatial.org/intr>`__. As we use a lot of spatial (geographic) data, we should first learn about the basics of that too, for example by going through `these materials <https://rspatial.org/terra/spatial>`__. 

We use *R* because that is the most widely used computing environment in Regional Agronomy, and because it is free software. In some cases there would be alternative, and perhaps better ways to implement a particular workflow, but in our worked examples we mostly stick to *R* to keep it straightforward to understand and reproduce them. We generally do not refer to stand-alone software that must be used through a user-interface although we will have links to a few web-based visual apps. While such software is very useful, or even indispensable, for some types of work, we strive for fully reproducible workflows. That means that all data manipulation must be done with scripts. We do include a few examples about dealing with large quantities of (satellite) data using cloud computing services such as Google Earth Engine and Amazon Web Services. 


Authors
-------
Contributing authors are `listed here </authors.html>`__ and at the top of each chapter. The book is edited by Robert Hijmans and Jordan Chamberlin. You can contact us at <rhijmans@ucdavis.edu> and <j.chamberlin@cgiar.org>. 


Acknowledgments
---------------

This work was partly supported by a grant to `CIMMYT <https://www.cimmyt.org/>`__ by the `Bill and Melinda Gates Foundation <https://www.gatesfoundation.org/>`__.

