OTUtablemerge<-function(OTUtable_split){ 
  if ("./userProcessedData"%in%list.dirs()) {
    setwd("./userProcessedData")
  }else{
    dir.create("userProcessedData")
    setwd("./userProcessedData")
  }
  TaxonLevels<-c("Kindom","Phylum","Class","Order","Family","Genus","Species")
  data1<-OTUtable_split
  data2<-list()
  data3<-list()
  for (i in seq(length(TaxonLevels))) {
  data2[[i]]<-data.frame(rowname=data1[,grep(TaxonLevels[i],colnames(data1))],data1[,-c(2:9)])
  colnames(data2[[i]])[1]<-TaxonLevels[i]
  data2[[i]]<-data2[[i]]%>%mutate(TaxonClass =rep(TaxonLevels[i],nrow(.)))
  colnames(data2[[i]])[1]<-"MicroName"
  data3[[i]]<-subset(data2[[i]],MicroName!="NA")
  
  }
  df<-data3[which(lapply(data3, nrow)>=1)]
  levels<-c("|p__","|c__","|o__","|f__","|g__","|s__")
  data4<-list()
  for (i in seq(length(df))) {
  nmb<-grep("TaxonClass",colnames(df[[i]]))
  data4[[i]]<-data.frame(select(df[[i]],nmb),select(df[[i]],-nmb))%>%as.data.frame()
  data4[[i]][,3]<-gsub(paste0("\\",levels[i],".*$"),"",data4[[i]][,3])
  }
  OTU_merge<-bind_rows(data4)%>%
    group_by(TaxonClass,MicroName,Taxon)%>%
    summarise_each(sum)
  OTU_merge[,c(1:3)]<-OTU_merge[,c(1,3,2)]
  colnames(OTU_merge)[1:3]<-c("TaxonClass","Taxon","MicroName")
  OTU_merge<-as.data.frame(OTU_merge)
  if (yesno2("Do u want to keep the [kindom] TaxonClass?", yes = "Yes", no = "No")) {
    message("(^_^*) Keep Kindom Finished!!! zxia@copyRiht")
  } else {
    OTU_merge<-subset(OTU_merge,TaxonClass!="Kindom")%>%as.data.frame()
    message("(^_^*) Kindom moved!!! zxia@copyRiht")
  }
  OTU_merge<-OTU_merge[-grep("unclassified",OTU_merge$MicroName),]
  write.csv(OTU_merge,"OTU_merge.csv",row.names = F)
  message("OTU_merge finished in userProcessedData folder!")
  setwd("../")
  return(OTU_merge)
}
