-   [1 Requires](#requires)
-   [2 8 patients with BL and treat stool and
    saliva](#patients-with-bl-and-treat-stool-and-saliva)
-   [3 Plot loss during training](#plot-loss-during-training)

[`Return`](./)

1 Requires
==========

<details>
<summary>
<font size=4>Requires</font>
</summary>

    library(data.table)
    library(reshape2)
    library(ggthemes)
    library(ggsci)
    library(tidyverse)
    library(FactoMineR)
    library(corrplot)
    library(colortools)
    library(visibly)
    library(plotly)
    library(scico)
    library(factoextra)
    library(randomForest)
    library(ANN2)
    library(NeuralNetTools)
    library(ConsensusClusterPlus)
    library(survminer)
    library(survival)
    library(ggExtra)
    library(cowplot)
    library(corrplot)
    source("../R_function/colors.R")
    source("../R_function/surv_plot.R")
    theme_set(theme_cowplot())
    "%ni%" <- Negate("%in%")
    options(stringsAsFactors = F)

</details>

2 8 patients with BL and treat stool and saliva
===============================================

    paired_stool_saliva_TB<-fread("../Data/Data/paired_stool_saliva_TB_8patients.csv",data.table = F)
    clinical<-fread(".../Data/Data/clinical_adver_41p.csv",data.table = F)[,-10]
    otu<-fread("../Data/Data/OTUtable_ori.csv",data.table = F)
    colnames(otu)[1]="OTUid"
    group<-paired_stool_saliva_TB[,c(1,2)]
    group<-group[-which(duplicated(group$patientID)),]
    group<-data.frame(row.names = group$patientID,Response=group$Response)
    paired_stool_saliva_TB<-paired_stool_saliva_TB[,-2]
    paired_stool_saliva_TB$Group<-paste0(paired_stool_saliva_TB$Group,"_",paired_stool_saliva_TB$Site)
    paired_stool_saliva_TB<-paired_stool_saliva_TB[,-4]
    OTU_sliva_stool_TB<-otu[,which(colnames(otu)%in%c("OTUid",paired_stool_saliva_TB$SangerID))]
    OTU_sliva_stool_TB<-data.frame(row.names = OTU_sliva_stool_TB$OTUid,OTU_sliva_stool_TB[,-1])
    OTU_sliva_stool_TB<-data.frame(SangerID=colnames(OTU_sliva_stool_TB),t(OTU_sliva_stool_TB))
    OTU_sliva_stool_TB<-merge(paired_stool_saliva_TB,OTU_sliva_stool_TB,by="SangerID")
    levels(factor(OTU_sliva_stool_TB$Group))
    OTU_BL_Saliva<-subset(OTU_sliva_stool_TB,Group=="BL_Saliva")[,-c(1,3)]
    OTU_BL_Stool<-subset(OTU_sliva_stool_TB,Group=="BL_Stool")[,-c(1,3)]
    OTU_Treat_Saliva<-subset(OTU_sliva_stool_TB,Group=="Treat_Saliva")[,-c(1,3)]
    OTU_Treat_Stool<-subset(OTU_sliva_stool_TB,Group=="Treat_Stool")[,-c(1,3)]

    OTU_BL_Saliva_stat<-data.frame(OTUid=colnames(OTU_BL_Saliva)[-1],AV=apply(OTU_BL_Saliva[,-1], 2, mean))%>%
      filter(.,AV>5)
    OTU_BL_Stool_stat<-data.frame(OTUid=colnames(OTU_BL_Stool)[-1],AV=apply(OTU_BL_Stool[,-1], 2, mean))%>%
      filter(.,AV>5)
    OTU_Treat_Saliva_stat<-data.frame(OTUid=colnames(OTU_Treat_Saliva)[-1],AV=apply(OTU_Treat_Saliva[,-1], 2, mean))%>%
      filter(.,AV>5)
    OTU_Treat_Stool_stat<-data.frame(OTUid=colnames(OTU_Treat_Stool)[-1],AV=apply(OTU_Treat_Stool[,-1], 2, mean))%>%
      filter(.,AV>5)
    OTU_BL_Saliva<-OTU_BL_Saliva[,which(colnames(OTU_BL_Saliva)%in%c("patientID",levels(factor(OTU_BL_Saliva_stat$OTUid))))]
    OTU_BL_Stool<-OTU_BL_Stool[,which(colnames(OTU_BL_Stool)%in%c("patientID",levels(factor(OTU_BL_Stool_stat$OTUid))))]
    OTU_Treat_Saliva<-OTU_Treat_Saliva[,which(colnames(OTU_Treat_Saliva)%in%c("patientID",levels(factor(OTU_Treat_Saliva_stat$OTUid))))]
    OTU_Treat_Stool<-OTU_Treat_Stool[,which(colnames(OTU_Treat_Stool)%in%c("patientID",levels(factor(OTU_Treat_Stool_stat$OTUid))))]
    colnames(OTU_BL_Saliva)[-1]<-paste0(colnames(OTU_BL_Saliva)[-1],"_BL_Saliva")
    colnames(OTU_BL_Stool)[-1]<-paste0(colnames(OTU_BL_Stool)[-1],"_BL_Stool")
    colnames(OTU_Treat_Saliva)[-1]<-paste0(colnames(OTU_Treat_Saliva)[-1],"_Treat_Saliva")
    colnames(OTU_Treat_Stool)[-1]<-paste0(colnames(OTU_Treat_Stool)[-1],"_Treat_Stool")
    OTU_BL_Saliva_mat<-data.frame(row.names =OTU_BL_Saliva$patientID,OTU_BL_Saliva[,-1])%>%as.matrix()
    OTU_BL_Stool_mat<-data.frame(row.names =OTU_BL_Stool$patientID,OTU_BL_Stool[,-1])%>%as.matrix()
    OTU_Treat_Saliva_mat<-data.frame(row.names =OTU_Treat_Saliva$patientID,OTU_Treat_Saliva[,-1])%>%as.matrix()
    OTU_Treat_Stool_mat<-data.frame(row.names =OTU_Treat_Stool$patientID,OTU_Treat_Stool[,-1])%>%as.matrix()
    clinical_mat<-subset(clinical,patientID%in%paired_stool_saliva_TB$patientID)
    clinical_mat<-data.frame(row.names =clinical_mat$patientID,clinical_mat[,-1])%>%as.matrix()

    OTU8paired_mat<-do.call(cbind,list(clinical_mat,OTU_BL_Saliva_mat,OTU_BL_Stool_mat,
                                       OTU_Treat_Saliva_mat,OTU_Treat_Stool_mat))

    res.hc1 <- eclust(OTU_BL_Saliva_mat, "hclust", k = 2,
                      method = "ward.D2", graph =T) 
    res.hc2 <- eclust(OTU_BL_Stool_mat, "hclust", k = 2,
                      method = "ward.D2", graph =T) 
    res.hc3 <- eclust(OTU_Treat_Saliva_mat, "hclust", k = 2,
                      method = "ward.D2", graph =T) 
    res.hc4 <- eclust(OTU_Treat_Stool_mat, "hclust", k = 2,
                      method = "ward.D2", graph =T) 
    res.hc5 <- eclust(clinical_mat, "hclust", k = 2,
                      method = "ward.D2", graph =T) 

    p1<-fviz_dend(res.hc1, k = 2,main = "BL_Saliva",ggtheme = theme_few(base_size = 6),palette = "lancet",cex = 0.5)

    p2<-fviz_dend(res.hc2, k = 2, main = "BL_Stool",ggtheme = theme_few(base_size = 6),palette = "lancet", cex = 0.5)

    p3<-fviz_dend(res.hc3, k = 2,main = "Treat_Saliva",ggtheme = theme_few(base_size = 6),palette = "lancet", cex = 0.5)

    p4<-fviz_dend(res.hc4, k = 2, main = "BL_Treat",ggtheme = theme_few(base_size = 6),palette ="lancet", cex = 0.5)

    p5<-fviz_dend(res.hc5, k = 2,main = "Clinical", ggtheme = theme_few(base_size = 6),palette = "lancet", cex = 0.5)

    plot_grid(p1,p2,p3,p4,p5, labels = c("A","B","C","D","E"), ncol =5 ,nrow = 1)

    load("../Data/Data/regaMicrcobiome.RData")
    patients8<-fread("../Data/Data/paired_stool_saliva_TB_8patients.csv",data.table = F)
    phylum_stool<-regaMicrobiome$StoolMicrobiome$TaxonomyComposition$Phylum
    phylum_saliva<-regaMicrobiome$SalivaMicrobiome$TaxonomyComposition$Phylum
    family_stool<-regaMicrobiome$StoolMicrobiome$TaxonomyComposition$Family
    family_saliva<-regaMicrobiome$SalivaMicrobiome$TaxonomyComposition$Family

    data_list<-list(phylum_stool=phylum_stool,phylum_saliva=phylum_saliva,
                    family_stool=family_stool,family_saliva=family_saliva)
    data_list<-lapply(data_list, function(x){
      x<-x[,which(colnames(x)%in%patients8$Samples)]
      x<-data.frame(Samples=colnames(x),t(x))
      x<-merge(patients8,x,by="Samples")[,-1]
      x<-melt(x,id.vars = c("patientID" ,"Response","Group","Site" ),
              variable.name = "MicroName",
              value.name = "Abundance")
    })

    data_list[[1]]$patientID<-factor(data_list[[1]]$patientID,
                                     levels = c("Patient38","Patient41","Patient10",
                                                "Patient13","Patient16","Patient26","Patient32",
                                                "Patient35"))
    data_list[[2]]$patientID<-factor(data_list[[2]]$patientID,
                                     levels = c("Patient38","Patient41","Patient10",
                                                "Patient13","Patient16","Patient26","Patient32",
                                                "Patient35"))
    data_list[[3]]$patientID<-factor(data_list[[3]]$patientID,
                                     levels = c("Patient38","Patient41","Patient10",
                                                "Patient13","Patient16","Patient26","Patient32",
                                                "Patient35"))
    data_list[[4]]$patientID<-factor(data_list[[4]]$patientID,
                                     levels = c("Patient38","Patient41","Patient10",
                                                "Patient13","Patient16","Patient26","Patient32",
                                                "Patient35"))
    p1<-ggplot(data_list$phylum_saliva,aes(Group,Abundance,fill=MicroName))+
      geom_bar(stat = "identity", width=1)+
      facet_grid(Site~patientID,space="free",scales = "free")+
      theme_few(base_size = 6)+
      scale_fill_manual(name="Phylum",values = col16)+
      theme(legend.box.just="top",
            legend.spacing = unit(0.1,"cm"),
            legend.spacing.y = unit(0.1,"cm"),
            legend.spacing.x =unit(0.1,"cm"),
            legend.box.spacing = unit(0.1,"cm"),
            legend.justification=c(.4,.4),
            legend.position="top",legend.key.size=unit(.1,"inches"),axis.text.x = element_text(size=6,angle = 90,vjust = 1,hjust = 1),
            axis.title.x = element_blank())
    p2<-ggplot(data_list$phylum_stool,aes(Group,Abundance,fill=MicroName))+
      geom_bar(stat = "identity", width=1)+
      facet_grid(Site~patientID,space="free",scales = "free")+
      theme_few(base_size = 6)+
      scale_fill_manual(name="Phylum",values = col16)+
      theme(legend.box.just="top",
            legend.spacing = unit(0.1,"cm"),
            legend.spacing.y = unit(0.1,"cm"),
            legend.spacing.x =unit(0.1,"cm"),
            legend.box.spacing = unit(0.1,"cm"),
            legend.justification=c(.4,.4),
            legend.position="top",legend.key.size=unit(.1,"inches"),axis.text.x = element_text(size=6,angle = 90,vjust = 1,hjust = 1),
            axis.title.x = element_blank())

    p3<-ggplot(data_list$family_saliva,aes(Group,Abundance,fill=MicroName))+
      geom_bar(stat = "identity", width=1)+
      facet_grid(Site~patientID,space="free",scales = "free")+
      theme_few(base_size = 6)+
      scale_fill_manual(name="Family",values = col31[c(1:21,24)])+
      theme(legend.box.just="top",
            legend.spacing = unit(0.1,"cm"),
            legend.spacing.y = unit(0.1,"cm"),
            legend.spacing.x =unit(0.1,"cm"),
            legend.box.spacing = unit(0.1,"cm"),
            legend.justification=c(.4,.4),
            legend.position="top",legend.key.size=unit(.1,"inches"), axis.text.x = element_text(size=6,angle = 90,vjust = 1,hjust = 1),
            axis.title.x = element_blank())
    p4<-ggplot(data_list$family_stool,aes(Group,Abundance,fill=MicroName))+
      geom_bar(stat = "identity", width=1)+
      facet_grid(Site~patientID,space="free",scales = "free")+
      theme_few(base_size = 6)+
      scale_fill_manual(name="Family",values =col31[c(1:21,24)])+
      theme(legend.box.just="top",
            legend.spacing = unit(0.1,"cm"),
            legend.spacing.y = unit(0.1,"cm"),
            legend.spacing.x =unit(0.1,"cm"),
            legend.box.spacing = unit(0.1,"cm"),
            legend.justification=c(.4,.4),
            legend.position="top",legend.key.size=unit(.1,"inches"),axis.text.x = element_text(size=6,angle = 90,vjust = 1,hjust = 1),
            axis.title.x = element_blank())

    plot_grid(p1,p3,p2,p4, labels = c("A","B","C","D"), ncol =2 ,nrow = 2)

\`\`\`
clinical&lt;-fread(“../Data/Data/clinical\_adver\_41p.csv”,data.table =
F) cd&lt;-fread(“../Data/Data/cd3cd8.csv”,data.table = F)
clinical\_cd&lt;-merge(clinical,cd,by=“patientID”)
treat\_BL&lt;-fread(“../Data/Data/16pt\_BL\_treat\_pairs\_stool.csv”,data.table
= F)
treat\_BL&lt;-subset(treat\_BL,patientID%in%clinical\_cd$patientID) treat\_BL\_BL&lt;-subset(treat\_BL,Group=="BL") treat\_BL\_Treat&lt;-subset(treat\_BL,Group=="Treat") clinical\_cd&lt;-subset(clinical\_cd,patientID%in%treat\_BL$patientID)
clinical\_cd\_mat&lt;-data.frame(row.names =
clinical\_cd$patientID,clinical\_cd\[,-1\])

load(“../Data/Data/regaMicrcobiome.RData”)
otu&lt;-regaMicrobiome*S**t**o**o**l**M**i**c**r**o**b**i**o**m**e*TaxonomyReads$OTU colnames(otu)\[1\]="OTUid" otu\_BL&lt;-otu\[,which(colnames(otu)%in%c("OTUid",treat\_BL\_BL$Samples))\]
otu\_Treat&lt;-otu\[,which(colnames(otu)%in%c(“OTUid”,treat\_BL\_Treat$Samples))\]
otu\_BL\_stat&lt;-data.frame(OTUid=otu\_BL*O**T**U**i**d*, *n**u**m* = *a**p**p**l**y*(*o**t**u*<sub>*B*</sub>*L*\[, − 1\], 1, *s**u**m*))OTUid,num=apply(otu\_Treat\[,-1\],1,sum))%&gt;%
filter(.,num&gt;10)
otu\_BL&lt;-subset(otu\_BL,OTUid%in%otu\_BL\_stat*O**T**U**i**d*)*o**t**u*<sub>*T*</sub>*r**e**a**t* &lt;  − *s**u**b**s**e**t*(*o**t**u*<sub>*T*</sub>*r**e**a**t*, *O**T**U**i**d*OTUid)

otu\_BL\_mat&lt;-data.frame(row.names =
otu\_BL*O**T**U**i**d*, *o**t**u*<sub>*B*</sub>*L*\[, − 1\])*o**t**u*<sub>*T*</sub>*r**e**a**t*<sub>*m*</sub>*a**t* &lt;  − *d**a**t**a*.*f**r**a**m**e*(*r**o**w*.*n**a**m**e**s* = *o**t**u*<sub>*T*</sub>*r**e**a**t*OTUid,otu\_Treat\[,-1\])
otu\_BL\_mat&lt;-data.frame(Samples=colnames(otu\_BL\_mat),t(otu\_BL\_mat))
otu\_Treat\_mat&lt;-data.frame(Samples=colnames(otu\_Treat\_mat),t(otu\_Treat\_mat))
otu\_BL\_mat&lt;-merge(dplyr::select(treat\_BL,c(Samples,patientID)),otu\_BL\_mat,by=“Samples”)\[,-1\]
otu\_Treat\_mat&lt;-merge(dplyr::select(treat\_BL,c(Samples,patientID)),otu\_Treat\_mat,by=“Samples”)\[,-1\]
otu\_BL\_mat&lt;-data.frame(row.names =
otu\_BL\_mat*p**a**t**i**e**n**t**I**D*, *o**t**u*<sub>*B*</sub>*L*<sub>*m*</sub>*a**t*\[, − 1\])patientID,otu\_Treat\_mat\[,-1\])%&gt;%as.matrix()

colnames(otu\_BL\_mat)&lt;-paste0(colnames(otu\_BL\_mat),"\_BL“)
colnames(otu\_Treat\_mat)&lt;-paste0(colnames(otu\_Treat\_mat),”\_Treat")
merged\_cli\_otu&lt;-do.call(cbind,args =
list(clinical\_cd\_mat,otu\_BL\_mat,otu\_Treat\_mat))
merged\_otu&lt;-do.call(cbind,args = list(otu\_BL\_mat,otu\_Treat\_mat))
cd\_13&lt;-data.frame(row.names = cd$patientID,cd\[,-1\])
cd\_13&lt;-cd\_13\[which(rownames(cd\_13)%in%rownames(otu\_BL\_mat)),\]

dfcol&lt;-treat\_BL\[-which(duplicated(treat\_BL$patientID)),\]
dfcol&lt;-data.frame(row.names =
dfcol*p**a**t**i**e**n**t**I**D*, *G**r**o**u**p* = *d**f**c**o**l*Response)
df&lt;-cbind(dfcol,merged\_cli\_otu)
df*G**r**o**u**p* &lt;  − *i**f**e**l**s**e*(*d**f*Group==“R”,1,2)
X&lt;-df\[,-c(1:5)\]%&gt;%as.matrix() X&lt;-data.frame(row.names
=rownames(X),apply(X, 2, as.numeric))

AE &lt;- autoencoder(X, c(100,10,100), random.seed=1234, loss.type =
‘huber’,drop.last = F, activ.functions = c(‘tanh’,‘linear’,‘tanh’),
batch.size =3, optim.type = ‘rmsprop’, n.epochs = 1000, val.prop = 0)

3 Plot loss during training
===========================

recX &lt;- reconstruct(AE, X)
sort(recX*a**n**o**m**a**l**y*<sub>*s*</sub>*c**o**r**e**s*, *d**e**c**r**e**a**s**i**n**g* = *T**R**U**E*)\[1 : 5\]*A**E*<sub>*d*</sub>*f* &lt;  − *r**e**c**X*reconstructed
rownames(AE\_df)&lt;-rownames(X)

fviz\_nbclust( AE\_df, kmeans, k.max = 10, method = “wss”, verbose =
FALSE)

km.res &lt;- kmeans(scale(AE\_df),6, nstart = 25) fviz\_cluster(km.res,
data = AE\_df,repel = T,labelsize = 12, \# palette = c(“\#00AFBB”,
“\#E7B800”, “black”,“red”,“blue”,“gray”), ggtheme = theme\_minimal(),
main = “Kmeans Clustering Plot”)

cluster&lt;-data.frame(km.res*c**l**u**s**t**e**r*)*c**l**u**s**t**e**r*patientID&lt;-rownames(cluster)
cluster$km.res.cluster&lt;-paste0("km",cluster$km.res.cluster)
stat\_num&lt;-cluster%&gt;%group\_by(km.res.cluster)%&gt;%summarise(Num=n())
cluster*k**m*.*r**e**s*.*c**l**u**s**t**e**r* &lt;  − *i**f**e**l**s**e*(*c**l**u**s**t**e**r*km.res.cluster==stat\_num*k**m*.*r**e**s*.*c**l**u**s**t**e**r*\[*w**h**i**c**h*(*s**t**a**t*<sub>*n*</sub>*u**m*Num&gt;5)\],“km1”,“km2”)
new&lt;-merge(cluster,clinical,by=“patientID”)
fit1&lt;-survfit(Surv(PFStime,PFS) ~ km.res.cluster, data = new) fit1
p1&lt;-ggsurvplot(fit1, data=new,pval.method = T,add.all = T,
tables.theme = theme\_classic2(base\_size = 8), palette = c(“black”,
“\#00AFBB”,“\#E7B800”), risk.table = T, pval = TRUE,
legend.title=“K-means”, risk.table.col = “strata”, surv.median.line =
“hv”, risk.table.y.text.col = T, risk.table.y.text = F ) p1

library(limma)
otu\_info&lt;-fread(“../Data/Data/OTUtabale\_regaStool.csv”)\[,c(1:7)\]
colnames(otu\_info)\[7\]=“OTUid”
otu\_info*T**a**x**o**n**o**m**y* &lt;  − *p**a**s**t**e*(*o**t**u*<sub>*i*</sub>*n**f**o*Phylum,otu\_info*C**l**a**s**s*, *o**t**u*<sub>*i*</sub>*n**f**o*Order,otu\_info*F**a**m**i**l**y*, *o**t**u*<sub>*i*</sub>*n**f**o*Genus,otu\_info$Species,sep = "|") otu\_info&lt;-otu\_info\[,7:8\] ano\_data&lt;-X ano\_data$patientID=rownames(ano\_data)
ano\_data&lt;-merge(cluster,ano\_data,by=“patientID”) data&lt;-ano\_data
data&lt;-data\[,-1\]
lev&lt;-unique(data*k**m*.*r**e**s*.*c**l**u**s**t**e**r*)*f* &lt;  − *f**a**c**t**o**r*(*d**a**t**a*km.res.cluster,
levels=lev) design &lt;- model.matrix(~0+f) colnames(design) &lt;- lev
eset&lt;-dplyr::select(data,-km.res.cluster)
eset&lt;-data.frame(t(eset)) \#eset&lt;-data.frame(apply(eset, 2, av))
cont.wt &lt;- makeContrasts(“km1-km2”, levels=design) fit &lt;-
lmFit(eset, design) fit2 &lt;- contrasts.fit(fit, cont.wt) fit2 &lt;-
eBayes(fit2) tT=topTable(fit2, adjust=“BH”,sort.by=“logFC”,n=Inf) tT =
subset(tT, select=c(“adj.P.Val”,“P.Value”,“logFC”))
colnames(tT)=c(“FDR”,“P.Value”,“logFC”) range(tT$logFC)
limma\_res&lt;-filter(tT,P.Value&lt;=0.05&abs(logFC)&gt;1)

limma\_res*F**a**c**t**o**r* &lt;  − *r**o**w**n**a**m**e**s*(*l**i**m**m**a*<sub>*r*</sub>*e**s*)*l**i**m**m**a*<sub>*r*</sub>*e**s*OTUid&lt;-rownames(limma\_res)
limma\_res$OTUid&lt;-gsub("\_BL","",limma\_res$OTUid)
limma\_res$OTUid&lt;-gsub("\_Treat","",limma\_res$OTUid)
limma\_res*G**r**o**u**p* &lt;  − *r**o**w**n**a**m**e**s*(*l**i**m**m**a*<sub>*r*</sub>*e**s*)*l**i**m**m**a*<sub>*r*</sub>*e**s*Group&lt;-gsub("^.\*\_“,”",limma\_res$Group)

limma\_res&lt;-merge(limma\_res,otu\_info,by=“OTUid”)
limma\_res$Taxonomy&lt;-gsub("d\_\_Bacteria;k\_\_norank\_d\_\_Bacteria;p\_\_","",limma\_res$Taxonomy)
final\_res&lt;-dplyr::select(ano\_data,c(patientID,km.res.cluster,limma\_res*F**a**c**t**o**r*))*f**i**n**a**l*<sub>*m*</sub>*a**t* &lt;  − *d**a**t**a*.*f**r**a**m**e*(*r**o**w*.*n**a**m**e**s* = *f**i**n**a**l*<sub>*r*</sub>*e**s*patientID,final\_res\[,-c(1,2)\])%&gt;%as.matrix()
final\_col&lt;-data.frame(row.names
=ano\_data*p**a**t**i**e**n**t**I**D*, *C**l**a**s**s* = *a**n**o*<sub>*d*</sub>*a**t**a*km.res.cluster)

limma\_pca &lt;- PCA(final\_mat, graph = FALSE)
fviz\_pca\_ind(limma\_pca, label = “none”, \# hide individual labels
habillage = final\_col$Class, \# color by groups palette = c(“\#00AFBB”,
“\#E7B800”, “\#FC4E07”), addEllipses = TRUE \# Concentration ellipses )

cli&lt;-fread(“../Data/Data/final\_clinical\_40pt.csv”)
meta&lt;-fread(“../Data/Data/meta.csv”,data.table =
F)%&gt;%subset(.,Site==“Stool”)
meta&lt;-merge(dplyr::select(meta,c(“patientID”,“Samples”,“Cycle”)),dplyr::select(cli,c(“patientID”,“PFS”,“PFStime”)),by=“patientID”)
colnames(meta)\[2\]=“SangerID”
meta*G**r**o**u**p* &lt;  − *i**f**e**l**s**e*(*m**e**t**a*Cycle==“BL”,“BL”,“Treat”)
meta\_bl&lt;-subset(meta,Group==“BL”)
meta\_treat&lt;-subset(meta,Group==“Treat”)
otu&lt;-regaMicrobiome*S**t**o**o**l**M**i**c**r**o**b**i**o**m**e*TaxonomyReads$OTU colnames(otu)\[1\]="OTUid" limma\_res\_BL&lt;-subset(limma\_res,Group=="BL") limma\_res\_treat&lt;-subset(limma\_res,Group=="Treat") otu&lt;-subset(otu,OTUid%in%limma\_res$OTUid)

otu\_bl&lt;-otu\[,which(colnames(otu)%in%c(“OTUid”,meta\_bl$SangerID))\]
otu\_treat&lt;-otu\[,which(colnames(otu)%in%c(“OTUid”,meta\_treat$SangerID))\]
otu\_bl\_limma&lt;-subset(otu\_bl,OTUid%in%limma\_res\_BL*O**T**U**i**d*)*o**t**u*<sub>*t*</sub>*r**e**a**t*<sub>*l*</sub>*i**m**m**a* &lt;  − *s**u**b**s**e**t*(*o**t**u*<sub>*t*</sub>*r**e**a**t*, *O**T**U**i**d*OTUid)
otu\_bl\_limma&lt;-data.frame(row.names =
otu\_bl\_limma$OTUid,otu\_bl\_limma\[,-1\])
otu\_bl\_limma&lt;-data.frame(SangerID=colnames(otu\_bl\_limma),t(otu\_bl\_limma))

otu\_treat\_limma&lt;-data.frame(row.names =
otu\_treat\_limma$OTUid,otu\_treat\_limma\[,-1\])
otu\_treat\_limma&lt;-data.frame(SangerID=colnames(otu\_treat\_limma),t(otu\_treat\_limma))

df\_bl&lt;-merge(meta\_bl,otu\_bl\_limma,by=“SangerID”)
df\_treat&lt;-merge(meta\_treat,otu\_treat\_limma,by=“SangerID”)

otu\_bl\_limma\_mat&lt;-data.frame(row.names =
df\_bl*p**a**t**i**e**n**t**I**D*, *d**f*<sub>*b*</sub>*l*\[, − *c*(1 : 6)\])*o**t**u*<sub>*t*</sub>*r**e**a**t*<sub>*l*</sub>*i**m**m**a*<sub>*m*</sub>*a**t* &lt;  − *d**a**t**a*.*f**r**a**m**e*(*r**o**w*.*n**a**m**e**s* = *p**a**s**t**e*0(*d**f*<sub>*t*</sub>*r**e**a**t*patientID,"\_",df\_treat$Cycle),df\_treat\[,-c(1:6)\])

fviz\_nbclust( otu\_bl\_limma\_mat, kmeans, k.max = 10, method = “wss”,
verbose = FALSE)

km.res &lt;- kmeans(scale(otu\_bl\_limma\_mat),3, nstart = 25)
fviz\_cluster(km.res, data = otu\_bl\_limma\_mat,repel = T,labelsize =
12, \# palette = c(“\#00AFBB”, “\#E7B800”, “black”,“red”,“blue”,“gray”),
ggtheme = theme\_minimal(), main = “Kmeans Clustering Plot”)

cluster\_BL&lt;-data.frame(km.res*c**l**u**s**t**e**r*)*c**l**u**s**t**e**r*<sub>*B*</sub>*L*patientID&lt;-rownames(cluster\_BL)
cluster\_BL$km.res.cluster&lt;-paste0("km",cluster\_BL$km.res.cluster)
stat\_num&lt;-cluster\_BL%&gt;%group\_by(km.res.cluster)%&gt;%summarise(Num=n())
cluster\_BL*k**m*.*r**e**s*.*c**l**u**s**t**e**r* &lt;  − *i**f**e**l**s**e*(*c**l**u**s**t**e**r*<sub>*B*</sub>*L*km.res.cluster==stat\_num*k**m*.*r**e**s*.*c**l**u**s**t**e**r*\[*w**h**i**c**h*(*s**t**a**t*<sub>*n*</sub>*u**m*Num&gt;5)\],“km1”,“km2”)

\#\#treat samples fviz\_nbclust( otu\_treat\_limma\_mat, kmeans, k.max =
10, method = “wss”, verbose = FALSE)

set.seed(123) km.res &lt;- kmeans(scale(otu\_treat\_limma\_mat),4,
nstart = 25) fviz\_cluster(km.res, data = otu\_treat\_limma\_mat,repel =
T,labelsize = 12, palette = c(“\#00AFBB”, “\#E7B800”,
“black”,“red”,“blue”,“gray”), ggtheme = theme\_minimal(), main = “Kmeans
Clustering Plot”)
cluster\_treat&lt;-data.frame(km.res*c**l**u**s**t**e**r*)*c**l**u**s**t**e**r*<sub>*t*</sub>*r**e**a**t*patientID&lt;-rownames(cluster\_treat)
cluster\_treat$km.res.cluster&lt;-paste0("km",cluster\_treat$km.res.cluster)
stat\_num&lt;-cluster\_treat%&gt;%group\_by(km.res.cluster)%&gt;%summarise(Num=n())
stat\_num
cluster\_treat$km.res.cluster&lt;-gsub("km4","km2",cluster\_treat$km.res.cluster)
df\_bl&lt;-merge(cluster\_BL,df\_bl,by=“patientID”)
df\_treat*p**a**t**i**e**n**t**I**D* &lt;  − *p**a**s**t**e*0(*d**f*<sub>*t*</sub>*r**e**a**t*patientID,"\_“,df\_treat$Cycle)
df\_treat&lt;-merge(cluster\_treat,df\_treat,by=”patientID“)
fit1&lt;-survfit(Surv(PFStime,PFS) ~ km.res.cluster, data = df\_bl) fit1
fit2&lt;-survfit(Surv(PFStime,PFS) ~ km.res.cluster, data = df\_treat)
fit2 p1&lt;-ggsurvplot(fit1, data=df\_bl,pval.method = T,combine = T,
palette = c(”black“,”\#00AFBB“,”\#E7B800“,”red“,”green“), tables.theme =
theme\_bw(base\_size = 8), risk.table = T, pval = TRUE, ggtheme =
theme\_survminer(), legend.title=”k-means“, risk.table.col =”strata“,
surv.median.line =”hv", risk.table.y.text.col = T, risk.table.y.text = F
) p1

p2&lt;-ggsurvplot(fit2, data=df\_treat,pval.method = T,combine = T,
palette = c(“black”,“\#00AFBB”,“\#E7B800”,“red”), tables.theme =
theme\_bw(base\_size = 8), risk.table = T, pval = TRUE, ggtheme =
theme\_survminer(), legend.title=“k-means”, risk.table.col = “strata”,
surv.median.line = “hv”, risk.table.y.text.col = T, risk.table.y.text =
F ) p2
