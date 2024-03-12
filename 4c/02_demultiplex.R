# Load packages
library(Biostrings)
library(data.table)
library(BiocParallel)

filterByPrimer <- function(fq1, fq2, primer, max.mismatch, RE = NULL) {
  
  # Find primer hits in first set of reads, allowing for max.mismatch mismatches
  hits <- vcountPattern(primer, fq1, max.mismatch = max.mismatch) > 0
  
  # Keep reads with primer hits and their paired reads
  fq1_filtered <- fq1[hits]
  fq2_filtered <- fq2[hits]
  
  # If a RE sequence is given, trim the reads so they start with the RE
  # recognition site
  if (!is.null(RE)) {
    # Find RE cut site positions in first set of reads
    RE_pos <- vmatchPattern(RE, fq1_filtered)
    # Keep reads with a cut site
    hits <- lengths(RE_pos) == 1
    fq1_filtered <- fq1_filtered[hits]
    fq2_filtered <- fq2_filtered[hits]
    # Get ranges from start of RE sites to ends of reads
    trim_ranges <- IRanges(start(unlist(RE_pos[hits])), width(fq1_filtered))
    # Extract reads at specified ranges
    fq1_filtered <- subseq(fq1_filtered, trim_ranges)
    # Trim the base qualities as well
    quals <- subseq(mcols(fq1_filtered)$qualities, trim_ranges)
    mcols(fq1_filtered)$qualities <- quals
  }
  
  return(list(fq1 = fq1_filtered, fq2 = fq2_filtered))
}

splitReads <- function(r1, r2, primers, max.mismatch, prefix) {
  # Read fastq files
  message("------ Reading R1 reads ------")
  fq1 <- readDNAStringSet(r1, format = "fastq", with.qualities = TRUE)
  message("------ Reading R2 reads ------")
  fq2 <- readDNAStringSet(r2, format = "fastq", with.qualities = TRUE)
  
  # Read primer table
  primers <- fread(ps)
  
  #### Find forward reads which contain VP primers and trim the reads up to RE1 site
  message("------ Splitting viewpoints and trimming primers in forward reads ------")
  
  # Subset forward primers from primer table
  r1_primers <- DNAStringSet(primers[direction == "fwd", primer_seq])
  names(r1_primers) <- primers[direction == "fwd", vp_name]
  
  # For each forward primer, subset forward reads which contain the primer
  # sequence (allowing up to max.mismatch mismatches) and the RE1 cut site, and
  # subset the corresponding paired reverse reads. Trim forward reads up to RE1
  # sites.
  splitVP <- lapply(r1_primers, function(primer) {
    RE1 <- primers[primer_seq == as.character(primer), re1]
    filterByPrimer(fq1, fq2, primer, max.mismatch, RE = RE1)
  })
  splitVP <- splitVP[!sapply(splitVP, is.null)]
  
  
  #### Find reverse reads which contain VP primers
  message("------ Splitting viewpoints and trimming primers in reverse reads ------")
  
  # Subset forward and reverse reads by primer matches in reverse reads
  splitVP <- lapply(setNames(nm = names(splitVP)), function(vp) {
    primer <- primers[direction == "rev" & vp_name == vp, primer_seq]
    fq1 <- splitVP[[vp]]$fq1
    fq2 <- splitVP[[vp]]$fq2
    fqlist <- filterByPrimer(fq2, fq1, primer = primer, max.mismatch = max.mismatch)
    if (is.null(fqlist)) return(NULL) # If no primers were found return NULL
    names(fqlist) <- c("fq2", "fq1")
    fqlist
  })
  
  #### Save data
  message("------ Saving split FASTQ files ------")
  
  split_reads <- lapply(splitVP, function(x) x[["fq1"]])
  split_reads <- unlist(split_reads)
  
  lapply(setNames(nm = names(split_reads)), function(x) {
    writeXStringSet(split_reads[[x]],
                    paste0(prefix, ".", x, ".fastq.gz"),
                    append = FALSE, compress = "gzip",
                    format = "fastq")
  })
}

####
#### Demultiplex 4C data
####
ps <- "/DATA/users/magnitov/znf143/4c/primers.txt"
max.mismatch = 1

# ZFP143 DMSO rep1
r1 <- "/DATA/users/magnitov/znf143/4c/fastq/4C_DMSO_rep1_R1.fastq"
r2 <- "/DATA/users/magnitov/znf143/4c/fastq/4C_DMSO_rep1_R2.fastq"
prefix <- "/DATA/users/magnitov/znf143/4c/fastq_split/4C_DMSO_rep1"
splitReads(r1, r2, ps, max.mismatch, prefix)

# ZFP143 DMSO rep2
r1 <- "/DATA/users/magnitov/znf143/4c/fastq/4C_DMSO_rep2_R1.fastq"
r2 <- "/DATA/users/magnitov/znf143/4c/fastq/4C_DMSO_rep2_R2.fastq"
prefix <- "/DATA/users/magnitov/znf143/4c/fastq_split/4C_DMSO_rep2"
splitReads(r1, r2, ps, max.mismatch, prefix)

# ZFP143 dTAG_6H rep1
r1 <- "/DATA/users/magnitov/znf143/4c/fastq/4C_dTAG_6H_rep1_R1.fastq"
r2 <- "/DATA/users/magnitov/znf143/4c/fastq/4C_dTAG_6H_rep1_R2.fastq"
prefix <- "/DATA/users/magnitov/znf143/4c/fastq_split/4C_dTAG_6H_rep1"
splitReads(r1, r2, ps, max.mismatch, prefix)

# ZFP143 dTAG_6H rep2
r1 <- "/DATA/users/magnitov/znf143/4c/fastq/4C_dTAG_6H_rep2_R1.fastq"
r2 <- "/DATA/users/magnitov/znf143/4c/fastq/4C_dTAG_6H_rep2_R2.fastq"
prefix <- "/DATA/users/magnitov/znf143/4c/fastq_split/4C_dTAG_6H_rep2"
splitReads(r1, r2, ps, max.mismatch, prefix)
