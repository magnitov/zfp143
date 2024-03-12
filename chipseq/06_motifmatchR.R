library(Rcpp)
library(TFBSTools)
library(motifmatchr)
library(SummarizedExperiment)
library(BSgenome.Mmusculus.UCSC.mm10)
library(BSgenome.Hsapiens.UCSC.hg38)
library(JASPAR2020)

# ZFP143 motifs from MEME
pwm1 <- PWMatrix(ID="ZNF143_SBS1", name="ZNF143_SBS1", 
                 bg=c(A=0.25, C=0.25, G=0.25, T=0.25),
                 profileMatrix=matrix(c( 0.127817, 0.338379, 0.101917, 0.431887,
                                         0.152371, 0.090817, 0.059872, 0.696939,
                                         0.021863, 0.957619, 0.000000, 0.020518,
                                         0.000000, 0.989909, 0.000000, 0.010091,
                                         0.017827, 0.981500, 0.000000, 0.000673,
                                         0.784057, 0.000336, 0.166498, 0.049109,
                                         0.067272, 0.170535, 0.596704, 0.165489,
                                         0.342415, 0.436596, 0.182980, 0.038009,
                                         0.647830, 0.104945, 0.199125, 0.048100,
                                         0.071981, 0.083081, 0.263370, 0.581567,
                                         0.024554, 0.349479, 0.479650, 0.146317,
                                         0.001009, 0.971409, 0.027245, 0.000336,
                                         0.256979, 0.442314, 0.001682, 0.299025,
                                         0.068618, 0.453414, 0.115035, 0.362933,
                                         0.094181, 0.447023, 0.067608, 0.391187,
                                         0.184326, 0.099899, 0.553986, 0.161789,
                                         0.009082, 0.569122, 0.299697, 0.122099,
                                         0.110999, 0.135553, 0.506559, 0.246889,
                                         0.138917, 0.409687, 0.280525, 0.170871,
                                         0.128153, 0.443996, 0.199798, 0.228052),
                                      byrow=FALSE, nrow=4,
                                      dimnames=list(c("A", "C", "G", "T"))))

pwm2 <- PWMatrix(ID="ZNF143_SBS2", name="ZNF143_SBS2", 
                 bg=c(A=0.25, C=0.25, G=0.25, T=0.25),
                 profileMatrix=matrix(c( 0.395386,  0.037391,  0.559268,  0.007955, 
                                         0.513126,  0.004773,  0.470167,  0.011933, 
                                         0.992045,  0.007955,  0.000000,  0.000000, 
                                         0.005569,  0.994431,  0.000000,  0.000000, 
                                         0.000000,  0.033413,  0.000000,  0.966587, 
                                         0.915672,  0.030231,  0.023071,  0.031026, 
                                         0.004773,  0.991249,  0.000000,  0.003978, 
                                         0.921241,  0.019093,  0.053302,  0.006364, 
                                         0.465394,  0.075577,  0.067621,  0.391408, 
                                         0.089897,  0.283214,  0.093079,  0.533811, 
                                         0.040573,  0.051710,  0.009547,  0.898170, 
                                         0.000796,  0.971360,  0.000000,  0.027844, 
                                         0.000000,  0.999204,  0.000000,  0.000796, 
                                         0.000000,  0.994431,  0.000000,  0.005569, 
                                         0.891010,  0.000000,  0.104216,  0.004773, 
                                         0.080350,  0.070008,  0.745426,  0.104216, 
                                         0.412888,  0.361177,  0.190135,  0.035800, 
                                         0.683373,  0.088305,  0.178998,  0.049324, 
                                         0.100239,  0.036595,  0.326969,  0.536197, 
                                         0.058075,  0.252188,  0.528242,  0.161496, 
                                         0.027049,  0.926014,  0.019889,  0.027049 ),
                                      byrow=FALSE, nrow=4,
                                      dimnames=list(c("A", "C", "G", "T"))))

pwm1@profileMatrix <- t(t(pwm1@profileMatrix)/colSums(pwm1@profileMatrix))
pwm2@profileMatrix <- t(t(pwm2@profileMatrix)/colSums(pwm2@profileMatrix))

###
### Mouse genome
###
chromosomes <- GRanges(seqnames = seqnames(BSgenome.Mmusculus.UCSC.mm10),
                       ranges = IRanges(1, seqlengths(BSgenome.Mmusculus.UCSC.mm10)))
chromosomes <- keepStandardChromosomes(chromosomes, pruning.mode="coarse")[1:20]

scanned <- matchMotifs(pwms = pwm1, subject = chromosomes,
                       genome = BSgenome.Mmusculus.UCSC.mm10, out = "positions", bg = "genome")
write.table(scanned, file="/DATA/users/magnitov/znf143/chipseq/motifs/ZFP143_SBS1_denovo_motifs.mm10.bed", quote=F, sep="\t", row.names=F, col.names=F)

scanned <- matchMotifs(pwms = pwm2, subject = chromosomes,
                       genome = BSgenome.Mmusculus.UCSC.mm10, out = "positions", bg = "genome")
write.table(scanned, file="/DATA/users/magnitov/znf143/chipseq/motifs/ZFP143_SBS2_denovo_motifs.mm10.bed", quote=F, sep="\t", row.names=F, col.names=F)

###
### Human genome
###
chromosomes <- GRanges(seqnames = seqnames(BSgenome.Hsapiens.UCSC.hg38),
                       ranges = IRanges(1, seqlengths(BSgenome.Hsapiens.UCSC.hg38)))
chromosomes <- keepStandardChromosomes(chromosomes, pruning.mode="coarse")[1:23]

scanned <- matchMotifs(pwms = pwm1, subject = chromosomes,
                       genome = BSgenome.Hsapiens.UCSC.hg38, out = "positions", bg = "genome")
write.table(scanned, file="/DATA/users/magnitov/znf143/chipseq/motifs/ZFP143_SBS1_denovo_motifs.hg38.bed", quote=F, sep="\t", row.names=F, col.names=F)

scanned <- matchMotifs(pwms = pwm2, subject = chromosomes,
                       genome = BSgenome.Hsapiens.UCSC.hg38, out = "positions", bg = "genome")
write.table(scanned, file="/DATA/users/magnitov/znf143/chipseq/motifs/ZFP143_SBS2_denovo_motifs.hg38.bed", quote=F, sep="\t", row.names=F, col.names=F)

###
### Scanning motifs from JASPAR
###
opts <- list(
  tax_group = "vertebrates",
  collection = "CORE",
  matrixtype = "PWM"
)
pwms <- getMatrixSet(JASPAR2020, opts)

### CTCF in mouse and human
pwm_ctcf <- pwms[names(pwms) %in% c("MA0139.1")]

chromosomes <- GRanges(seqnames = seqnames(BSgenome.Mmusculus.UCSC.mm10),
                       ranges = IRanges(1, seqlengths(BSgenome.Mmusculus.UCSC.mm10)))
chromosomes <- keepStandardChromosomes(chromosomes, pruning.mode="coarse")[1:20]

scanned <- matchMotifs(pwms = pwm_ctcf, subject = chromosomes,
                       genome = BSgenome.Mmusculus.UCSC.mm10, out = "positions", bg = "genome")
write.table(scanned, file="/DATA/users/magnitov/znf143/chipseq/motifs/CTCF_motifs.mm10.bed", quote=F, sep="\t", row.names=F, col.names=F)

chromosomes <- GRanges(seqnames = seqnames(BSgenome.Hsapiens.UCSC.hg38),
                       ranges = IRanges(1, seqlengths(BSgenome.Hsapiens.UCSC.hg38)))
chromosomes <- keepStandardChromosomes(chromosomes, pruning.mode="coarse")[1:23]

scanned <- matchMotifs(pwms = pwm_ctcf, subject = chromosomes,
                       genome = BSgenome.Hsapiens.UCSC.hg38, out = "positions", bg = "genome")
write.table(scanned, file="/DATA/users/magnitov/znf143/chipseq/motifs/CTCF_motifs.hg38.bed", quote=F, sep="\t", row.names=F, col.names=F)

### Other motifs in mouse
chromosomes <- GRanges(seqnames = seqnames(BSgenome.Mmusculus.UCSC.mm10),
                       ranges = IRanges(1, seqlengths(BSgenome.Mmusculus.UCSC.mm10)))
chromosomes <- keepStandardChromosomes(chromosomes, pruning.mode="coarse")[1:20]

for (pwm_name in names(pwms)){
  print(pwm_name)
  pwm_to_scan <- pwms[names(pwms) %in% c(pwm_name)]
  scanned <- matchMotifs(pwms = pwm_to_scan, subject = chromosomes,
                         genome = BSgenome.Mmusculus.UCSC.mm10, out = "positions", bg = "genome")
  write.table(scanned, file=paste("/DATA/users/magnitov/znf143/genome/motifmatchR/", pwm_name, "_motifmatchR.mm10.bed", sep=""), quote=F, sep="\t", row.names=F, col.names=F)
  
}
