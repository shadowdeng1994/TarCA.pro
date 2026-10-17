#' Recover a phylogeny with pairwise MRCA of internal nodes
#'
#' @param DDData A dataframe containing pairs of tips and corresponding MRCA.
#'
#' @return A tree file of class "phylo"
#'
#' @importFrom ape as.phylo
#' @importFrom castor get_pairwise_mrcas
#' @importFrom dplyr %>% arrange bind_rows filter group_by left_join min_rank mutate n rename right_join select summarise
#' @importFrom ggtree ggtree
#' @importFrom stats na.omit p.adjust pchisq
#' @importFrom tibble as_tibble column_to_rownames remove_rownames rownames_to_column
#' @importFrom tidyr gather replace_na separate
#'
#' @examples
#' library(dplyr)
#' library(tidyr)
#' tmp.tree <- ape::rtree(10)
#' tmp1 <- sample(1:tmp.tree$Nnode,5)
#' tmp2 <- data.frame(T1=gl(5,5),T2=gl(5,1,25)) %>%
#' filter(T1!=T2) %>%
#' mutate(T1=tmp1[T1],T2=tmp1[T2]) %>%
#' mutate(MRCA=castor::get_pairwise_mrcas(tmp.tree,T1,T2))
#' tmp2 %>% fun.GetPhyloWithPairMRCA
#'
fun.GetPhyloWithPairMRCA <- function(DDData){
    DDData %>%
    gather(GGG,VVV,-MRCA) %>%
    group_by(MRCA,VVV) %>% summarise %>% arrange(MRCA) %>%
    group_by(MRCA) %>% mutate(Weight=n()) %>%
    arrange(VVV,-Weight) %>%
    group_by(VVV) %>% mutate(RRR=min_rank(-Weight)) %>%
    group_by %>% left_join(mutate(.,To=MRCA,RRR=RRR-1) %>% select(To,RRR)) %>%
    group_by(VVV) %>% mutate(To=replace_na(To,VVV[1])) %>%
    group_by(parent = MRCA, node = To) %>% summarise %>%
    arrange(parent,node) %>% filter(parent!=node) %>%
    ape::as.phylo()
}



