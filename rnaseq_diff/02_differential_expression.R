library(DESeq2)

counts <- as.matrix(read.csv('./counts/counts_deseq2.txt',
                             sep = "\t", row.names = 1))
samples <- read.csv('./counts/samples_deseq2.txt', 
                    sep = "\t", row.names = 1)
samples$condition <- factor(samples$condition)
samples$replicate <- factor(samples$replicate)

dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = samples,
                              design = ~ condition)
keep <- rowSums(counts(dds) >= 10) >= 4
dds <- dds[keep,]

vsd <- vst(dds, blind=FALSE)
plotPCA(vsd, intgroup=c("condition"), returnData = TRUE)

dds <- estimateSizeFactors(dds)
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)

res_dtag_dmso <- results(dds, contrast=c("condition","dTAG","DMSO"), alpha = 0.01, lfcThreshold = log2(1.5))
res_dmso_ra <- results(dds, contrast=c("condition","DMSO_RA","DMSO"), alpha = 0.01, lfcThreshold = log2(1.5))
res_dtag_ra <- results(dds, contrast=c("condition","dTAG_RA","dTAG"), alpha = 0.01, lfcThreshold = log2(1.5))
res_dtag_dmso_ra <- results(dds, contrast=c("condition","dTAG_RA","DMSO_RA"), alpha = 0.01, lfcThreshold = log2(1.5))

write.table(as.data.frame(res_dtag_dmso), 
            file = "./degs/degs_dTAG_DMSO_DESeq.csv")
write.table(as.data.frame(res_dmso_ra), 
            file = "./degs/degs_RA_DMSO_DESeq.csv")
write.table(as.data.frame(res_dtag_ra), 
            file = "./degs/degs_RA_dTAG_DESeq.csv")
write.table(as.data.frame(res_dtag_dmso_ra), 
            file = "./degs/degs_RA_dTAG_DMSO_DESeq.csv")
