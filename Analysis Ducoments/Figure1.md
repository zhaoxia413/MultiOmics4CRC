---
sort: 6
title: "Vignette Title"
author: "Vignette Author"
output: github_document
---

[`Return`](./)
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
[`Return`](./)
## GitHub Documents

This is an R Markdown format used for publishing markdown documents to GitHub. When you click the **Knit** button all R code chunks are run and a markdown file (.md) suitable for publishing to GitHub is generated.

## Including Code

You can include R code in the document as follows:
     
```{r cars}
     summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.


# Environment

<details>
<summary>
code
</summary>

     library(tidyverse)
     library(ggthemes)
     library(ggsci)
     library(ggpubr)
     library(survminer)
     library(survival)
     library(survivalROC)
     library(reshape2) 
     data<-fread("../../FBratio_paper/Phylum_cli.csv",data.table = F)
     hist(data$BMI)

</details>

