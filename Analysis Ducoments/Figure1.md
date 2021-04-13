---
sort: 1
---

---
title: "An Example Using the Tufte Style"
author: "Xia Zhao"
output:
  tufte::tufte_handout: default
  tufte::tufte_html: default
---

# Mrakdown for Figure1

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

<script src="toggleR.js"></script> 
```{r}
summary(cars)
```
---
title: &quot;Habits&quot;
output:
  html_document:
    code_folding: hide
---

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


```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

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

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

# Metadata


## Including Plots

