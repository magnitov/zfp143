## ChIP-seq data analysis

To reproduce some parts of the analysis, you need to download bigwig files for ChIP-seq deposited in GEO.
```
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8127nnn/GSM8127953/suppl/GSM8127953%5FZFP143%5FDMSO.rpgc.bw
wget ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8127nnn/GSM8127954/suppl/GSM8127954%5FZFP143%5FdTAG%5F2H.rpgc.bw
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8127nnn/GSM8127951/suppl/GSM8127951%5FCTCF%5FDMSO.calibrated.bw
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8127nnn/GSM8127952/suppl/GSM8127952%5FCTCF%5FdTAG%5F6H.calibrated.bw
```

You may additionally need:
* Blacklist regions for mm10: https://github.com/Boyle-Lab/Blacklist
* Chromatin states annotation for mESCs: https://github.com/guifengwei/ChromHMM_mESC_mm10
* ZFP143 ChIP-seq signal in J1 mESCs: http://dc2.cistrome.org/genome_browser/bw/36769_treat.bw 
* GENCODE gene annotation: https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M25/gencode.vM25.annotation.gtf.gz
