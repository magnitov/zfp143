# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq/public_data

bedtools intersect -a ${INPUT_PATH}/zhang_data/GSM7566828_AID-WT_ChIP-nexus_ZNF143_peaks.bed \
	-b ${INPUT_PATH}/zhang_data/GSM7566830_AID-WT_ChIP-nexus_CTCF_peaks.bed -wa >\
	${INPUT_PATH}/zhang_data/peaks_ZNF143_CTCF_common.bed
bedtools intersect -v -a ${INPUT_PATH}/zhang_data/GSM7566828_AID-WT_ChIP-nexus_ZNF143_peaks.bed \
	-b ${INPUT_PATH}/zhang_data/GSM7566830_AID-WT_ChIP-nexus_CTCF_peaks.bed -wa >\
	${INPUT_PATH}/zhang_data/peaks_ZNF143_only.bed

###
### Pile-up of ZNF143 and CTCF ChIP-seq over common and ZNF143/CTCF-specific peaks
###
computeMatrix reference-point -p 32 --referencePoint center -a 1000 -b 1000 --missingDataAsZero --skipZeros \
	-S ${INPUT_PATH}/zhang_data/GSM7566828_AID-WT_ChIP-nexus_ZNF143.bw ${INPUT_PATH}/zhang_data/GSM7566829_AID-CTCFd_ChIP-nexus_ZNF143.bw ${INPUT_PATH}/zhang_data/GSM7566830_AID-WT_ChIP-nexus_CTCF.bw ${INPUT_PATH}/zhang_data/GSM7566831_AID-CTCFd_ChIP-nexus_CTCF.bw \
	-R ${INPUT_PATH}/zhang_data/peaks_ZNF143_only.bed ${INPUT_PATH}/zhang_data/peaks_ZNF143_CTCF_common.bed -o ${INPUT_PATH}/zhang_data/zhang_in_znf143_peaks.gz

plotHeatmap -m ${INPUT_PATH}/zhang_data/zhang_in_znf143_peaks.gz -out ${INPUT_PATH}/zhang_data/zhang_in_znf143_peaks.pdf \
	--yMin 0 --yMax 150 150 --zMin 0 --zMax 150 150 --xAxisLabel "" \
	--samplesLabel ZNF143_WT ZNF143_AID \
	--regionsLabel "ZNF143-only (N=15377)" "Common (N=19745)" --refPointLabel "" \
	--colorMap Reds Reds --heatmapHeight 12 --heatmapWidth 3