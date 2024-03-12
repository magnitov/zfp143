suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(Biostrings))
suppressPackageStartupMessages(library(BSgenome.Mmusculus.UCSC.mm10))

digestGenome <- function(RE1, RE2, genome, out) {
  
  # Find RE1 and RE2 sites in the genome
  message("Scanning cut sites")
  m1 <- unique(unstrand(vmatchPattern(RE1, genome)))
  m2 <- unique(unstrand(vmatchPattern(RE2, genome)))
  
  mcols(m1)$re <- "re1"
  mcols(m2)$re <- "re2"
  m <- sort(c(m1, m2))
  
  # Keep standard chromosomes
  keepchr <- standardChromosomes(genome)
  keepchr <- keepchr[keepchr != "chrM"]
  m <- keepSeqlevels(m, keepchr, pruning.mode = "coarse")
  
  # Remove blind (RE1-RE1; RE2-RE2) fragments
  message("Filtering out blind fragments")
  
  frags <- as.data.table(m)[, -c(4, 5)]
  frags[, ":=" (following.re = re[.I + 1],
                following.end = end[.I + 1],
                following.chr = seqnames[.I + 1])]
  frags <- frags[re != following.re]
  frags <- frags[seqnames == following.chr]
  frags[, ":=" (start = start, end = following.end)]
  
  # Clean and add direction information
  frags[, direction := ifelse(re == "re1", "fwd", "rev")]
  frags <- frags[, -c(4:7)]
  
  # Sort
  frags <- frags[order(seqnames, start, end)]
  
  # Write
  fwrite(frags, out, sep = "\t", col.names = TRUE)
}

RE1 <- "GATC"
RE2 <- "GTAC"
genome <- BSgenome.Mmusculus.UCSC.mm10::BSgenome.Mmusculus.UCSC.mm10

digestGenome(
  RE1, RE2, genome,
  out = "/DATA/users/magnitov/znf143/4c/mm10_fragments_DpnII_Csp6I.bed"
)