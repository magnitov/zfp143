library('regioneR')

genome <- getGenome("hg38")

###
### common peaks
###
zfp143_peaks <- read.table('./k562_data/peaks_common.bed', header = FALSE)

observed_anchors <- c()
permuted_anchors <- c()
zscore_anchors <- c()
for (motifs in c('ZFP143_SBS1_denovo_motifs', 'ZFP143_SBS2_denovo_motifs')){
  motif_positions <- read.table(paste('./k562_data/', motifs, '.hg38.bed', sep=""), header = FALSE)
  motif_positions <- GRanges(seqnames = motif_positions$V1, ranges = IRanges(start = motif_positions$V2, end = motif_positions$V3))
  test_anchors <- permTest(A=zfp143_peaks, B=motif_positions, ntimes=100,
                           randomize.function = circularRandomizeRegions, evaluate.function = numOverlaps, 
                           genome=genome, verbose=TRUE)
  observed_anchors <- append(observed_anchors, test_anchors$numOverlaps$observed)
  permuted_anchors <- append(permuted_anchors, mean(test_anchors$numOverlaps$permuted))
  zscore_anchors <- append(zscore_anchors, test_anchors$numOverlaps$zscore)
}

motif_positions <- read.table('./k562_data/CTCF_motifs.hg38.bed', header = FALSE)
motif_positions <- GRanges(seqnames = motif_positions$V3, ranges = IRanges(start = motif_positions$V4, end = motif_positions$V5))
test_anchors <- permTest(A=zfp143_peaks, B=motif_positions, ntimes=100,
                         randomize.function = circularRandomizeRegions, evaluate.function = numOverlaps, 
                         genome=genome, verbose=TRUE)
observed_anchors <- append(observed_anchors, test_anchors$numOverlaps$observed)
permuted_anchors <- append(permuted_anchors, mean(test_anchors$numOverlaps$permuted))
zscore_anchors <- append(zscore_anchors, test_anchors$numOverlaps$zscore)

test_results <- as.data.frame(do.call(cbind, list(c('Zfp143_SBS1_denovo_motifs', 'Zfp143_SBS2_denovo_motifs', 'CTCF_JASPAR_motifs'), 
                                                  observed_anchors, permuted_anchors, zscore_anchors)))
write.csv(test_results, './k562_data/motifs_enrichment_peaks_common.txt', row.names = FALSE)

###
### Proteintech specific peaks
###
zfp143_peaks <- read.table('./k562_data/peaks_proteintech.bed', header = FALSE)

observed_anchors <- c()
permuted_anchors <- c()
zscore_anchors <- c()
for (motifs in c('ZFP143_SBS1_denovo_motifs', 'ZFP143_SBS2_denovo_motifs')){
  motif_positions <- read.table(paste('./k562_data/', motifs, '.hg38.bed', sep=""), header = FALSE)
  motif_positions <- GRanges(seqnames = motif_positions$V1, ranges = IRanges(start = motif_positions$V2, end = motif_positions$V3))
  test_anchors <- permTest(A=zfp143_peaks, B=motif_positions, ntimes=100,
                           randomize.function = circularRandomizeRegions, evaluate.function = numOverlaps, 
                           genome=genome, verbose=TRUE)
  
  observed_anchors <- append(observed_anchors, test_anchors$numOverlaps$observed)
  permuted_anchors <- append(permuted_anchors, mean(test_anchors$numOverlaps$permuted))
  zscore_anchors <- append(zscore_anchors, test_anchors$numOverlaps$zscore)
}

motif_positions <- read.table('./k562_data/CTCF_motifs.hg38.bed', header = FALSE)
motif_positions <- GRanges(seqnames = motif_positions$V3, ranges = IRanges(start = motif_positions$V4, end = motif_positions$V5))
test_anchors <- permTest(A=zfp143_peaks, B=motif_positions, ntimes=100,
                         randomize.function = circularRandomizeRegions, evaluate.function = numOverlaps, 
                         genome=genome, verbose=TRUE)
observed_anchors <- append(observed_anchors, test_anchors$numOverlaps$observed)
permuted_anchors <- append(permuted_anchors, mean(test_anchors$numOverlaps$permuted))
zscore_anchors <- append(zscore_anchors, test_anchors$numOverlaps$zscore)

test_results <- as.data.frame(do.call(cbind, list(c('Zfp143_SBS1_denovo_motifs', 'Zfp143_SBS2_denovo_motifs', 'CTCF_JASPAR_motifs'), 
                                                  observed_anchors, permuted_anchors, zscore_anchors)))
write.csv(test_results, './k562_data/motifs_enrichment_peaks_znf143.txt', row.names = FALSE)


###
### FLAG specific peaks
###
zfp143_peaks <- read.table('./k562_data/peaks_flag.bed', header = FALSE)

observed_anchors <- c()
permuted_anchors <- c()
zscore_anchors <- c()
for (motifs in c('ZFP143_SBS1_denovo_motifs', 'ZFP143_SBS2_denovo_motifs')){
  motif_positions <- read.table(paste('./k562_data/', motifs, '.hg38.bed', sep=""), header = FALSE)
  motif_positions <- GRanges(seqnames = motif_positions$V1, ranges = IRanges(start = motif_positions$V2, end = motif_positions$V3))
  test_anchors <- permTest(A=zfp143_peaks, B=motif_positions, ntimes=100,
                           randomize.function = circularRandomizeRegions, evaluate.function = numOverlaps, 
                           genome=genome, verbose=TRUE)
  
  observed_anchors <- append(observed_anchors, test_anchors$numOverlaps$observed)
  permuted_anchors <- append(permuted_anchors, mean(test_anchors$numOverlaps$permuted))
  zscore_anchors <- append(zscore_anchors, test_anchors$numOverlaps$zscore)
}

motif_positions <- read.table('./k562_data/CTCF_motifs.hg38.bed', header = FALSE)
motif_positions <- GRanges(seqnames = motif_positions$V3, ranges = IRanges(start = motif_positions$V4, end = motif_positions$V5))
test_anchors <- permTest(A=zfp143_peaks, B=motif_positions, ntimes=100,
                         randomize.function = circularRandomizeRegions, evaluate.function = numOverlaps, 
                         genome=genome, verbose=TRUE)
observed_anchors <- append(observed_anchors, test_anchors$numOverlaps$observed)
permuted_anchors <- append(permuted_anchors, mean(test_anchors$numOverlaps$permuted))
zscore_anchors <- append(zscore_anchors, test_anchors$numOverlaps$zscore)

test_results <- as.data.frame(do.call(cbind, list(c('Zfp143_SBS1_denovo_motifs', 'Zfp143_SBS2_denovo_motifs', 'CTCF_JASPAR_motifs'), 
                                                  observed_anchors, permuted_anchors, zscore_anchors)))
write.csv(test_results, './k562_data/motifs_enrichment_peaks_flag.txt', row.names = FALSE)
