surv_plot<-function(fit,data,colors,title){
  library(survcomp)
  library(survminer)
  library(survival)
  library(grid)
  library(ggplotify)
  p<-ggsurvplot(fit,data=data,xlab = "Time(months)", linetype = "strata",
                censor.size=0.3, size = 0.3,
                risk.table = F,
                legend.title = title,
                tables.theme = theme_few(base_size = 6),
                legend = c(0.84, 0.8),
                pval = TRUE,pval.size = 2, 
                pval.coord=c(0.8,0.2),pval.method=F,
                pval.method.coord=c(0.05,0.3), 
                ggtheme = theme_minimal() + 
                  theme(line = element_line(size = 0.1),
                        text  = element_text(size = 6)),
                palette = colors,
                legend.labs = c("no", "yes"),
                risk.table.col = "strata",
                surv.median.line = "hv",
                risk.table.y.text.col = T,
                risk.table.y.text = FALSE )
  return(p)
}

theme()