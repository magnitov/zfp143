# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq/cross_reactivity

cd ${INPUT_PATH}/peaks

cat Guertin_ZNF143_Proteintech_DMSO_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Guertin_ZNF143_Proteintech_DMSO_rep1_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep1.bed
cat Guertin_ZNF143_Proteintech_DMSO_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Guertin_ZNF143_Proteintech_DMSO_rep2_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep2.bed              
cat Guertin_ZNF143_Proteintech_DMSO_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Guertin_ZNF143_Proteintech_DMSO_rep3_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep3.bed
cat Guertin_ZNF143_Proteintech_DMSO_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Guertin_ZNF143_Proteintech_DMSO_rep4_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep4.bed
cat overlap_rep1.bed overlap_rep2.bed overlap_rep3.bed overlap_rep4.bed | sort -k1,1 -k2,2n | uniq -c | awk '{ if ($1>=4) print $2"\t"$3"\t"$4 }' > Guertin_ZNF143_Proteintech_DMSO_peaks.replicated.bed
rm overlap_rep1.bed overlap_rep2.bed overlap_rep3.bed overlap_rep4.bed

cat Guertin_ZNF143_Proteintech_dTAG_30min_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Guertin_ZNF143_Proteintech_dTAG_30min_rep1_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep1.bed
cat Guertin_ZNF143_Proteintech_dTAG_30min_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Guertin_ZNF143_Proteintech_dTAG_30min_rep2_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep2.bed              
cat Guertin_ZNF143_Proteintech_dTAG_30min_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Guertin_ZNF143_Proteintech_dTAG_30min_rep3_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep3.bed
cat Guertin_ZNF143_Proteintech_dTAG_30min_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Guertin_ZNF143_Proteintech_dTAG_30min_rep4_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep4.bed
cat overlap_rep1.bed overlap_rep2.bed overlap_rep3.bed overlap_rep4.bed | sort -k1,1 -k2,2n | uniq -c | awk '{ if ($1>=1) print $2"\t"$3"\t"$4 }' > Guertin_ZNF143_Proteintech_dTAG_30min_peaks.replicated.bed
rm overlap_rep1.bed overlap_rep2.bed overlap_rep3.bed overlap_rep4.bed

cat Dong_ZNF143_HA_DMSO_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Dong_ZNF143_HA_DMSO_rep1_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep1.bed
cat Dong_ZNF143_HA_DMSO_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Dong_ZNF143_HA_DMSO_rep2_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep2.bed 
cat overlap_rep1.bed overlap_rep2.bed | sort -k1,1 -k2,2n | uniq -c | awk '{ if ($1>=2) print $2"\t"$3"\t"$4 }' > Dong_ZNF143_HA_DMSO_peaks.replicated.bed
rm overlap_rep1.bed overlap_rep2.bed

cat Dong_ZNF143_HA_dTAG_30min_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Dong_ZNF143_HA_dTAG_30min_rep1_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep1.bed
cat Dong_ZNF143_HA_dTAG_30min_peaks.bed | awk '{ if ($7>0) print $0 }' | bedtools intersect -wo -a stdin -b Dong_ZNF143_HA_dTAG_30min_rep2_peaks.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep2.bed 
cat overlap_rep1.bed overlap_rep2.bed | sort -k1,1 -k2,2n | uniq -c | awk '{ if ($1>=2) print $2"\t"$3"\t"$4 }' > Dong_ZNF143_HA_dTAG_30min_peaks.replicated.bed
rm overlap_rep1.bed overlap_rep2.bed

cat Guertin_ZNF143_Proteintech_DMSO_peaks.bed Guertin_ZNF143_Proteintech_dTAG_30min_peaks.bed | sort -k1,1 -k2,2n > all_proteintech_peaks_merged.tmp
bedtools merge -i all_proteintech_peaks_merged.tmp > all_proteintech_peaks_merged.bed
rm all_proteintech_peaks_merged.tmp

cat Dong_ZNF143_HA_DMSO_peaks.replicated.bed Dong_ZNF143_HA_dTAG_30min_peaks.replicated.bed | sort -k1,1 -k2,2n > all_ha_peaks_merged.tmp
bedtools merge -i all_ha_peaks_merged.tmp > all_ha_peaks_merged.bed
rm all_ha_peaks_merged.tmp

cat all_proteintech_peaks_merged.bed all_ha_peaks_merged.bed | sort -k1,1 -k2,2n > all_proteintech_and_ha_peaks.tmp
bedtools merge -i all_proteintech_and_ha_peaks.tmp > all_proteintech_and_ha_peaks_merged.bed
rm all_proteintech_and_ha_peaks.tmp

bedtools intersect -v -a all_proteintech_and_ha_peaks_merged.bed -b all_ha_peaks_merged.bed -wa | sort -k1,1 -k2,2n | uniq | bedtools intersect -a stdin -b all_proteintech_peaks_merged.bed -wa | sort -k1,1 -k2,2n | uniq > peaks_proteintech.bed
bedtools intersect -a all_proteintech_and_ha_peaks_merged.bed -b all_ha_peaks_merged.bed -wa | sort -k1,1 -k2,2n | uniq | bedtools intersect -v -a stdin -b all_proteintech_peaks_merged.bed -wa | sort -k1,1 -k2,2n | uniq > peaks_ha.bed
bedtools intersect -a all_proteintech_and_ha_peaks_merged.bed -b all_ha_peaks_merged.bed -wa | sort -k1,1 -k2,2n | uniq | bedtools intersect -a stdin -b all_proteintech_peaks_merged.bed -wa | sort -k1,1 -k2,2n | uniq > peaks_common.bed
