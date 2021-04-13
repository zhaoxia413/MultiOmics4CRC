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

<script src="toggleR.js">
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

</script>

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

<details>
<summary>code</summary>
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
  </details>

<script>
(document).ready(function () {
  window.initializeSourceEmbed("Untitled.Rmd");
  window.initializeCodeFolding("show" === "show");
});
</script>

<div class="fluid-row" id="header">
<div class="btn-group pull-right">
<button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span>Code</span> <span class="caret"></span></button>
<ul class="dropdown-menu" style="min-width: 50px;">
<li><a id="rmd-show-all-code" href="#">Show All Code</a></li>
<li><a id="rmd-hide-all-code" href="#">Hide All Code</a></li>
<li><a id="rmd-download-source" href="#">Download Rmd</a></li>
</ul>
</div>
<h1 class="title toc-ignore">R Notebook</h1>
</div>


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
  <summary>code</summary>
  ```bash
  echo "hello shell"
  echo "hello python"
  ```
</details>

```
summary(cars)
```

# Including Plots

You can also embed plots, for example:

```
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.






