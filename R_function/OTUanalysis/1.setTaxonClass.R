setTaxonClass<-function(taxon_matrix){
  require(dplyr)
  taxon_matrix<-taxon_matrix %>%
    mutate(Kindom=Taxon)%>%
    mutate(Phylum=Taxon)%>%
    mutate(Class=Taxon)%>%
    mutate(Order=Taxon)%>%
    mutate(Family=Taxon)%>%
    mutate(Genus=Taxon)%>%
    mutate(Species=Taxon)
  return(taxon_matrix)
}
