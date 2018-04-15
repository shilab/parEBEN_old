# New strategies toward scaling up epistasis analysis on large-scale genomic datasets

<h4 align = "right">Jia Wen, Colby Ford, Daniel Janies, Xinghua Shi</h4>
<h4 align = "right">Department of Bioinformatics and Genomics, University of North Carolina at Charlotte, 28223 USA</h4>

## Abstract

Epistasis reflects the joint effect of more than one genes or variants on a phenotype. Epistasis is considered as an important genetic component for understanding complex phenotypes, however, it is challenging to identify epistasis in large-scale genomic data. This challenge contains two interlinked constraints. 1), the epistasis analysis on the high dimensional genomic data typically induces an over-saturated model that in turn demands efficient statistical methods to solve the model. 2) Even once the appropriate model and data are specified the solution requires intensive computing time to identify epistasis among two or more genes or variants. In this study, we present two strategies to scale up epistasis analysis using the empirical Bayesian Elastic Net (EBEN) method. First, we introduce a matrix strategy that pre-computes the correlation matrix using matrix multiplication.  This strategy narrows down the search space and thus accelerate the modeling process of epistasis analysis. Next, we develop a parallelized version of the EBEN package ([parEBEN](https://github.com/colbyford/parEBEN)) that affords multi-fold speed up in comparison with the classical EBEN method. Thus parEBEN enables application of the regression model to be applied to larger and more complex genomic datasets. As a use case, we applied these two strategies on a yeast cross dataset.  Our results indicated that we can identify a set of marginal and pairwise epistatic SNPs associated with quantitative traits relevant to yeast fitness. 


## Dataset

The yeast dataset is obtained from Bloom et al (2015) including 4,390 samples and 28,220 SNPs.


## Reference

[1] Bloom, Joshua S., et al. Genetic interactions contribute less than additive effects to quantitative trait variation in yeast. Nature communications 6 (2015).
