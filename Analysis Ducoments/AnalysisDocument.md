- [1 Introduction](#1-introduction)
- [2 Clinical](#2-clinical)
- [3 Samples sequending statistics](#3-samples-sequending-statistics)
- [4 Vsisualization](#4-vsisualization)

================

[`Return`](./)

1 Introduction
==============

```Introduction
For documentation, see: https://kramdown.gettalong.org/syntax.html#math-blocks
```

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
    library(tidyverse)<br>
    library(ggthemes)<br>
    library(ggsci)<br>
    library(ggpubr)<br>
    library(survminer)<br>
    library(survival)<br>
    library(survivalROC)<br>
    library(reshape2)<br>
    library(data.table)<br>
    library(ggExtra)<br>
    library(cowplot)<br>
    library(ComplexHeatmap)<br>
    library(scico)<br>
    library(colorspace)<br>
    library(RColorBrewer)<br>
    library(lubridate)<br>
    library(tableone)<br>
    library(kableExtra)<br>
    source("../R_function/colors.R")<br>
    source("../R_function/surv_plot.R")<br>
    theme_set(theme_cowplot())<br>
    "%ni%" <- Negate("%in%")<br>
    options(stringsAsFactors = F)<br>
</details>

2 Clinical
==========

<a href="../Data/Data/clinical.csv" target="csv">Clinical.csv</a>

    cli<-fread("../Data/Data/clinical.csv",data.table = F)
    factorvars <- colnames(cli)[-c(1:3,22:25)]
    tableone_groups <- CreateTableOne(vars = colnames(cli)[-c(1:3,22:25)],
                                      strata = 'Response',
                                      data = cli, 
                                      factorVars = factorvars)
    table1_groups <- print(x = tableone_groups, 
                           contDigits = 1,     
                           exact = factorvars, 
                           showAllLevels = FALSE, 
                           noSpaces = TRUE, 
                           printToggle = FALSE) 
    table1_groups %>%
      knitr::kable(caption = "Recreating booktabs style table") 

<table>
<caption>
Recreating booktabs style table
</caption>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
NE
</th>
<th style="text-align:left;">
NR
</th>
<th style="text-align:left;">
R
</th>
<th style="text-align:left;">
p
</th>
<th style="text-align:left;">
test
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
n
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
21
</td>
<td style="text-align:left;">
13
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
HandFoodSyndrom (%)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
0.347
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
Level0
</td>
<td style="text-align:left;">
3 (50.0)
</td>
<td style="text-align:left;">
12 (57.1)
</td>
<td style="text-align:left;">
3 (23.1)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Level1
</td>
<td style="text-align:left;">
1 (16.7)
</td>
<td style="text-align:left;">
3 (14.3)
</td>
<td style="text-align:left;">
2 (15.4)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Level2
</td>
<td style="text-align:left;">
1 (16.7)
</td>
<td style="text-align:left;">
5 (23.8)
</td>
<td style="text-align:left;">
4 (30.8)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Level3
</td>
<td style="text-align:left;">
1 (16.7)
</td>
<td style="text-align:left;">
1 (4.8)
</td>
<td style="text-align:left;">
4 (30.8)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Rash (%)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
0.836
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
Level0
</td>
<td style="text-align:left;">
5 (83.3)
</td>
<td style="text-align:left;">
13 (61.9)
</td>
<td style="text-align:left;">
9 (69.2)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Level1
</td>
<td style="text-align:left;">
0 (0.0)
</td>
<td style="text-align:left;">
4 (19.0)
</td>
<td style="text-align:left;">
3 (23.1)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Level2
</td>
<td style="text-align:left;">
1 (16.7)
</td>
<td style="text-align:left;">
2 (9.5)
</td>
<td style="text-align:left;">
1 (7.7)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Level3
</td>
<td style="text-align:left;">
0 (0.0)
</td>
<td style="text-align:left;">
2 (9.5)
</td>
<td style="text-align:left;">
0 (0.0)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Fever (%)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
0.481
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
Level0
</td>
<td style="text-align:left;">
5 (83.3)
</td>
<td style="text-align:left;">
18 (85.7)
</td>
<td style="text-align:left;">
9 (69.2)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Level1
</td>
<td style="text-align:left;">
1 (16.7)
</td>
<td style="text-align:left;">
1 (4.8)
</td>
<td style="text-align:left;">
1 (7.7)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Level2
</td>
<td style="text-align:left;">
0 (0.0)
</td>
<td style="text-align:left;">
2 (9.5)
</td>
<td style="text-align:left;">
3 (23.1)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Diarrhea (%)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
0.957
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
Level0
</td>
<td style="text-align:left;">
5 (83.3)
</td>
<td style="text-align:left;">
16 (76.2)
</td>
<td style="text-align:left;">
12 (92.3)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Level1
</td>
<td style="text-align:left;">
1 (16.7)
</td>
<td style="text-align:left;">
3 (14.3)
</td>
<td style="text-align:left;">
1 (7.7)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Level2
</td>
<td style="text-align:left;">
0 (0.0)
</td>
<td style="text-align:left;">
1 (4.8)
</td>
<td style="text-align:left;">
0 (0.0)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Level3
</td>
<td style="text-align:left;">
0 (0.0)
</td>
<td style="text-align:left;">
1 (4.8)
</td>
<td style="text-align:left;">
0 (0.0)
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Gender = Male (%)
</td>
<td style="text-align:left;">
2 (33.3)
</td>
<td style="text-align:left;">
12 (57.1)
</td>
<td style="text-align:left;">
7 (53.8)
</td>
<td style="text-align:left;">
0.623
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
Age = &gt;60 (%)
</td>
<td style="text-align:left;">
0 (0.0)
</td>
<td style="text-align:left;">
6 (28.6)
</td>
<td style="text-align:left;">
3 (23.1)
</td>
<td style="text-align:left;">
0.505
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
BMI = &gt;=25 (%)
</td>
<td style="text-align:left;">
2 (33.3)
</td>
<td style="text-align:left;">
7 (33.3)
</td>
<td style="text-align:left;">
2 (15.4)
</td>
<td style="text-align:left;">
0.550
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
History = yes (%)
</td>
<td style="text-align:left;">
1 (16.7)
</td>
<td style="text-align:left;">
6 (28.6)
</td>
<td style="text-align:left;">
4 (30.8)
</td>
<td style="text-align:left;">
1.000
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
Smoking = yes (%)
</td>
<td style="text-align:left;">
2 (33.3)
</td>
<td style="text-align:left;">
2 (9.5)
</td>
<td style="text-align:left;">
2 (15.4)
</td>
<td style="text-align:left;">
0.265
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
Dringking = yes (%)
</td>
<td style="text-align:left;">
2 (33.3)
</td>
<td style="text-align:left;">
1 (4.8)
</td>
<td style="text-align:left;">
2 (15.4)
</td>
<td style="text-align:left;">
0.154
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
anitEGFR = yes (%)
</td>
<td style="text-align:left;">
2 (33.3)
</td>
<td style="text-align:left;">
5 (23.8)
</td>
<td style="text-align:left;">
5 (38.5)
</td>
<td style="text-align:left;">
0.642
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
antiVEGF = yes (%)
</td>
<td style="text-align:left;">
3 (50.0)
</td>
<td style="text-align:left;">
13 (61.9)
</td>
<td style="text-align:left;">
7 (53.8)
</td>
<td style="text-align:left;">
0.829
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
LiverM = yes (%)
</td>
<td style="text-align:left;">
5 (83.3)
</td>
<td style="text-align:left;">
14 (66.7)
</td>
<td style="text-align:left;">
9 (69.2)
</td>
<td style="text-align:left;">
0.896
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
LungM = yes (%)
</td>
<td style="text-align:left;">
5 (83.3)
</td>
<td style="text-align:left;">
10 (47.6)
</td>
<td style="text-align:left;">
9 (69.2)
</td>
<td style="text-align:left;">
0.248
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
LymphM = yes (%)
</td>
<td style="text-align:left;">
2 (33.3)
</td>
<td style="text-align:left;">
10 (47.6)
</td>
<td style="text-align:left;">
6 (46.2)
</td>
<td style="text-align:left;">
0.911
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
PeritonealM = yes (%)
</td>
<td style="text-align:left;">
0 (0.0)
</td>
<td style="text-align:left;">
8 (38.1)
</td>
<td style="text-align:left;">
2 (15.4)
</td>
<td style="text-align:left;">
0.142
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
OtherM = yes (%)
</td>
<td style="text-align:left;">
1 (16.7)
</td>
<td style="text-align:left;">
5 (23.8)
</td>
<td style="text-align:left;">
0 (0.0)
</td>
<td style="text-align:left;">
0.162
</td>
<td style="text-align:left;">
exact
</td>
</tr>
<tr>
<td style="text-align:left;">
Location = right (%)
</td>
<td style="text-align:left;">
3 (50.0)
</td>
<td style="text-align:left;">
6 (28.6)
</td>
<td style="text-align:left;">
4 (30.8)
</td>
<td style="text-align:left;">
0.590
</td>
<td style="text-align:left;">
exact
</td>
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

    ggsurvplot(fit, data=data,xlab = "Time(months)",
               censor.size=0.5, size = 0.5,
               conf.int = T,tables.theme = theme_few(base_size = 6),
               linetype = "strata",
                    legend.title = "",palette = c("black","red"),
                    risk.table = T,
                    #legend = c(0.84, 0.8),
                    pval = TRUE,pval.size = 3, 
                    pval.coord=c(0.8,0.2),pval.method=F,
                    pval.method.coord=c(0.05,0.3), 
                    ggtheme = theme_minimal() + 
                      theme(line = element_line(size = 0.1),
                            text  = element_text(size = 6)),
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

```tip
Edit this page to see how to add this to your docs, theme can use [@primer/css utilities](https://primer.style/css/utilities)
```
