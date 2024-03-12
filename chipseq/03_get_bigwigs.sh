# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq

mkdir -p ${INPUT_PATH}/bigwig

###
### ZFP143-HA ChIP-seq profiles
###
for SAMPLE in ZFP143_DMSO ZFP143_2H Input_ZFP143_DMSO Input_CTCF_DMSO
do
	bamCoverage -p 16 -bs 50 --effectiveGenomeSize 2652783500 --normalizeUsing RPGC \
		-b ${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.rmdup.bam -o ${INPUT_PATH}/bigwig/${SAMPLE}.rpgc.bw
done

###
### CTCF spike-in ChIP-seq profiles
###
REL_SCALEFACTOR_DMSO=0.8280984955548882
REL_SCALEFACTOR_6H=1

bamCoverage -p 16 -bs 50 --scaleFactor ${REL_SCALEFACTOR_DMSO} \
	-b ${INPUT_PATH}/bam/CTCF_DMSO.mm10.mapq.proper.sorted.rmdup.bam -o ${INPUT_PATH}/bigwig/CTCF_DMSO.spiked.bw
bamCoverage -p 16 -bs 50 --scaleFactor ${REL_SCALEFACTOR_6H} \
	-b ${INPUT_PATH}/bam/CTCF_6H.mm10.mapq.proper.sorted.rmdup.bam -o ${INPUT_PATH}/bigwig/CTCF_6H.spiked.bw
