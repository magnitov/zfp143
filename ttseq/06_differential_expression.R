library(DESeq2)

counts <- as.matrix(read.csv('./counts/counts_deseq2.txt',
                             sep = "\t", row.names = 1))
samples <- read.csv('./counts/samples_deseq2.ZFP143.txt', 
                    sep = "\t", row.names = 1)
samples$time <- factor(samples$time)
samples$replicate <- factor(samples$replicate)

dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = samples,
                              design = ~ time+replicate)
keep <- rowSums(counts(dds) >= 10) >= 2
dds <- dds[keep,]

vsd <- vst(dds, blind=FALSE)
plotPCA(vsd, intgroup=c("replicate", "time"))

dds <- estimateSizeFactors(dds)
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)

res_2h <- results(dds, contrast=c("time","2H","0H"), alpha = 0.01)
res_6h <- results(dds, contrast=c("time","6H","0H"), alpha = 0.01)
res_24h <- results(dds, contrast=c("time","24H","0H"), alpha = 0.01)

write.table(as.data.frame(res_2h), 
            file = "./degs/degs_2H_DESeq.csv")
write.table(as.data.frame(res_6h), 
            file = "./degs/degs_6H_DESeq.csv")
write.table(as.data.frame(res_24h), 
            file = "./degs/degs_24H_DESeq.csv")