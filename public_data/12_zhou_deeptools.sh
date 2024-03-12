# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq/public_data/zhou_data
BLACKLIST=/DATA/users/magnitov/znf143/genome/mm10-blacklist.v2.bed

###
### CTCF ChIP-seq signals for two biological replicates from Zhou et al. and two other
### datasets (PMID: 31495782, 32249213) within ZNF143-related and ZNF143-unrelated regions
###
computeMatrix reference-point -p 32 -bl ${BLACKLIST} --referencePoint center -a 1000 -b 1000 --missingDataAsZero --skipZeros \
	-S ${INPUT_PATH}/GSM4294197_WT-CTCF-ckit_mm10.bowtie2.rd.bw ${INPUT_PATH}/GSM4403033_WT-CTCF-ckit_2_mm10.bowtie2.rd.bw ${INPUT_PATH}/GSM4294198_KO-CTCF-ckit_mm10.bowtie2.rd.bw ${INPUT_PATH}/GSM4403034_KO-CTCF-ckit_2_mm10.bowtie2.rd.bw /DATA/users/magnitov/znf143/chipseq/public_data/bigwig/HSPC_Viny_CTCF_ChIPseq.mm10.input.bw /DATA/users/magnitov/znf143/chipseq/public_data/bigwig/HSPC_Ochi_CTCF_ChIPseq.mm10.input.bw \
	-R ${INPUT_PATH}/Zhou_CTCF_peaks_ZNF143_related.bed ${INPUT_PATH}/Zhou_CTCF_peaks_ZNF143_unrelated.bed -o ${INPUT_PATH}/zhou_peaks_replicates_and_public.gz

plotHeatmap -m ${INPUT_PATH}/zhou_peaks_replicates_and_public.gz -out ${INPUT_PATH}/zhou_peaks_replicates_and_public.pdf \
	--zMin 0 --zMax 46 46 46 46 50 125 --yMin 0 --yMax 46 46 46 46 50 125 --xAxisLabel "" \
	--samplesLabel WT_CTCF_rep1 WT_CTCF_rep2 KO_CTCF_rep1 KO_CTCF_rep2 HSPC_Viny HSPC_Ochi \
	--regionsLabel "ZNF143 related (N=27801)" "ZNF143 unrelated (N=4196)" --refPointLabel "" \
	--colorMap Blues Blues Blues Blues Blues Blues --heatmapHeight 12 --heatmapWidth 3 \
	--sortUsingSamples 1 --outFileSortedRegions ${INPUT_PATH}/Zhou_CTCF_peaks_both.sorted_deeptools.txt

###
### Binding at the reported ZNF143-CTCF motif pairs located 37 bp apart
###
computeMatrix reference-point -p 32 --bl ${BLACKLIST} --referencePoint center -a 1000 -b 1000 --missingDataAsZero --skipZeros \
	-S ${INPUT_PATH}/GSM4294197_WT-CTCF-ckit_mm10.bowtie2.rd.bw ${INPUT_PATH}/GSM4403033_WT-CTCF-ckit_2_mm10.bowtie2.rd.bw ${INPUT_PATH}/GSM4294199_WT-ZNF143-ckit_mm10.bowtie2.rd.bw ${INPUT_PATH}/GSM4403035_WT-ZNF143-ckit_2_mm10.bowtie2.rd.bw \
	-R ${INPUT_PATH}/ZNF143_CTCF_motif_37bp_positions.bed -o ${INPUT_PATH}/motifs_replicates.gz

plotHeatmap -m ${INPUT_PATH}/motifs_replicates.gz -out ${INPUT_PATH}/motifs_replicates.pdf \
	--colorMap coolwarm --zMin 0 --zMax 46 46 6 6 --yMin 0 --yMax 46 46 6 6 --xAxisLabel "" --legendLocation none \
	--samplesLabel WT_CTCF_rep1 WT_CTCF_rep2 WT_ZFP143_rep1 WT_ZFP143_rep2 \
	--regionsLabel "CTCF-ZNF143 motifs located 37 bp apart (Zhou et al., N=10544)" --refPointLabel "" \
	--colorMap Blues Blues Reds Reds --heatmapHeight 12 --heatmapWidth 3
