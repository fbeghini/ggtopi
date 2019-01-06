loadQiimeData <- function() {
  gg_topi <- import_biom(BIOMfilename = 'inst/extdata/otu_table_mc10_w_tax_rdp.biom',
                         treefilename = 'inst/extdata/rep_set.tre',
                         refseqfilename = 'inst/extdata/rep_set.fna',
                         refseqFunction = parse_taxonomy_default
  )

  mappingfile <- read.delim('inst/extdata/mappingfile', row.names = 1, check.names = FALSE)
  mappingfile$Description %<>% str_replace_all(.,'_','-')
  mappingfile$condizione <- factor(mappingfile$condizione, labels = c('Pentatome + Bifido', 'Pentatome + PBS', 'Empty + Bifido', 'Empty + PBS'))
  sample_names(gg_topi) <- mappingfile[sample_names(gg_topi), 'Description']
  rownames(mappingfile) <- mappingfile$Description

  sample_data(gg_topi) <- mappingfile
  sample_data(gg_topi)$id.topo <- factor(sample_data(gg_topi)$id.topo)

  sample_data(gg_topi)$pentatome <- factor(stringr::str_split(sample_data(gg_topi)$condizione, ' \\+ ', simplify = TRUE)[,1])
  sample_data(gg_topi)$bifido <- factor(stringr::str_split(sample_data(gg_topi)$condizione, ' \\+ ', simplify = TRUE)[,2])

  sample_data(gg_topi)$cond_all <- factor(with(sample_data(gg_topi), paste(timepoint,real_vaccine, real_bifido, sep = '_')))
  sample_data(gg_topi)$cond_vac <- factor(with(sample_data(gg_topi), paste(merge_timepoint,real_vaccine, sep = '_')))
  sample_data(gg_topi)$cond_bif <- factor(with(sample_data(gg_topi), paste(merge_timepoint,real_bifido, sep = '_')))

  sample_data(gg_topi)$vacc_bif <- strtoi(paste(ifelse(sample_data(gg_topi)$real_vaccine=='YES','1','0'),ifelse(sample_data(gg_topi)$real_bifido=='YES','1','0'), sep = ''), 2)

  colnames(tax_table(gg_topi)) <- c("Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species")

  tax_table_filtered <- tax_table(gg_topi) %>%
    as.data.frame %>%
    mutate_all( .funs = function(x) stringr:::str_replace_all(x,"D_.__",""))

  rownames(tax_table_filtered) <- rownames(tax_table(gg_topi))
  tax_table(gg_topi) <-  as.matrix(tax_table_filtered)

  unass_otus <- tax_table(gg_topi) %>%
    data.frame %>%
    tibble::rownames_to_column('OTU') %>%
    filter(Domain == 'Unassigned') %>%
    select(OTU)

  unknown_otus <- tax_table(gg_topi) %>%
    data.frame %>%
    tibble::rownames_to_column('OTU') %>%
    filter(is.na(Genus)) %>%
    select(OTU)

  unknown_family <- tax_table(gg_topi) %>%
    data.frame %>%
    tibble::rownames_to_column('OTU') %>%
    filter(is.na(Family)) %>%
    select(OTU)


  tax_table(gg_topi)[unass_otus$OTU, ] <- rep.int('Unassigned', 7)
  tax_table(gg_topi)[unknown_otus$OTU, 'Genus'] <- 'Unknown'
  tax_table(gg_topi)[unknown_family$OTU, 'Family'] <- 'Unknown'

  gg_topi
}
