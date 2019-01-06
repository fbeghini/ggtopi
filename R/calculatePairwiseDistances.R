calculate_pairwise_distances <- function(distmat){
  distances <- reshape2::melt(as.matrix(distmat), varnames = c('rows','cols'))
  distances$condizione1 <- sapply(as.character(distances$rows), function(x) strsplit(x,'-')[[1]][2])
  distances$pentatome1 <- sapply(as.character(distances$rows), function(x) str_sub(x, 5,5))
  distances$condizione2 <- sapply(as.character(distances$cols), function(x) strsplit(x,'-')[[1]][2])
  distances$topo1 <- factor(sapply(as.character(distances$rows), function(x) strsplit(x,'-')[[1]][3]))
  distances$topo2 <- factor(sapply(as.character(distances$cols), function(x) strsplit(x,'-')[[1]][3]))
  distances$timepoint1 <- stringr::str_replace(sapply(as.character(distances$rows), function(x) strsplit(x,'-')[[1]][4]), 'T', '') %>% as.numeric
  distances$timepoint2 <- stringr::str_replace(sapply(as.character(distances$cols), function(x) strsplit(x,'-')[[1]][4]), 'T', '') %>% as.numeric

  distances
}
