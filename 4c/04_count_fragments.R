library(GenomicAlignments)
library(data.table)
library(Repitools)

frags <- fread("/DATA/users/magnitov/znf143/4c/mm10_fragments_DpnII_Csp6I.bed")
frags <- makeGRangesFromDataFrame(frags)

filelist <- list.files("/DATA/users/magnitov/znf143/4c/bam", "bam$", full.names = TRUE)
names(filelist) <- stringr::str_extract(basename(filelist), "^.+(?=\\.mapped.mapq.sorted.bam)")

mat <- sapply(filelist, function(bam) {
  
  message(paste0("Counting ", bam))
  
  gr <- GRanges(readGAlignments(bam))
  oo <- findOverlaps(frags, gr)
  valid <- start(frags[queryHits(oo)]) == start(gr[subjectHits(oo)]) |
    end(frags[queryHits(oo)]) == end(gr[subjectHits(oo)])
  oo <- oo[valid]
  
  freqs <- as.data.table(table(queryHits(oo)))
  freqs$V1 <- as.numeric(freqs$V1)
  
  cts <- rep(0, length(frags))
  cts[freqs$V1] <- freqs$N
  
  cts
  
})

frags_df <- subset(annoGR2DF(frags), select = -c(width))
counts_4c <- cbind(frags_df, mat)
write.csv(counts_4c, "/DATA/users/magnitov/znf143/4c/counts/fragment_counts_all_viewpoints.tsv", row.names=FALSE, quote=FALSE) 