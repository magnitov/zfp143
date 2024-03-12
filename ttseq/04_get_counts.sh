# !/bin/bash
INPUT_DIR=/DATA/users/magnitov/znf143/ttseq
GENE_ANNOTAION=/DATA/users/magnitov/znf143/genome/gencode.vM25.annotation.gtf

mkdir -p ${INPUT_DIR}/counts
cd ${INPUT_DIR}/bam/

# without -r pos mates are missing
# without -t gene only exons are scored 
# without --nonunique all small genes inside large genes get 0 counts (like Sox2 inside Sox2ot).

# counts for genes
htseq-count -f bam --stranded no --nonunique all --order pos --type gene \
	ZFP143_DMSO_rep1_forward.bam ZFP143_DMSO_rep2_forward.bam ZFP143_2H_rep1_forward.bam ZFP143_2H_rep2_forward.bam \
	ZFP143_6H_rep1_forward.bam ZFP143_6H_rep2_forward.bam ZFP143_24H_rep1_forward.bam ZFP143_24H_rep2_forward.bam \
	${GENE_ANNOTAION} > ${INPUT_DIR}/counts/counts_forward.ZFP143_TTseq.txt
htseq-count -f bam --stranded no --nonunique all --order pos --type gene \
	ZFP143_DMSO_rep1_reverse.bam ZFP143_DMSO_rep2_reverse.bam ZFP143_2H_rep1_reverse.bam ZFP143_2H_rep2_reverse.bam \
	ZFP143_6H_rep1_reverse.bam ZFP143_6H_rep2_reverse.bam ZFP143_24H_rep1_reverse.bam ZFP143_24H_rep2_reverse.bam \
	${GENE_ANNOTAION} > ${INPUT_DIR}/counts/counts_reverse.ZFP143_TTseq.txt

# counts for transcripts
htseq-count -f bam --stranded no --nonunique all --order pos --type transcript --idattr transcript_id \
        ZFP143_DMSO_rep1_forward.bam ZFP143_DMSO_rep2_forward.bam ZFP143_2H_rep1_forward.bam ZFP143_2H_rep2_forward.bam \
        ZFP143_6H_rep1_forward.bam ZFP143_6H_rep2_forward.bam ZFP143_24H_rep1_forward.bam ZFP143_24H_rep2_forward.bam \
        ${GENE_ANNOTAION} > ${INPUT_DIR}/counts/counts_transcripts_forward.ZFP143_TTseq.txt
htseq-count -f bam --stranded no --nonunique all --order pos --type transcript --idattr transcript_id \
        ZFP143_DMSO_rep1_reverse.bam ZFP143_DMSO_rep2_reverse.bam ZFP143_2H_rep1_reverse.bam ZFP143_2H_rep2_reverse.bam \
        ZFP143_6H_rep1_reverse.bam ZFP143_6H_rep2_reverse.bam ZFP143_24H_rep1_reverse.bam ZFP143_24H_rep2_reverse.bam \
        ${GENE_ANNOTAION} > ${INPUT_DIR}/counts/counts_transcripts_reverse.ZFP143_TTseq.txt