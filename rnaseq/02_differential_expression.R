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
plotPCA(vsd, intgroup=c("condition"))

dds <- estimateSizeFactors(dds)
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)

res_24h <- results(dds, contrast=c("condition","24H","DMSO"), alpha = 0.01, lfcThreshold = log2(1.5))
res_48h <- results(dds, contrast=c("condition","48H","DMSO"), alpha = 0.01, lfcThreshold = log2(1.5))
res_72h <- results(dds, contrast=c("condition","72H","DMSO"), alpha = 0.01, lfcThreshold = log2(1.5))

write.table(as.data.frame(res_24h), file = "./degs/degs_24H_DESeq.csv")
write.table(as.data.frame(res_48h), file = "./degs/degs_48H_DESeq.csv")
write.table(as.data.frame(res_72h), file = "./degs/degs_72H_DESeq.csv")
