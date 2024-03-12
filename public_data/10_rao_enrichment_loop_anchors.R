library('regioneR')

genome <- getGenome("hg19")

###
### K562 common, Proteintech-specific, FLAG-specific peaks
###
loops_anchors <- read.table('./rao_data/Rao_K562_HiCCUPS_loop_anchors.bed', header = FALSE)

observed_anchors <- c()
permuted_anchors <- c()
zscore_anchors <- c()
for (dataset in c('peaks_common', 'peaks_proteintech', 'peaks_flag')){
  chip_peaks <- read.table(paste('./rao_data/', dataset, '.liftOver_hg19.bed', sep=""), header = FALSE)
  chip_peaks <- GRanges(seqnames = chip_peaks$V1, ranges = IRanges(start = chip_peaks$V2, end = chip_peaks$V3))
  test_anchors <- permTest(A=loops_anchors, B=chip_peaks, ntimes=100,
                           randomize.function = circularRandomizeRegions, evaluate.function = numOverlaps, 
                           genome=genome, verbose=TRUE)
    
  observed_anchors <- append(observed_anchors, test_anchors$numOverlaps$observed)
  permuted_anchors <- append(permuted_anchors, mean(test_anchors$numOverlaps$permuted))
  zscore_anchors <- append(zscore_anchors, test_anchors$numOverlaps$zscore)
}
test_results <- as.data.frame(do.call(cbind, list(c('peaks_common', 'peaks_proteintech', 'peaks_flag'), 
                                                  observed_anchors, permuted_anchors, zscore_anchors)))
write.csv(test_results, './rao_data/K562_loop_anchors_enrichment_znf143_datasets.csv', row.names = FALSE)

###
### K562 data from Rao et al.
###
observed_anchors <- c()
permuted_anchors <- c()
zscore_anchors <- c()
datasets <- list.files("./rao_data/encode/", pattern= "K562")
datasets <- datasets[grep('HiCCUPS', datasets, invert=TRUE)]
datasets <- datasets[grep('enrichment', datasets, invert=TRUE)]
for (dataset in datasets){
  chip_peaks <- read.table(paste('./rao_data/encode/', dataset, sep=""), header = FALSE)
  chip_peaks <- GRanges(seqnames = chip_peaks$V1, ranges = IRanges(start = chip_peaks$V2, end = chip_peaks$V3))
  test_anchors <- permTest(A=loops_anchors, B=chip_peaks, ntimes=100,
                           randomize.function = circularRandomizeRegions, evaluate.function = numOverlaps, 
                           genome=genome, verbose=TRUE)
  
  observed_anchors <- append(observed_anchors, test_anchors$numOverlaps$observed)
  permuted_anchors <- append(permuted_anchors, mean(test_anchors$numOverlaps$permuted))
  zscore_anchors <- append(zscore_anchors, test_anchors$numOverlaps$zscore)
}
  
test_results <- as.data.frame(do.call(cbind, list(datasets, observed_anchors, permuted_anchors, zscore_anchors)))
write.csv(test_results, './rao_data/K562_loop_anchors_enrichment_rao_datasets.csv', row.names = FALSE)
