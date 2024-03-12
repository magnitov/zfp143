# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq/public_data

###
### Make sets of K562 ZNF143 peaks
###
bedtools intersect -a ./peaks/ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQS.bed -b ./peaks/ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQT.bed > ./k562_data/K562_ENCODE_antiZNF143_reproducible_peaks.bed
bedtools intersect -a ./peaks/ENCODE_K562_ZNF143_ChIPseq_ENCLB658FFM.bed -b ./peaks/ENCODE_K562_ZNF143_ChIPseq_ENCLB046RFO.bed > ./k562_data/K562_ENCODE_antiFLAG_reproducible_peaks.bed

cat ./k562_data/K562_ENCODE_antiZNF143_reproducible_peaks.bed ./k562_data/K562_ENCODE_antiFLAG_reproducible_peaks.bed | sort -k1,1 -k2,2n > ./k562_data/K562_ENCODE_ZNF143_all_reproducible_peaks.bed
bedtools merge -i ./k562_data/K562_ENCODE_ZNF143_all_reproducible_peaks.bed > ./k562_data/tmp.bed
mv ./k562_data/tmp.bed ./k562_data/K562_ENCODE_ZNF143_all_reproducible_peaks.bed

cd ./k562_data
bedtools intersect -v -a K562_ENCODE_ZNF143_all_reproducible_peaks.bed -b K562_ENCODE_antiFLAG_reproducible_peaks.bed -wa | sort -k1,1 -k2,2n | uniq | bedtools intersect -a stdin -b K562_ENCODE_antiZNF143_reproducible_peaks.bed -wa | sort -k1,1 -k2,2n | uniq > peaks_proteintech.bed
bedtools intersect -a K562_ENCODE_ZNF143_all_reproducible_peaks.bed -b K562_ENCODE_antiFLAG_reproducible_peaks.bed -wa | sort -k1,1 -k2,2n | uniq | bedtools intersect -v -a stdin -b K562_ENCODE_antiZNF143_reproducible_peaks.bed -wa | sort -k1,1 -k2,2n | uniq > peaks_flag.bed
bedtools intersect -a K562_ENCODE_ZNF143_all_reproducible_peaks.bed -b K562_ENCODE_antiFLAG_reproducible_peaks.bed -wa | sort -k1,1 -k2,2n | uniq | bedtools intersect -a stdin -b K562_ENCODE_antiZNF143_reproducible_peaks.bed -wa | sort -k1,1 -k2,2n | uniq > peaks_common.bed
rm K562_ENCODE_ZNF143_all_reproducible_peaks.bed

###
### Pile-up of ZNF143 and CTCF ChIP-seq over the common and Proteintech-specific peaks
###
computeMatrix reference-point -p 32 --referencePoint center -a 1000 -b 1000 --missingDataAsZero --skipZeros \
	-S ${INPUT_PATH}/bigwig/ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQS.hg38.input.bw ${INPUT_PATH}/bigwig/ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQT.hg38.input.bw ${INPUT_PATH}/bigwig/ENCODE_K562_ZNF143_ChIPseq_ENCLB046RFO.hg38.input.bw ${INPUT_PATH}/bigwig/ENCODE_K562_ZNF143_ChIPseq_ENCLB658FFM.hg38.input.bw ${INPUT_PATH}/bigwig/Ngondo-Mbongo_K562_ZNF143_ChIPseq.hg38.rpgc.bw ${INPUT_PATH}/bigwig/K562_CTCF_Broad.hg38.input.bw \
	-R ${INPUT_PATH}/k562_data/peaks_common.bed ${INPUT_PATH}/k562_data/peaks_proteintech.bed \
	-o ${INPUT_PATH}/k562_data/k562_znf143_ctcf_in_grouped_znf143_peaks.gz

plotHeatmap -m ${INPUT_PATH}/k562_data/k562_znf143_ctcf_in_grouped_znf143_peaks.gz -out ${INPUT_PATH}/k562_data/k562_znf143_ctcf_in_grouped_znf143_peaks.pdf \
	--yMin 0 --yMax 45 45 25 25 250 25 --zMin 0 --zMax 45 45 25 25 250 25 --xAxisLabel "" \
	--samplesLabel Proteintech Proteintech FLAG FLAG Custom CTCF_Broad \
	--regionsLabel "Common (N=2621)" "Proteintech specific (N=25673)" --refPointLabel ""  --sortUsingSamples 1 2 \
	--colorMap RdPu RdPu BuGn BuGn OrRd Blues --heatmapHeight 12 --heatmapWidth 3
