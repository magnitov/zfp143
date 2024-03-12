library(Rcpp)
library(regioneR)
library(SummarizedExperiment)
library(BSgenome.Mmusculus.UCSC.mm10)

genome <- getGenome("mm10")
zfp143_peaks <- read.table('/DATA/users/magnitov/znf143/chipseq/peaks/ZFP143_peaks.bed', header = FALSE)

###
### Calculate enrichment in peaks for de novo Zfp143 motifs
###
observed_anchors <- c()
permuted_anchors <- c()
zscore_anchors <- c()
for (motifs in c('ZFP143_SBS1_denovo_motifs', 'ZFP143_SBS2_denovo_motifs')){
  motif_positions <- read.table(paste('/DATA/users/magnitov/znf143/chipseq/motifs/', motifs, '.mm10.bed', sep=""), header = FALSE)
  motif_positions <- GRanges(seqnames = motif_positions$V1, ranges = IRanges(start = motif_positions$V2, end = motif_positions$V3))
  test_anchors <- permTest(A=zfp143_peaks, B=motif_positions, ntimes=100,
                           randomize.function = circularRandomizeRegions, evaluate.function = numOverlaps, 
                           genome=genome, verbose=TRUE)
  
  observed_anchors <- append(observed_anchors, test_anchors$numOverlaps$observed)
  permuted_anchors <- append(permuted_anchors, mean(test_anchors$numOverlaps$permuted))
  zscore_anchors <- append(zscore_anchors, test_anchors$numOverlaps$zscore)
}

test_results <- as.data.frame(do.call(cbind, list(c('ZFP143_SBS1_denovo_motifs', 'ZFP143_SBS2_denovo_motifs'), 
                                                  observed_anchors, permuted_anchors, zscore_anchors)))
write.csv(test_results, '/DATA/users/magnitov/znf143/chipseq/motifs/zfp143_peaks_zfp143_motifs_enrichment.csv', row.names = FALSE)


###
### Calculate enrichment in peaks for JASPAR motifs
###
jaspar_motifs_predictions_ids <- list.files(path = "/DATA/users/magnitov/znf143/genome/motifmatchR/", pattern = ".bed")
jaspar_motifs_predictions_ids <- gsub("_motifmatchR.mm10.bed", "", jaspar_motifs_predictions_ids)

observed_anchors <- c()
permuted_anchors <- c()
zscore_anchors <- c()
pwm_names <- c()
for (motif_id in jaspar_motifs_predictions_ids){
  print(motif_id)
  motif_positions <- read.table(paste('/DATA/users/magnitov/znf143/genome/motifmatchR/', motif_id, '_motifmatchR.mm10.bed', sep=""), header = FALSE)
  motif_positions <- GRanges(seqnames = motif_positions$V3, ranges = IRanges(start = motif_positions$V4, end = motif_positions$V5))
  test_anchors <- permTest(A=zfp143_peaks, B=motif_positions, ntimes=100,
                           randomize.function = circularRandomizeRegions, evaluate.function = numOverlaps, 
                           genome=genome, force.parallel=TRUE, verbose=TRUE)
  
  observed_anchors <- append(observed_anchors, test_anchors$numOverlaps$observed)
  permuted_anchors <- append(permuted_anchors, mean(test_anchors$numOverlaps$permuted))
  zscore_anchors <- append(zscore_anchors, test_anchors$numOverlaps$zscore)
  pwm_names <- append(pwm_names, motif_id)
}

test_results <- as.data.frame(do.call(cbind, list(pwm_names, observed_anchors, permuted_anchors, zscore_anchors)))
write.csv(test_results, '/DATA/users/magnitov/znf143/chipseq/motifs/zfp143_peaks_jaspar_motifs_enrichment.csv', row.names = FALSE)

