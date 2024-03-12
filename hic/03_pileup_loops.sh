DATA_PATH=/DATA/users/magnitov/znf143/hic

mkdir -p ${DATA_PATH}/piles_loops

#
# Loops
#
for EXP in ZFP143_DMSO ZFP143_dTAG_6h
do
	for LOOP_SET in bonev_2017_hic_loops hsieh_2022_cohesin_loops hsieh_2022_EP_loops hsieh_2022_PP_loops
	do
		coolpup.py ${DATA_PATH}/coolers/${EXP}.mm10.mapq_30.5000.mcool::resolutions/5000 ${DATA_PATH}/annotations/${LOOP_SET}.bedpe \
			--expected ${DATA_PATH}/expected/${EXP}_oe_cis_5K.tsv --pad 200 --mindist 0 --n_proc 16 \
			--outdir ${DATA_PATH}/piles_loops --outname ${EXP}_${LOOP_SET}.txt
	done
done

#
# Loops overlapping ZFP143 peaks
#
for EXP in ZFP143_DMSO ZFP143_dTAG_6h
do
	for LOOP_SET in bonev_2017_hic_loops hsieh_2022_cohesin_loops hsieh_2022_EP_loops hsieh_2022_PP_loops
	do
		coolpup.py ${DATA_PATH}/coolers/${EXP}.mm10.mapq_30.5000.mcool::resolutions/5000 ${DATA_PATH}/annotations/${LOOP_SET}.overlap_zfp143.bedpe \
			--expected ${DATA_PATH}/expected/${EXP}_oe_cis_5K.tsv --pad 200 --mindist 0 --n_proc 16 \
			--outdir ${DATA_PATH}/piles_loops --outname ${EXP}_${LOOP_SET}.overlap_zfp143.txt
	done
done
