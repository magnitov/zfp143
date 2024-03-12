# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq
BLACKLIST=/DATA/users/magnitov/znf143/genome/mm10-blacklist.v2.bed

mkdir -p ${INPUT_PATH}/piles

###
### CTCF peaks
###
computeMatrix reference-point -p 32 -bl ${BLACKLIST} --referencePoint center -a 1000 -b 1000 --missingDataAsZero --skipZeros \
	-S ${INPUT_PATH}/bigwig/CTCF_DMSO.spiked.bw ${INPUT_PATH}/bigwig/CTCF_6H.spiked.bw ${INPUT_PATH}/bigwig/ZFP143_DMSO.rpgc.bw ${INPUT_PATH}/bigwig/ZFP143_2H.rpgc.bw \
	-R ${INPUT_PATH}/peaks/CTCF_DMSO_peaks.deeptools_sorted.bed -o ${INPUT_PATH}/piles/both_signal_in_CTCF_peaks.gz \
	--sortRegions keep

plotHeatmap -m ${INPUT_PATH}/piles/both_signal_in_CTCF_peaks.gz -out ${INPUT_PATH}/piles/both_signal_in_CTCF_peaks.pdf \
	--zMin 0 --zMax 12 12 200 200 --yMin 0 --yMax 12 12 200 200 --xAxisLabel "" --legendLocation none \
	--regionsLabel "CTCF peaks (N=22314)" --refPointLabel "" \
	--samplesLabel CTCF_DMSO CTCF_6H ZFP143_DMSO ZFP143_2H --colorMap Blues Blues Reds Reds --heatmapHeight 12 --heatmapWidth 3 --sortRegions no

###
### ZFP143 peaks
###
computeMatrix reference-point -p 32 -bl ${BLACKLIST} --referencePoint center -a 1000 -b 1000 --missingDataAsZero --skipZeros \
	-S ${INPUT_PATH}/bigwig/CTCF_DMSO.spiked.bw ${INPUT_PATH}/bigwig/CTCF_6H.spiked.bw ${INPUT_PATH}/bigwig/ZFP143_DMSO.rpgc.bw ${INPUT_PATH}/bigwig/ZFP143_2H.rpgc.bw \
	-R ${INPUT_PATH}/peaks/ZFP143_peaks.deeptools_sorted.bed -o ${INPUT_PATH}/piles/both_signal_in_ZFP143_peaks.gz \
	--sortRegions keep

plotHeatmap -m ${INPUT_PATH}/piles/both_signal_in_ZFP143_peaks.gz -out ${INPUT_PATH}/piles/both_signal_in_ZFP143_peaks.pdf \
	--zMin 0 --zMax 12 12 200 200 --yMin 0 --yMax 12 12 200 200 --xAxisLabel "" --legendLocation none \
	--regionsLabel "ZFP143-HA peaks (N=3189)" --refPointLabel "" \
	--samplesLabel CTCF_DMSO CTCF_6H ZFP143_DMSO ZFP143_2H --colorMap Blues Blues Reds Reds --heatmapHeight 12 --heatmapWidth 3 --sortRegions no

###
### Comparison with J1 mESC ZFP143 ChIP-seq from Ngondo-Mbongo et al. (PMID: 23408857)
###
computeMatrix reference-point -p 32 -bl ${BLACKLIST} --referencePoint center -a 1000 -b 1000 --missingDataAsZero --skipZeros \
       -S ${INPUT_PATH}/bigwig/ZFP143_DMSO.rpgc.bw ${INPUT_PATH}/public_data/bigwig/Ngondo-Mbongo_mESC_Zfp143_ChIPseq.mm10.rpgc.bw \
       -R ${INPUT_PATH}/peaks/compare_ZFP143_overlap.bed ${INPUT_PATH}/peaks/compare_ZFP143_unique_ChIP.bed ${INPUT_PATH}/peaks/compare_ZFP143_unique_HA.bed \
       -o ${INPUT_PATH}/piles/comparison_ZFP143_peaks.gz

plotHeatmap -m ${INPUT_PATH}/piles/comparison_ZFP143_peaks.gz -out ${INPUT_PATH}/piles/comparison_ZFP143_peaks.pdf \
       --zMin 0 --zMax 200 --yMin 0 --yMax 200 --xAxisLabel "" \
       --regionsLabel "Common (N=2710)" "J1 (N=4399)" "E14 (N=479)" --refPointLabel "" \
       --samplesLabel ZFP143_HA_E14 ZFP143_ChIP_J1 --colorMap Reds Reds --heatmapHeight 12 --heatmapWidth 3 
       #--sortRegions no
       
