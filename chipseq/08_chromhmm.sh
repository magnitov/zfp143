# !/bin/bash

for STATE in 1_Insulator 2_Intergenic 3_Heterochromatin 4_Enhancer 5_RepressedChromatin 6_BivalentChromatin 7_ActivePromoter 8_StrongEnhancer 9_TranscriptionTransition 10_TranscriptionElongation 11_WeakEnhancer 12_LowSignal/RepetitiveElements
do
	bedtools intersect -a /DATA/users/magnitov/znf143/chipseq/peaks/ZFP143_peaks.bed -b /DATA/users/magnitov/znf143/genome/mm10.mESC_E14_chromHMM.bed -wao |\
	       	cut -f 14,15 | grep ${STATE} | awk -v st=$STATE '{SUM+=$2}END{print st"\t"SUM }'
done

