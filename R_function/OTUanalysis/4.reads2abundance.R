reads2abundance<-function(OTUmerge){
  if ("./userProcessedData"%in%list.dirs()) {
    setwd("./userProcessedData")
  }else{
    dir.create("userProcessedData")
    setwd("./userProcessedData")
  }
  datasplit<-group_split(OTUmerge,TaxonClass)
  average <- function(x){
    x/sum(x)
  }
  matrixAverage<-function(matrix){
    apply(matrix[,-1], 1, FUN = sum)/(length(colnames(matrix[,-1])))
  }
  
  abundance<-lapply(datasplit, function(x){
    data<-x[,-c(1,2)]
    data1<-data.frame(data[,1],apply(data[,-1],2,average))%>%as.data.frame()%>%
    mutate(.,Average=matrixAverage(.))
    colnames(data1)[1]<-x[2,1]
    return(data1)
    })
  for (i in seq(length(abundance))) {
    write.csv(abundance[[i]],paste0(colnames(abundance[[i]])[1],"_abundance.csv"),row.names = F)
    message(paste0(colnames(abundance[[i]])[1])," downloaded !")
  }
  setwd("../")
  return(abundance)
  message("AbundanceData finished in userProcessedData")
  } 
  


