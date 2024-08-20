# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq/cross_reactivity
BLACKLIST=/DATA/users/magnitov/znf143/genome/hg38-blacklist.v2.bed

mkdir -p ${INPUT_PATH}/piles    

computeMatrix reference-point -p 32 -bl ${BLACKLIST} --referencePoint center -a 1000 -b 1000 --missingDataAsZero --skipZeros \
	-S ${INPUT_PATH}/bigwig/Guertin_CTCF_DMSO.rpgc.bw ${INPUT_PATH}/bigwig/Guertin_CTCF_dTAG_30min.rpgc.bw ${INPUT_PATH}/bigwig/Guertin_ZNF143_Proteintech_DMSO.rpgc.bw ${INPUT_PATH}/bigwig/Guertin_ZNF143_Proteintech_dTAG_30min.rpgc.bw ${INPUT_PATH}/bigwig/Dong_ZNF143_HA_DMSO.rpgc.bw ${INPUT_PATH}/bigwig/Dong_ZNF143_HA_dTAG_30min.rpgc.bw ${INPUT_PATH}/bigwig/Ngondo-Mbongo_HEK293_ZNF143_ChIPseq.hg38.rpgc.bw \
	-R ${INPUT_PATH}/peaks/peaks_common.bed ${INPUT_PATH}/peaks/peaks_proteintech.bed -o ${INPUT_PATH}/piles/signals_in_common_and_proteintech_peaks.gz

plotHeatmap -m ${INPUT_PATH}/piles/signals_in_common_and_proteintech_peaks.gz -out ${INPUT_PATH}/piles/signals_in_common_and_proteintech_peaks.pdf \
	--zMin 0 --zMax 45 45 25 25 40 40 20 --yMin 0 --yMax 90 90 280 280 450 450 40 --xAxisLabel "" --legendLocation none \
	--refPointLabel "" --regionsLabel "Common (N=5832)" "Proteintech-specific (N=34776)" \
	--samplesLabel CTCF_DMSO CTCF_dTAG PT_DMSO PT_dTAG HA_DMSO HA_dTAG N-M_custom \
	--colorMap Blues Blues RdPu RdPu BuGn BuGn Oranges --heatmapHeight 12 --heatmapWidth 3 --sortUsingSamples 3 4
