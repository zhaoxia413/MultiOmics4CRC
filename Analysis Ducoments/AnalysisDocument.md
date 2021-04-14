-   [1 Introduction](#introduction)
-   [2 Clinical](#clinical)
-   [3 Samples sequending statistics](#samples-sequending-statistics)
-   [4 Vsisualization](#vsisualization)

=======================================================================
[`Return`](./)

1 Introduction
==============

<table>
<tr>
<td bgcolor="#AFEEEE">
<font size=4>This is introduction</font>
</td>
</tr>
</table>
<details>
<summary>
<font size=4>Requires</font>
</summary>

    library(tidyverse)
    library(ggthemes)
    library(ggsci)
    library(ggpubr)
    library(survminer)
    library(survival)
    library(survivalROC)
    library(reshape2)
    library(data.table)
    library(ggExtra)
    library(cowplot)
    library(ComplexHeatmap)
    library(scico)
    library(colorspace)
    library(RColorBrewer)
    library(lubridate)
    source("../R_function/colors.R")
    source("../R_function/surv_plot.R")
    theme_set(theme_cowplot())
    "%ni%" <- Negate("%in%")
    options(stringsAsFactors = F)

</details>

2 Clinical
==========

<a href="../Data/Data/clinical.csv" target="csv">Clinical.csv</a>

    cli<-fread("../Data/Data/clinical.csv",data.table = F)
    knitr::kable(cli,digits = 1,row.names = 1)

<table>
<colgroup>
<col style="width: 1%" />
<col style="width: 4%" />
<col style="width: 3%" />
<col style="width: 3%" />
<col style="width: 7%" />
<col style="width: 2%" />
<col style="width: 2%" />
<col style="width: 3%" />
<col style="width: 3%" />
<col style="width: 1%" />
<col style="width: 2%" />
<col style="width: 3%" />
<col style="width: 3%" />
<col style="width: 4%" />
<col style="width: 3%" />
<col style="width: 3%" />
<col style="width: 3%" />
<col style="width: 2%" />
<col style="width: 3%" />
<col style="width: 5%" />
<col style="width: 3%" />
<col style="width: 6%" />
<col style="width: 7%" />
<col style="width: 3%" />
<col style="width: 1%" />
<col style="width: 1%" />
<col style="width: 3%" />
<col style="width: 3%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: left;">patientID</th>
<th style="text-align: left;">Response</th>
<th style="text-align: left;">Effect</th>
<th style="text-align: right;">Hand_food_syndrom</th>
<th style="text-align: right;">Rash</th>
<th style="text-align: right;">Fever</th>
<th style="text-align: right;">Diarrhea</th>
<th style="text-align: right;">Gender</th>
<th style="text-align: right;">Age</th>
<th style="text-align: right;">BMI</th>
<th style="text-align: right;">History</th>
<th style="text-align: right;">Smoking</th>
<th style="text-align: right;">Dringking</th>
<th style="text-align: right;">anitEGFR</th>
<th style="text-align: right;">antiVEGF</th>
<th style="text-align: right;">LiverM</th>
<th style="text-align: right;">LungM</th>
<th style="text-align: right;">LymphM</th>
<th style="text-align: right;">PeritonealM</th>
<th style="text-align: right;">OtherM</th>
<th style="text-align: right;">MetastasisNum</th>
<th style="text-align: right;">PathologicalType</th>
<th style="text-align: right;">Location</th>
<th style="text-align: right;">PFS</th>
<th style="text-align: right;">OS</th>
<th style="text-align: right;">PFStime</th>
<th style="text-align: right;">OStime</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">1</td>
<td style="text-align: left;">Patient02</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">69</td>
<td style="text-align: right;">20.4</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1.6</td>
<td style="text-align: right;">15.5</td>
</tr>
<tr class="even">
<td style="text-align: left;">2</td>
<td style="text-align: left;">Patient03</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">PR</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">51</td>
<td style="text-align: right;">26.0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">11.4</td>
<td style="text-align: right;">15.8</td>
</tr>
<tr class="odd">
<td style="text-align: left;">3</td>
<td style="text-align: left;">Patient04</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">55</td>
<td style="text-align: right;">28.3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2.2</td>
<td style="text-align: right;">7.1</td>
</tr>
<tr class="even">
<td style="text-align: left;">4</td>
<td style="text-align: left;">Patient05</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">44</td>
<td style="text-align: right;">21.5</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2.0</td>
<td style="text-align: right;">6.3</td>
</tr>
<tr class="odd">
<td style="text-align: left;">5</td>
<td style="text-align: left;">Patient06</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">SD</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">37</td>
<td style="text-align: right;">25.9</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3.8</td>
<td style="text-align: right;">12.4</td>
</tr>
<tr class="even">
<td style="text-align: left;">6</td>
<td style="text-align: left;">Patient08</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">64</td>
<td style="text-align: right;">24.7</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2.0</td>
<td style="text-align: right;">3.9</td>
</tr>
<tr class="odd">
<td style="text-align: left;">7</td>
<td style="text-align: left;">Patient09</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">PR</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">37</td>
<td style="text-align: right;">20.7</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">7.7</td>
<td style="text-align: right;">10.6</td>
</tr>
<tr class="even">
<td style="text-align: left;">8</td>
<td style="text-align: left;">Patient10</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">SD</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">44</td>
<td style="text-align: right;">19.3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">4.2</td>
<td style="text-align: right;">10.1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">9</td>
<td style="text-align: left;">Patient11</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">SD</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">57</td>
<td style="text-align: right;">25.1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">7.3</td>
<td style="text-align: right;">10.4</td>
</tr>
<tr class="even">
<td style="text-align: left;">10</td>
<td style="text-align: left;">Patient12</td>
<td style="text-align: left;">NE</td>
<td style="text-align: left;">NE</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">39</td>
<td style="text-align: right;">21.4</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3.7</td>
<td style="text-align: right;">10.3</td>
</tr>
<tr class="odd">
<td style="text-align: left;">11</td>
<td style="text-align: left;">Patient13</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">PR</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">46</td>
<td style="text-align: right;">21.4</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">6.3</td>
<td style="text-align: right;">10.3</td>
</tr>
<tr class="even">
<td style="text-align: left;">12</td>
<td style="text-align: left;">Patient14</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">57</td>
<td style="text-align: right;">21.4</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1.2</td>
<td style="text-align: right;">2.7</td>
</tr>
<tr class="odd">
<td style="text-align: left;">13</td>
<td style="text-align: left;">Patient16</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">PR</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">66</td>
<td style="text-align: right;">25.3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8.3</td>
<td style="text-align: right;">9.6</td>
</tr>
<tr class="even">
<td style="text-align: left;">14</td>
<td style="text-align: left;">Patient17</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">61</td>
<td style="text-align: right;">23.9</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2.0</td>
<td style="text-align: right;">6.8</td>
</tr>
<tr class="odd">
<td style="text-align: left;">15</td>
<td style="text-align: left;">Patient18</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">64</td>
<td style="text-align: right;">21.3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1.9</td>
<td style="text-align: right;">9.6</td>
</tr>
<tr class="even">
<td style="text-align: left;">16</td>
<td style="text-align: left;">Patient19</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">SD</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">61</td>
<td style="text-align: right;">25.4</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">6.6</td>
<td style="text-align: right;">7.5</td>
</tr>
<tr class="odd">
<td style="text-align: left;">17</td>
<td style="text-align: left;">Patient20</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">65</td>
<td style="text-align: right;">21.2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1.2</td>
<td style="text-align: right;">3.1</td>
</tr>
<tr class="even">
<td style="text-align: left;">18</td>
<td style="text-align: left;">Patient21</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">53</td>
<td style="text-align: right;">22.7</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1.7</td>
<td style="text-align: right;">9.0</td>
</tr>
<tr class="odd">
<td style="text-align: left;">19</td>
<td style="text-align: left;">Patient22</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">52</td>
<td style="text-align: right;">27.3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2.0</td>
<td style="text-align: right;">9.0</td>
</tr>
<tr class="even">
<td style="text-align: left;">20</td>
<td style="text-align: left;">Patient23</td>
<td style="text-align: left;">NE</td>
<td style="text-align: left;">NE</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">49</td>
<td style="text-align: right;">21.3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">4.9</td>
<td style="text-align: right;">8.3</td>
</tr>
<tr class="odd">
<td style="text-align: left;">21</td>
<td style="text-align: left;">Patient24</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">PR</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">56</td>
<td style="text-align: right;">18.8</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">6.7</td>
<td style="text-align: right;">8.3</td>
</tr>
<tr class="even">
<td style="text-align: left;">22</td>
<td style="text-align: left;">Patient25</td>
<td style="text-align: left;">NE</td>
<td style="text-align: left;">NE</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">49</td>
<td style="text-align: right;">21.1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8.2</td>
<td style="text-align: right;">8.2</td>
</tr>
<tr class="odd">
<td style="text-align: left;">23</td>
<td style="text-align: left;">Patient26</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">SD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">53</td>
<td style="text-align: right;">24.0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">5.2</td>
<td style="text-align: right;">5.2</td>
</tr>
<tr class="even">
<td style="text-align: left;">24</td>
<td style="text-align: left;">Patient29</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">55</td>
<td style="text-align: right;">20.0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1.9</td>
<td style="text-align: right;">7.3</td>
</tr>
<tr class="odd">
<td style="text-align: left;">25</td>
<td style="text-align: left;">Patient30</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">53</td>
<td style="text-align: right;">24.7</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1.6</td>
<td style="text-align: right;">7.9</td>
</tr>
<tr class="even">
<td style="text-align: left;">26</td>
<td style="text-align: left;">Patient31</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">44</td>
<td style="text-align: right;">19.8</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1.1</td>
<td style="text-align: right;">3.7</td>
</tr>
<tr class="odd">
<td style="text-align: left;">27</td>
<td style="text-align: left;">Patient32</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">SD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">65</td>
<td style="text-align: right;">23.4</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">4.3</td>
<td style="text-align: right;">7.6</td>
</tr>
<tr class="even">
<td style="text-align: left;">28</td>
<td style="text-align: left;">Patient33</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">42</td>
<td style="text-align: right;">23.9</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1.9</td>
<td style="text-align: right;">6.7</td>
</tr>
<tr class="odd">
<td style="text-align: left;">29</td>
<td style="text-align: left;">Patient34</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">57</td>
<td style="text-align: right;">26.8</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2.8</td>
<td style="text-align: right;">7.3</td>
</tr>
<tr class="even">
<td style="text-align: left;">30</td>
<td style="text-align: left;">Patient35</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">SD</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">45</td>
<td style="text-align: right;">23.6</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">4.2</td>
<td style="text-align: right;">7.3</td>
</tr>
<tr class="odd">
<td style="text-align: left;">31</td>
<td style="text-align: left;">Patient36</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">65</td>
<td style="text-align: right;">22.3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2.6</td>
<td style="text-align: right;">6.4</td>
</tr>
<tr class="even">
<td style="text-align: left;">32</td>
<td style="text-align: left;">Patient37</td>
<td style="text-align: left;">R</td>
<td style="text-align: left;">SD</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">47</td>
<td style="text-align: right;">23.3</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">4.9</td>
<td style="text-align: right;">7.9</td>
</tr>
<tr class="odd">
<td style="text-align: left;">33</td>
<td style="text-align: left;">Patient38</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">48</td>
<td style="text-align: right;">31.8</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2.3</td>
<td style="text-align: right;">6.9</td>
</tr>
<tr class="even">
<td style="text-align: left;">34</td>
<td style="text-align: left;">Patient39</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">49</td>
<td style="text-align: right;">20.7</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2.0</td>
<td style="text-align: right;">6.5</td>
</tr>
<tr class="odd">
<td style="text-align: left;">35</td>
<td style="text-align: left;">Patient40</td>
<td style="text-align: left;">NE</td>
<td style="text-align: left;">NE</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">54</td>
<td style="text-align: right;">25.9</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">4.0</td>
<td style="text-align: right;">6.1</td>
</tr>
<tr class="even">
<td style="text-align: left;">36</td>
<td style="text-align: left;">Patient41</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">44</td>
<td style="text-align: right;">25.5</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2.0</td>
<td style="text-align: right;">6.1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">37</td>
<td style="text-align: left;">Patient42</td>
<td style="text-align: left;">NE</td>
<td style="text-align: left;">NE</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">52</td>
<td style="text-align: right;">21.4</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">5.6</td>
<td style="text-align: right;">5.6</td>
</tr>
<tr class="even">
<td style="text-align: left;">38</td>
<td style="text-align: left;">Patient43</td>
<td style="text-align: left;">NE</td>
<td style="text-align: left;">NE</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">57</td>
<td style="text-align: right;">22.6</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">5.9</td>
<td style="text-align: right;">5.9</td>
</tr>
<tr class="odd">
<td style="text-align: left;">39</td>
<td style="text-align: left;">Patient44</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">48</td>
<td style="text-align: right;">23.6</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2.3</td>
<td style="text-align: right;">7.0</td>
</tr>
<tr class="even">
<td style="text-align: left;">40</td>
<td style="text-align: left;">Patient46</td>
<td style="text-align: left;">NR</td>
<td style="text-align: left;">PD</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">42</td>
<td style="text-align: right;">20.9</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1.7</td>
<td style="text-align: right;">3.6</td>
</tr>
</tbody>
</table>

3 Samples sequending statistics
===============================

    data<-fread("../Data/Data/samples_seqInfo.csv",data.table = F)
    knitr::include_graphics("../images/samples_seqInfo.png")

<img src="../images/samples_seqInfo.png" width="519" />

4 Vsisualization
================

    df<-fread("../Data/Data/Phylum_cli_111samples.csv",data.table = F)
    df$FBratio<-df$Firmicutes/df$Bacteroidetes
    df$FBratio_g<-ifelse(df$FBratio>=median(df$FBratio),"High","Low")
    data<-subset(df,Site=="Stool"&Response!="NE"&Cycle=="BL")
    par(mfrow=c(1,2))
    hist(data$BMI,main="Frequence of BMI",xlab = "BMI")
    hist(data$FBratio,main="Frequence of FBratio",xlab = "FBratio")

![](AnalysisDocument_files/figure-markdown_strict/unnamed-chunk-4-1.png)

    data$BMI_g<-ifelse(data$BMI>25,"High","Low")
    data$FBratio_g<-ifelse(data$FBratio>median(data$FBratio),"High","Low")
    fit<-survfit(Surv(PFStime,PFS) ~ BMI_g,
                       data = data)
    fit

    ## Call: survfit(formula = Surv(PFStime, PFS) ~ BMI_g, data = data)
    ## 
    ##             n events median 0.95LCL 0.95UCL
    ## BMI_g=High 10      8   3.28    2.20      NA
    ## BMI_g=Low  22     21   1.97    1.87     4.2

    ggsurvplot(fit, data=data,xlab = "Time(months)",conf.int = T,tables.theme = theme_few(base_size = 10),
               linetype = "strata",
                    legend.title = "",palette = c("black","red"),
                    risk.table = T,
                    #legend = c(0.84, 0.8),
                    pval = TRUE,pval.size = 4, 
                    pval.coord=c(0.8,0.2),pval.method=F,
                    pval.method.coord=c(0.05,0.3), 
                    ggtheme = theme_minimal() + 
                      theme(line = element_line(size = 0.1),
                            text  = element_text(size = 8)),
                    risk.table.col = "strata",
                    surv.median.line = "hv",
                    risk.table.y.text.col = T,
                    risk.table.y.text = FALSE )

![](AnalysisDocument_files/figure-markdown_strict/unnamed-chunk-5-1.png)

    p1<-ggscatter(subset(df,Cycle=="BL"&Response!="NE"&FBratio<10), x = "FBratio", y = "BMI",size=0.5,mean.point = T,
              color = "Site", add.params = list(c(size=0.5,color="Site")),
              add = "reg.line", conf.int = TRUE)+
      stat_cor(label.x = 0.3,aes(color=Site))+
      theme_few(base_size = 8)+
      scale_color_aaas()+
      scale_color_manual(values = col11)

    ## Scale for 'colour' is already present. Adding another scale for 'colour',
    ## which will replace the existing scale.

    p2<-ggscatter(subset(df,Cycle=="BL"&Response!="NE"), x = "Firmicutes", y = "Bacteroidetes",size=0.5,mean.point = T,
              color = "Site", add.params = list(c(size=0.5,color="Site")),
              add = "reg.line", conf.int = TRUE)+
      stat_cor(label.x = 0.2,aes(color=Site))+
      theme_few(base_size = 8)+
      scale_color_aaas()

    p3<-ggstatsplot::ggbarstats(data = data,x=Response,ggtheme = ggplot2::theme_bw(base_size=8),bias.correct = T,
                            y =FBratio_g,subtitle = F,results.subtitle=F,
                            ggstatsplot.layer = FALSE,
                            legend.position="right",
                            messages = FALSE,
                            package = "ggsci",
                            palette = "default_nejm",
                            main = Response, nboot = 100,
                            legend.title = "Response")

    ## Registered S3 methods overwritten by 'lme4':
    ##   method                          from
    ##   cooks.distance.influence.merMod car 
    ##   influence.merMod                car 
    ##   dfbeta.influence.merMod         car 
    ##   dfbetas.influence.merMod        car

    plot_grid(p1,p2, p3,labels = c("A","B","C"), ncol =3, nrow = 1)

    ## `geom_smooth()` using formula 'y ~ x'

    ## `geom_smooth()` using formula 'y ~ x'

![](AnalysisDocument_files/figure-markdown_strict/unnamed-chunk-6-1.png)

    df <- fread("../Data/Data/paired_BL_treat_16patients.csv", data.table = F)

    df$Hand_food_syndrom <- as.factor(df$Hand_food_syndrom)
    df$Hand_food_syndrom_g <- ifelse(df$Hand_food_syndrom %in% c("0", "1"), "no", "yes")
    df$Rash <- as.factor(df$Rash)
    df$Rash_g <- ifelse(df$Rash == "0", "no", "yes")
    df$Fever <- as.factor(df$Fever)
    df$Fever_g <- ifelse(df$Fever == "0", "no", "yes")
    df$Diarrhea <- as.factor(df$Diarrhea)
    df$Diarrhea_g <- ifelse(df$Diarrhea == "0", "no", "yes")

    df_treat <- subset(df, Group == "Treat")
    # List of ggsurvplots
    require("survminer")
    splots <- list()

    fit_PFS <- survfit(Surv(PFStime, PFS) ~ Hand_food_syndrom_g, data = df_treat)
    fit_PFS
    fit_OS <- survfit(Surv(OStime, OS) ~ Hand_food_syndrom_g, data = df_treat)
    fit_OS
    splots[[1]] <- surv_plot(fit_PFS, df_treat, colors = c("darkgreen", "darkorange"), 
        title = "HandFoodSyndrom_PFS")
    ## Loading required package: prodlim
    splots[[2]] <- surv_plot(fit_OS, df_treat, colors = c("black", "red"), title = "HandFoodSyndrom_OS")

    fit_PFS <- survfit(Surv(PFStime, PFS) ~ Rash_g, data = df_treat)
    fit_PFS
    fit_OS <- survfit(Surv(OStime, OS) ~ Rash_g, data = df_treat)
    fit_OS
    splots[[3]] <- surv_plot(fit_PFS, df_treat, colors = c("darkgreen", "darkorange"), 
        title = "Rash_PFS")
    splots[[4]] <- surv_plot(fit_OS, df_treat, colors = c("black", "red"), title = "Rash_OS")

    fit_PFS <- survfit(Surv(PFStime, PFS) ~ Fever_g, data = df_treat)
    fit_PFS
    fit_OS <- survfit(Surv(OStime, OS) ~ Fever_g, data = df_treat)
    fit_OS
    splots[[5]] <- surv_plot(fit_PFS, df_treat, colors = c("darkgreen", "darkorange"), 
        title = "Fever_PFS")
    splots[[6]] <- surv_plot(fit_OS, df_treat, colors = c("black", "red"), title = "Fever_OS")
    fit_PFS <- survfit(Surv(PFStime, PFS) ~ Diarrhea_g, data = df_treat)
    fit_PFS
    fit_OS <- survfit(Surv(OStime, OS) ~ Diarrhea_g, data = df_treat)
    fit_OS
    splots[[7]] <- surv_plot(fit_PFS, df_treat, colors = c("darkgreen", "darkorange"), 
        title = "Diarrhea_PFS")
    splots[[8]] <- surv_plot(fit_OS, df_treat, colors = c("black", "red"), title = "Diarrhea_OS")
    arrange_ggsurvplots(splots, print = TRUE, ncol = 4, nrow = 2)

![](AnalysisDocument_files/figure-markdown_strict/unnamed-chunk-7-1.png)


    bar1 <- ggplot(df, aes(Group, Desulfovibrionaceae, fill = Response)) + geom_boxplot() + 
        geom_line(aes(group = patientID, color = Response, size = Desulfovibrionaceae), 
            alpha = 0.5) + geom_point(aes(size = Desulfovibrionaceae), color = "darkblue", 
        alpha = 0.5) + theme_few(base_size = 8) + stat_compare_means(label = "p.signif") + 
        scale_fill_d3() + theme(legend.key = element_blank(), axis.title.x = element_blank())
    bar2 <- ggplot(df, aes(Group, Desulfovibrionaceae, fill = Diarrhea_g)) + geom_boxplot() + 
        geom_line(aes(group = patientID, color = Diarrhea_g, size = Desulfovibrionaceae), 
            alpha = 0.5) + geom_point(aes(size = Desulfovibrionaceae), color = "darkblue", 
        alpha = 0.5) + theme_few(base_size = 8) + stat_compare_means(label = "p.signif") + 
        scale_fill_jama() + theme(legend.key = element_blank(), axis.title.x = element_blank())
    ## Call: survfit(formula = Surv(PFStime, PFS) ~ Hand_food_syndrom_g, data = df_treat)
    ## 
    ##                         n events median 0.95LCL 0.95UCL
    ## Hand_food_syndrom_g=no  7      7    2.3    1.97      NA
    ## Hand_food_syndrom_g=yes 9      7    4.2    2.20      NA
    ## Call: survfit(formula = Surv(OStime, OS) ~ Hand_food_syndrom_g, data = df_treat)
    ## 
    ##                         n events median 0.95LCL 0.95UCL
    ## Hand_food_syndrom_g=no  7      2     NA    5.17      NA
    ## Hand_food_syndrom_g=yes 9      3   15.5   10.33      NA
    ## Call: survfit(formula = Surv(PFStime, PFS) ~ Rash_g, data = df_treat)
    ## 
    ##             n events median 0.95LCL 0.95UCL
    ## Rash_g=no  11     10   3.80    2.03      NA
    ## Rash_g=yes  5      4   4.23    2.20      NA
    ## Call: survfit(formula = Surv(OStime, OS) ~ Rash_g, data = df_treat)
    ## 
    ##             n events median 0.95LCL 0.95UCL
    ## Rash_g=no  11      3   10.3    10.3      NA
    ## Rash_g=yes  5      2   15.5    15.5      NA
    ## Call: survfit(formula = Surv(PFStime, PFS) ~ Fever_g, data = df_treat)
    ## 
    ##              n events median 0.95LCL 0.95UCL
    ## Fever_g=no  14     12   3.05    2.03      NA
    ## Fever_g=yes  2      2   5.28    4.23      NA
    ## Call: survfit(formula = Surv(OStime, OS) ~ Fever_g, data = df_treat)
    ## 
    ##              n events median 0.95LCL 0.95UCL
    ## Fever_g=no  14      4   15.5    15.5      NA
    ## Fever_g=yes  2      1   10.3      NA      NA
    ## Call: survfit(formula = Surv(PFStime, PFS) ~ Diarrhea_g, data = df_treat)
    ## 
    ##                 n events median 0.95LCL 0.95UCL
    ## Diarrhea_g=no  13     11   4.23    2.30      NA
    ## Diarrhea_g=yes  3      3   1.97    1.87      NA
    ## Call: survfit(formula = Surv(OStime, OS) ~ Diarrhea_g, data = df_treat)
    ## 
    ##                 n events median 0.95LCL 0.95UCL
    ## Diarrhea_g=no  13      4   15.5    10.3      NA
    ## Diarrhea_g=yes  3      1     NA     3.9      NA

    plot_grid(bar1, bar2, labels = c("A", "B"), ncol = 2, nrow = 1)

![](AnalysisDocument_files/figure-markdown_strict/unnamed-chunk-8-1.png)
