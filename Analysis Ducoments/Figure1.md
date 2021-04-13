---
sort: 1
title: "Mrakdown for Figure1"
author: "Xia Zhao"
output: html_document
code_folding:show
toc_float:TRUE
runtime:shiny
---

[`Return`](./)

# Background

This document describes the methodology for obtaining raw data and closed-reference OTU picking. All code is run either in R or bash.


```
:root {
  @for $level from 1 through 12 {
    @if $level % 4 == 0 {
      --toc-#{$level}: #{darken($theme-white, 4 * 8.8%)};
    } @else {
      --toc-#{$level}: #{darken($theme-white, $level % 4 * 8.8%)};
    }
  }
}
```


# Environment

```

library(data.table)
library(tidyverse)
library(ggthemes)
library(ggsci)
library(ggpubr)
library(survminer)
library(survival)
library(survivalROC)
library(reshape2)

```


**Highlight:**

```scss
:root {
  @for $level from 1 through 12 {
    @if $level % 4 == 0 {
      --toc-#{$level}: #{darken($theme-white, 4 * 8.8%)};
    } @else {
      --toc-#{$level}: #{darken($theme-white, $level % 4 * 8.8%)};
    }
  }
}
```


# Metadata

```
summary(data)

```


# R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

<details>
  <summary>点击时的区域标题</summary>
  ```bash
  echo "hello shell"
  echo "hello python"
  ```
</details>

```{r cars}
summary(cars)
```

# Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.






