# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq/cross_reactivity
BLACKLIST=/DATA/users/magnitov/znf143/genome/hg38-blacklist.v2.bed

mkdir -p ${INPUT_PATH}/peaks

for SAMPLE in Guertin_ZNF143_Proteintech_DMSO Guertin_ZNF143_Proteintech_DMSO_rep1 Guertin_ZNF143_Proteintech_DMSO_rep2 Guertin_ZNF143_Proteintech_DMSO_rep3 Guertin_ZNF143_Proteintech_DMSO_rep4 Guertin_ZNF143_Proteintech_dTAG_30min Guertin_ZNF143_Proteintech_dTAG_30min_rep1 Guertin_ZNF143_Proteintech_dTAG_30min_rep2 Guertin_ZNF143_Proteintech_dTAG_30min_rep3 Guertin_ZNF143_Proteintech_dTAG_30min_rep4 Dong_ZNF143_HA_DMSO Dong_ZNF143_HA_DMSO_rep1 Dong_ZNF143_HA_DMSO_rep2 Dong_ZNF143_HA_dTAG_30min Dong_ZNF143_HA_dTAG_30min_rep1 Dong_ZNF143_HA_dTAG_30min_rep2
do
	macs2 callpeak --name=${SAMPLE} -f BAMPE --gsize=hs --qvalue=0.01 --keep-dup all --nomodel \
		-t ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam \
		--outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs_${SAMPLE}.log
done

for SAMPLE in Guertin_ZNF143_Proteintech_DMSO Guertin_ZNF143_Proteintech_DMSO_rep1 Guertin_ZNF143_Proteintech_DMSO_rep2 Guertin_ZNF143_Proteintech_DMSO_rep3 Guertin_ZNF143_Proteintech_DMSO_rep4 Guertin_ZNF143_Proteintech_dTAG_30min Guertin_ZNF143_Proteintech_dTAG_30min_rep1 Guertin_ZNF143_Proteintech_dTAG_30min_rep2 Guertin_ZNF143_Proteintech_dTAG_30min_rep3 Guertin_ZNF143_Proteintech_dTAG_30min_rep4 Dong_ZNF143_HA_DMSO Dong_ZNF143_HA_DMSO_rep1 Dong_ZNF143_HA_DMSO_rep2 Dong_ZNF143_HA_dTAG_30min Dong_ZNF143_HA_dTAG_30min_rep1 Dong_ZNF143_HA_dTAG_30min_rep2
do
	grep -v -e '^GL' -e '^JH' -e '^KI' -e 'chrM' -e 'chrY' ${INPUT_PATH}/peaks/${SAMPLE}_peaks.narrowPeak |\
		sort -k1,1 -k2,2n | bedtools intersect -v -a stdin -b ${BLACKLIST} | sort -k1,1 -k2,2n > ${INPUT_PATH}/peaks/${SAMPLE}_peaks.bed
done
