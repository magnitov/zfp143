# !/bin/bash
DATA_PATH=/DATA/users/magnitov/znf143/hic
ZFP143_PEAKS=/DATA/users/magnitov/znf143/chipseq/peaks/ZFP143_peaks.bed

for LOOP_SET in bonev_2017_hic_loops hsieh_2022_cohesin_loops hsieh_2022_EP_loops hsieh_2022_PP_loops
do
	awk '{ print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6 }' ${DATA_PATH}/annotations/${LOOP_SET}.bedpe | \
		bedtools intersect -a stdin -b ${ZFP143_PEAKS} > ${DATA_PATH}/annotations/${LOOP_SET}.overlap_zfp143.bedpe
	awk '{ print $4"\t"$5"\t"$6"\t"$1"\t"$2"\t"$3 }' ${DATA_PATH}/annotations/${LOOP_SET}.bedpe | \
		bedtools intersect -a stdin -b ${ZFP143_PEAKS} | awk '{ print $4"\t"$5"\t"$6"\t"$1"\t"$2"\t"$3 }' >> ${DATA_PATH}/annotations/${LOOP_SET}.overlap_zfp143.bedpe
	sort -k1,1 -k2,2n ${DATA_PATH}/annotations/${LOOP_SET}.overlap_zfp143.bedpe | uniq > tmp.bed
	mv tmp.bed ${DATA_PATH}/annotations/${LOOP_SET}.overlap_zfp143.bedpe
done

