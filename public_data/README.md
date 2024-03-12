## Public ChIP-seq data re-analysis

Here we attempt to give an extensive overview of the publicly available data re-analysis we performed. This folder contains scripts associated with the following analyses from the manuscript:
* Processing of publicly available ZNF143/ZFP143 datasets
* Overlap analysis between ZNF143/ZFP143 peaks and CTCF peaks from CISTROME database
* Antibody cross-reactivity analysis in K562 cell line
* Enrichment analysis at chromatin loop anchors ([Rao et al.](https://pubmed.ncbi.nlm.nih.gov/25497547/))
* CTCF and ZNF143 binding interdependency ([Zhou et al.](https://pubmed.ncbi.nlm.nih.gov/33397967/) and [Zhang et al.](https://pubmed.ncbi.nlm.nih.gov/38206813/))
* ZNF143-CTCF motif pairs located 37 bp apart ([Zhou et al.](https://pubmed.ncbi.nlm.nih.gov/33397967/))
* Conserved human and mouse ZNF143/ZFP143-bound genes

Unfortunately, the bigwig files produced during the ChIP-seq re-analysis are too large and cannot be uploaded here. Therefore, if you would like to repeat the antibody cross-reactivity analysis in K562 or browse the data yourself, we suggest you use ChIP-seq signals of the same datasets from other sources: Proteintech antibody ([ENCLB209AQS](https://www.encodeproject.org/files/ENCFF576BIF/@@download/ENCFF576BIF.bigWig) and [ENCLB209AQT](https://www.encodeproject.org/files/ENCFF543ZZV/@@download/ENCFF543ZZV.bigWig) datasets), FLAG antibody ([ENCLB658FFM](https://www.encodeproject.org/files/ENCFF581UUL/@@download/ENCFF581UUL.bigWig) and [ENCLB046RFO](https://www.encodeproject.org/files/ENCFF046EEC/@@download/ENCFF046EEC.bigWig) datasets), custom-made antibody ([Ngondo-Mbondo et al. dataset](http://dc2.cistrome.org/genome_browser/bw/36774_treat.bw)), CTCF ([Broad CTCF](https://www.encodeproject.org/files/ENCFF405AYC/@@download/ENCFF405AYC.bigWig) dataset).

To reproduce some steps of analysis, you may additionally need:
* GENCODE gene annotation of [human genes](https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.annotation.gtf.gz)
* GENCODE gene annotation of [mouse genes](https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M25/gencode.vM25.annotation.gtf.gz)
* Locally downloaded CTCF peaks from [CISTROME](http://cistrome.org/db/#/)

