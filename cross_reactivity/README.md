## HEK293T ChIP-seq data analysis

To reproduce some parts of the analysis, you need to download bigwig files for ChIP-seq deposited in GEO.
```
wget https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE271837&format=file&file=GSE271837%5FZNF143%5FProteintech%5FUntreated%2Erpgc%2Ebw
wget https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE271837&format=file&file=GSE271837%5FZNF143%5FProteintech%5FdTAG%5F30min%2Erpgc%2Ebw
wget https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE271837&format=file&file=GSE271837%5FCTCF%5FUntreated%2Erpgc%2Ebw
wget https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE271837&format=file&file=GSE271837%5FCTCF%5FdTAG%5F30min%2Erpgc%2Ebw
```

You may additionally need:
* Blacklist regions for hg38: https://github.com/Boyle-Lab/Blacklist
* ZNF143 ChIP-seq signal in HEK293 cells: http://dc2.cistrome.org/genome_browser/bw/36766_treat.bw
* ZNF143-HA ChIP-seq signals in ZNF143-FKBP HEK293T cells: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE266489
