# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq/public_data

mkdir -p ${INPUT_PATH}/bigwig/

###
### Human datasets
###
bamCompare -p 16 -bs 50 --operation ratio -o ${INPUT_PATH}/bigwig/ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQS.hg38.input.bw \
	-b1 ${INPUT_PATH}/bam/ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQS.hg38.mapq.proper.sorted.rmdup.bam \
	-b2 ${INPUT_PATH}/bam/ENCODE_K562_IgG_ENCLB603BJA.hg38.mapq.proper.sorted.rmdup.bam
bamCompare -p 16 -bs 50 --operation ratio -o ${INPUT_PATH}/bigwig/ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQT.hg38.input.bw \
	-b1 ${INPUT_PATH}/bam/ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQT.hg38.mapq.proper.sorted.rmdup.bam \
	-b2 ${INPUT_PATH}/bam/ENCODE_K562_IgG_ENCLB603BJA.hg38.mapq.proper.sorted.rmdup.bam
bamCompare -p 16 -bs 50 --operation ratio -o ${INPUT_PATH}/bigwig/ENCODE_K562_ZNF143_ChIPseq_ENCLB658FFM.hg38.input.bw \
	-b1 ${INPUT_PATH}/bam/ENCODE_K562_ZNF143_ChIPseq_ENCLB658FFM.hg38.mapq.proper.sorted.rmdup.bam \
	-b2 ${INPUT_PATH}/bam/ENCODE_K562_Input_ENCLB271UTF.hg38.mapq.proper.sorted.rmdup.bam
bamCompare -p 16 -bs 50 --operation ratio -o ${INPUT_PATH}/bigwig/ENCODE_K562_ZNF143_ChIPseq_ENCLB046RFO.hg38.input.bw \
	-b1 ${INPUT_PATH}/bam/ENCODE_K562_ZNF143_ChIPseq_ENCLB046RFO.hg38.mapq.proper.sorted.rmdup.bam \
	-b2 ${INPUT_PATH}/bam/ENCODE_K562_Input_ENCLB271UTF.hg38.mapq.proper.sorted.rmdup.bam
bamCoverage -p 16 -bs 50 --effectiveGenomeSize 2913022398 --normalizeUsing RPGC \
	-b ${INPUT_PATH}/bam/Ngondo-Mbongo_K562_ZNF143_ChIPseq.hg38.mapq.proper.sorted.rmdup.bam -o ${INPUT_PATH}/bigwig/Ngondo-Mbongo_K562_ZNF143_ChIPseq.hg38.rpgc.bw
bamCompare -p 16 -bs 50 --operation ratio -o ${INPUT_PATH}/bigwig/K562_CTCF_Broad.hg38.input.bw \
	-b1 ${INPUT_PATH}/bam/K562_CTCF_Broad.hg38.mapq.proper.sorted.rmdup.bam -b2 ${INPUT_PATH}/bam/K562_Input_Broad.hg38.mapq.proper.sorted.rmdup.bam

###
### Mouse datasets
###
bamCompare -p 16 -bs 50 --operation ratio -o ${INPUT_PATH}/bigwig/HSPC_Ochi_CTCF_ChIPseq.mm10.input.bw \
	-b1 ${INPUT_PATH}/bam/HSPC_Ochi_CTCF_ChIPseq.mm10.mapq.proper.sorted.rmdup.bam \
	-b2 ${INPUT_PATH}/bam/HSPC_Ochi_Input.mm10.mapq.proper.sorted.rmdup.bam

bamCompare -p 16 -bs 50 --operation ratio -o ${INPUT_PATH}/bigwig/HSPC_Viny_CTCF_ChIPseq.mm10.input.bw \
	-b1 ${INPUT_PATH}/bam/HSPC_Viny_CTCF_ChIPseq.mm10.mapq.proper.sorted.rmdup.bam \
	-b2 ${INPUT_PATH}/bam/HSPC_Viny_Input.mm10.mapq.proper.sorted.rmdup.bam
