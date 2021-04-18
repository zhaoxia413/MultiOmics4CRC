OTUanalysis<-function(OTUtable,TaxonLevels,topTaxonomyABvalue){
  require(data.table)
  require(dplyr)
  require(reshape2)
  OTU_readsList<-list()
  OTU_abundanceList<-list()
  for (i in seq_along(TaxonLevels)) {
    OTU_readsList[[i]]<-data.frame(Microname=OTUtable[,grep(TaxonLevels[i],colnames(OTUtable))],OTUtable[,-c(1:7)])
    colnames(OTU_readsList[[i]])[1]="Microname"
    OTU_readsList[[i]]<-OTU_readsList[[i]]%>%group_by(Microname)%>%summarise_each(sum)
    OTU_abundanceList[[i]]<-data.frame(Microname=OTU_readsList[[i]][,1],apply(OTU_readsList[[i]][,-1], 2,function(x)x/sum(x)))
    colnames(OTU_readsList[[i]])[1]=TaxonLevels[i]
    colnames(OTU_abundanceList[[i]])[1]=TaxonLevels[i]
    names(OTU_readsList)[i]=TaxonLevels[i]
    names(OTU_abundanceList)[i]=TaxonLevels[i]
  }
  
  OTU_abundanceList<-lapply(OTU_abundanceList, function(x){
    x<-data.frame(row.names = x[,1],x[,-1])
  })
  
  core_list<-list()
  coreTaxonomy<-list()
  for (i in seq_along(OTU_abundanceList)) {
    for (j in seq_along(OTU_abundanceList[[i]])) {
      index<-which(OTU_abundanceList[[i]][,j ]>=topTaxonomyABvalue[i])
      core_list[[j]]<-data.frame(row.names = rownames(OTU_abundanceList[[i]])[index],
                                 OTU_abundanceList[[i]][index,j ])
      colnames(core_list[[j]])<-colnames(OTU_abundanceList[[i]])[j]
      core_list[[j]]<-data.frame(t(core_list[[j]]))
    }
    coreTaxonomy[[i]]<-do.call(bind_rows,core_list)
    names(coreTaxonomy)[i]=names(OTU_abundanceList)[i]
  }
  OTU_abundanceListTop<-list()
  Others<-list()
  OTU_compostion<-list()
  for (i in seq_along(OTU_abundanceList)) {
    OTU_abundanceListTop[[i]]<-OTU_abundanceList[[i]][which(rownames(OTU_abundanceList[[i]])%in%colnames(coreTaxonomy[[i]])),]
    Others[[i]]<-apply(OTU_abundanceListTop[[i]], 2, function(x){
      1-sum(x)
    })
    OTU_compostion[[i]]<-bind_rows(OTU_abundanceListTop[[i]], Others[[i]])
    rownames(OTU_compostion[[i]])[dim(OTU_compostion[[i]])[1]]="Others"
    names(OTU_compostion)[i]<-names(OTU_abundanceList)[i]
  }
  return(list(TaxonomyReads=OTU_readsList,
              TaxonomyAbundance=OTU_abundanceList,
              coreTaxonomy=coreTaxonomy,
              TaxonomyComposition=OTU_compostion))
}
