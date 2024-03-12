library(Rcpp)
library(Repitools)
library(TFBSTools)
library(motifmatchr)
library(SummarizedExperiment)
library(BSgenome.Mmusculus.UCSC.mm10)
library(JASPAR2020)
library(GenomicFeatures)
library(regioneR)

genome <- getGenome("mm10")


opts <- list(
  tax_group = "vertebrates",
  collection = "CORE",
  matrixtype = "PWM"
)
pwms <- getMatrixSet(JASPAR2020, opts)
pwm_ctcf <- pwms[names(pwms) %in% c("MA0139.1")]

# ZNF143-related peaks
peaks <- read.table("/DATA/users/magnitov/znf143/chipseq/public_data/zhou_data/Zhou_CTCF_peaks_ZNF143_related.bed", header = FALSE)
peaks <- GRanges(seqnames = peaks$V1, ranges = IRanges(start = peaks$V2, end = peaks$V3))

scanned <- matchMotifs(pwm_ctcf, peaks, genome = BSgenome.Mmusculus.UCSC.mm10, p.cutoff = 1, out = "scores", bg = "genome")
scanned_scores <- cbind(annoGR2DF(peaks), as.data.frame(summary(motifScores(scanned))$x))
write.table(scanned_scores[c('chr', 'start', 'end', 'summary(motifScores(scanned))$x')], 
            file="/DATA/users/magnitov/znf143/chipseq/public_data/zhou_data/CTCF_motif_scores.Zhou_CTCF_peaks_ZNF143_related.bed", quote=F, sep="\t", row.names=F, col.names=F)

# ZNF143-unrelated peaks
peaks <- read.table("/DATA/users/magnitov/znf143/chipseq/public_data/zhou_data/Zhou_CTCF_peaks_ZNF143_unrelated.bed", header = FALSE)
peaks <- GRanges(seqnames = peaks$V1, ranges = IRanges(start = peaks$V2, end = peaks$V3))

scanned <- matchMotifs(pwm_ctcf, peaks, genome = BSgenome.Mmusculus.UCSC.mm10, p.cutoff = 1, out = "scores", bg = "genome")
scanned_scores <- cbind(annoGR2DF(peaks), as.data.frame(summary(motifScores(scanned))$x))
write.table(scanned_scores[c('chr', 'start', 'end', 'summary(motifScores(scanned))$x')], 
            file="/DATA/users/magnitov/znf143/chipseq/public_data/zhou_data/CTCF_motif_scores.Zhou_CTCF_peaks_ZNF143_unrelated.bed", quote=F, sep="\t", row.names=F, col.names=F)
