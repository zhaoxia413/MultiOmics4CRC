plotCompositions<-function(abundanceList,meta,ShowTaxonLevels="Genus",
                                  top_nPhylum=4,
                                  top_nClass=10,
                                  top_nOrder=10,
                                  top_nFamily=15,
                                  top_nGenus=20,
                                  top_nSpecies=20){
  if ("./userProcessedData"%in%list.dirs()) {
    setwd("./userProcessedData")
  }else{
    dir.create("userProcessedData")
    setwd("./userProcessedData")
  }
  othervalue<-function(x){1-sum(x)}
  message("Compute the top_n taxon...")
  top<-list()
  Others<-list()
  Others1<-list()
  top1<-list()
  TaxonLevels<-sapply(abundanceList, function(x){colnames(x)[1]})
  for (i in seq(length(abundanceList))) {
    if(TaxonLevels[i]=="Phylum") {
      top[[i]]<-top_n(abundanceList[[i]],top_nPhylum,Average)
      print(TaxonLevels[i])
    }else if (TaxonLevels[i]=="Class") {
      top[[i]]<-top_n(abundanceList[[i]],top_nClass,Average)
      print(TaxonLevels[i])
    }else if (TaxonLevels[i]=="Order") {
      top[[i]]<-top_n(abundanceList[[i]],top_nOrder,Average)
      print(TaxonLevels[i])
    }else if (TaxonLevels[i]=="Family") {
      top[[i]]<-top_n(abundanceList[[i]],top_nFamily,Average)
      print(TaxonLevels[i])
    }else if (TaxonLevels[i]=="Genus") {
      top[[i]]<-top_n(abundanceList[[i]],top_nGenus,Average)
      print(TaxonLevels[i])
    }else if (TaxonLevels[i]=="Species") {
      top[[i]]<-top_n(abundanceList[[i]],top_nSpecies,Average)
      print(TaxonLevels[i])
    }
    Others[[i]]<-top[[i]][,-1] %>% apply(.,2,FUN =othervalue)
    Others1[[i]]<- data.frame(rowname = "Others",t(Others[[i]]))
    colnames(Others1[[i]])[1]<-colnames(top[[i]])[1]
    top1[[i]]<- rbind(top[[i]], Others1[[i]])%>%
      mutate(TaxonClass = rep(colnames(.)[1],nrow(.)))
  }
  ##plot
  for (i in seq(length(top1))) {
    colnames(top1[[i]])[1]<- "MicroName"
  }
  merg_top<-bind_rows(top1)
  write.csv(merg_top,"merged_TaxonClass_Abundance.csv",row.names = F)
  merg_top<-merg_top[,-(grep("Average",colnames(merg_top)))]%>%
    melt(.,id.vars=c("MicroName","TaxonClass"),
         variable.name="Samples",
         value.name = "Abundance")
  plotdata<-merg_top
  write.csv(plotdata,"TaxonClass_Abundance_plotdata.csv",row.names = F)
  setwd("../")
  message("TaxonClassAbundance_plotdata finished in userProcessedData")
  
  ##plot
  message("plot composition ...")
  
  if ("./compositionPlotResults"%in%list.dirs()) {
    setwd("./compositionPlotResults")
  }else{
    dir.create("compositionPlotResults")
    setwd("./compositionPlotResults")
  }
  col31<-c("#303841","#D72323","#377F5B","#F2FCFC","#375B7F","#f0027f",
           "#FAF8DE","#666666","#BDF1F6","#023782","#5e4fa2","#F1C40F",
           "#ff7f00","#cab2d6","#240041","#ffff99","#0E3BF0","#a65628",
           "#f781bf","#808FA6","#2EB872","#F0FFE1","#F33535","#011F4E",
           "#82B269","#D3C13E","#3F9DCD","#014E1F","#AFFFDF","#3D002E",
           "#3A554A")
  plotdata<-merge(meta,plotdata,by = "Samples")
  plotdata$Samples<-reorder(plotdata$Samples,plotdata$Abundance)
  plot<-list()
  plotdata1<-list()
  d<-list()
  g<-list()
  TaxonLevels<-unique(plotdata$TaxonClass)
  plotdata<-plotdata[order(plotdata$Abundance,decreasing = T),]
  for (i in seq(length(TaxonLevels))) {
    plotdata1[[i]]<-subset(plotdata,TaxonClass==TaxonLevels[i])
    d[[i]]<-subset(plotdata1[[i]],MicroName==unique(plotdata1[[i]]$MicroName)[1])
    g[[i]]<-d[[i]][order(d[[i]]$Abundance,decreasing = TRUE),]
    plotdata1[[i]]$Samples<-factor(plotdata1[[i]]$Samples,levels=g[[i]]$Samples)
    plot[[i]]<- ggplot(plotdata1[[i]],
                       aes(Samples,Abundance,fill= MicroName))+
      geom_bar(stat = "identity", width=1)+
      theme_minimal()+scale_fill_manual(values=col31)+
      theme( axis.line = element_line(arrow = arrow()),axis.title.y = element_text(size = 12),
             axis.title.x = element_text(size = 12),
             legend.text = element_text(size = 12),
             axis.text.x = element_blank(),
             axis.text.y = element_text(size = 12),axis.line.y = element_line(size = 1),
             axis.line.x = element_line(size = 1),legend.title = element_text(size = 12,face = "bold"))+
      labs(fill=TaxonLevels[i])+
      scale_y_continuous(expand = c(0, 0))+
      facet_wrap(~Group,scales = "free")
    plot[[i]]
    namepdf<-paste0(TaxonLevels[i],"_composion.pdf")
    namepng<-paste0(TaxonLevels[i],"_composion.png")
    ggsave(namepdf,scale = 1, width = 60, 
           height = 80, units =  "cm",
           dpi = 300, limitsize = TRUE)
    ggsave(namepng,scale = 1, width = 60, height = 80, 
           units =  "cm",dpi = 300, limitsize = TRUE)
    message("plot",TaxonLevels[i]," have been saved !")
  }
  print(plot[[grep(ShowTaxonLevels,TaxonLevels)]])
  setwd("../")
  message(paste0("Current directory:",getwd()))
  return(list(plotdata=plotdata,barplots=plot))
}
