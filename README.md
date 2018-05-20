# A Parallelized Strategy for Epistasis Analysis Based on Empirical Bayesian Elastic Net Models

<h4 align = "right">Jia Wen*, Colby Ford*, Daniel Janies, Xinghua Shi</h4>
<h4 align = "right">Department of Bioinformatics and Genomics, University of North Carolina at Charlotte, 28223 USA</h4>

## Abstract

Epistasis reflects the distortion that the combination effect of two or more genes or variants from the sum effect of individual gene or variant on a quantitative trait. Epistasis is considered as an important genetic component for understanding complex phenotypes. However, it is challenging to identify epistasis in large-scale genomic data. This challenge lies in two interlinked constraints. 1). The epistasis analysis on the high dimensional genomic data typically induces an over-saturated model that in turn demands efficient statistical methods to solve the model. 2). Even once the appropriate model and data are specified the solution requires intensive computing time to identify epistasis among two or more variants or genes due to the combinatorial problem. In this study, we present two strategies to scale up epistasis analysis using the empirical Bayesian Elastic Net (EBEN) method. First, we introduce a matrix strategy that pre-computes the correlation matrix using matrix multiplication. This strategy narrows down the search space and thus accelerates the modeling process of epistasis analysis. Next, we develop a parallelized version of the \textit{EBEN} package (\textit{parEBEN}) that affords multi-fold speed up in comparison with the classical EBEN method. Thus \textit{parEBEN} enables epistasis analysis of larger and more complex genomic datasets. As a use case, we applied these two strategies on a yeast genomic dataset. Our results indicated that we can identify a set of marginal and pairwise epistatic effects of genetic variants associated with quantitative traits relevant to yeast fitness. 


## Dataset

The yeast dataset is obtained from Bloom et al (2015) including 4,390 samples and 28,220 SNPs [1].


## Reference

[1] Bloom, Joshua S., et al. Genetic interactions contribute less than additive effects to quantitative trait variation in yeast. Nature communications 6 (2015).
