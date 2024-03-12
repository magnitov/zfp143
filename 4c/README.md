## 4C-seq data analysis

We thank Moreno Martinović for writing and sharing the 4C-seq data processing pipeline.

To reproduce the 4C-seq profiles, you need to download counts per restriction fragment deposited in GEO.
```
wget https://ftp.ncbi.nlm.nih.gov/geo/series/GSE260nnn/GSE260914/suppl/GSE260914%5F4c%5Fnormalised%5Fcounts%5Fper%5Ffragment.tsv.gz
```

To reproduce the genomic tracks, you need to download bigwig files for ChIP-seq and TT-seq deposited in GEO.
```
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8127nnn/GSM8127953/suppl/GSM8127953%5FZFP143%5FDMSO.rpgc.bw
wget ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8127nnn/GSM8127954/suppl/GSM8127954%5FZFP143%5FdTAG%5F2H.rpgc.bw
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8127nnn/GSM8127951/suppl/GSM8127951%5FCTCF%5FDMSO.calibrated.bw
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8127nnn/GSM8127952/suppl/GSM8127952%5FCTCF%5FdTAG%5F6H.calibrated.bw
wget https://ftp.ncbi.nlm.nih.gov/geo/series/GSE260nnn/GSE260914/suppl/GSE260914%5FTTseq%5FDMSO%5Fforward.bw
wget https://ftp.ncbi.nlm.nih.gov/geo/series/GSE260nnn/GSE260914/suppl/GSE260914%5FTTseq%5FDMSO%5Freverse.bw
wget https://ftp.ncbi.nlm.nih.gov/geo/series/GSE260nnn/GSE260914/suppl/GSE260914%5FTTseq%5FdTAG%5F6H%5Fforward.bw
wget https://ftp.ncbi.nlm.nih.gov/geo/series/GSE260nnn/GSE260914/suppl/GSE260914%5FTTseq%5FdTAG%5F6H%5Freverse.bw
```
