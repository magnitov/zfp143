# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq/public_data/

mkdir -p ${INPUT_PATH}/peaks

###
### Human datasets: single-end without input
###
for SAMPLE in Zhang_HEC1B_ZNF143_ChIPnexus Zhang_HEC1B_AID_ZNF143_ChIPnexus Ngondo-Mbongo_HEK293_ZNF143_ChIPseq Ngondo-Mbongo_HeLa_ZNF143_ChIPseq_rep1 Ngondo-Mbongo_HeLa_ZNF143_ChIPseq_rep2 Ngondo-Mbongo_HPB_ALL_ZNF143_ChIPseq Ngondo-Mbongo_K562_ZNF143_ChIPseq Treloar_MCF7_ZNF143_ChIPseq_rep1 Treloar_MCF7_ZNF143_ChIPseq_rep2
do
	macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
		-t ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam \
		--name=${SAMPLE} --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_${SAMPLE}.log
done

###
### Human datasets: single-end with input
###
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/Cobo_Macrophages_ZNF143_ChIPseq_rep1.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/Cobo_Macrophages_Input_rep1.hg38.mapq.proper.sorted.rmdup.bam \
	--name=Cobo_Macrophages_ZNF143_ChIPseq_rep1 --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_Cobo_Macrophages_ZNF143_ChIPseq_rep1.log

macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/Cobo_Macrophages_ZNF143_ChIPseq_rep2.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/Cobo_Macrophages_Input_rep2.hg38.mapq.proper.sorted.rmdup.bam \
	--name=Cobo_Macrophages_ZNF143_ChIPseq_rep2 --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_Cobo_Macrophages_ZNF143_ChIPseq_rep2.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/Michaud_HeLa_ZNF143_ChIPseq.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/Michaud_HeLa_Input_lane1.hg38.mapq.proper.sorted.rmdup.bam ${INPUT_PATH}/bam/Michaud_HeLa_Input_lane2.hg38.mapq.proper.sorted.rmdup.bam ${INPUT_PATH}/bam/Michaud_HeLa_Input_lane3.hg38.mapq.proper.sorted.rmdup.bam \
	--name=Michaud_HeLa_ZNF143_ChIPseq --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_Michaud_HeLa_ZNF143_ChIPseq.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/Tao_BE2C_ZNF143_ChIPseq.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/Tao_BE2C_Input.hg38.mapq.proper.sorted.rmdup.bam \
	--name=Tao_BE2C_ZNF143_ChIPseq --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_Tao_BE2C_ZNF143_ChIPseq.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/Tenen_U937_ZNF143_ChIPexo.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/Tenen_U937_Input.hg38.mapq.proper.sorted.rmdup.bam \
	--name=Tenen_U937_ZNF143_ChIPexo --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_Tenen_U937_ZNF143_ChIPexo.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/Wang_CUTLL_ZNF143_ChIPseq.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/Wang_CUTLL_Input_rep1.hg38.mapq.proper.sorted.rmdup.bam ${INPUT_PATH}/bam/Wang_CUTLL_Input_rep2.hg38.mapq.proper.sorted.rmdup.bam \
	--name=Wang_CUTLL_ZNF143_ChIPseq --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_Wang_CUTLL_ZNF143_ChIPseq.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/Yan_LoVo_ZNF143_ChIPseq.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/Yan_LoVo_IgG.hg38.mapq.proper.sorted.rmdup.bam \
	--name=Yan_LoVo_ZNF143_ChIPseq --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_Yan_LoVo_ZNF143_ChIPseq.log

macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_GM12878_ZNF143_ChIPseq_ENCLB209ACW.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_GM12878_IgG_ENCLB209AHM.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_GM12878_ZNF143_ChIPseq_ENCLB209ACW --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_GM12878_ZNF143_ChIPseq_ENCLB209ACW.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_GM12878_ZNF143_ChIPseq_ENCLB209ACX.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_GM12878_IgG_ENCLB596MBK.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_GM12878_ZNF143_ChIPseq_ENCLB209ACX --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_GM12878_ZNF143_ChIPseq_ENCLB209ACX.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQS.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_K562_IgG_ENCLB603BJA.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQS --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQS.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQT.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_K562_IgG_ENCLB603BJA.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQT --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQT.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_K562_ZNF143_ChIPseq_ENCLB658FFM.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_K562_Input_ENCLB271UTF.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_K562_ZNF143_ChIPseq_ENCLB658FFM --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_K562_ZNF143_ChIPseq_ENCLB658FFM.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_K562_ZNF143_ChIPseq_ENCLB046RFO.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_K562_Input_ENCLB271UTF.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_K562_ZNF143_ChIPseq_ENCLB046RFO --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_K562_ZNF143_ChIPseq_ENCLB046RFO.log

macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_HeLa_ZNF143_ChIPseq_ENCLB209APP.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_HeLa_IgG_ENCLB209AFI.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_HeLa_ZNF143_ChIPseq_ENCLB209APP --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_HeLa_ZNF143_ChIPseq_ENCLB209APP.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_HeLa_ZNF143_ChIPseq_ENCLB209APQ.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_HeLa_IgG_ENCLB209AFI.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_HeLa_ZNF143_ChIPseq_ENCLB209APQ --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_HeLa_ZNF143_ChIPseq_ENCLB209APQ.log

macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_HepG2_ZNF143_ChIPseq_ENCLB338WAD.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_HepG2_Input_ENCLB730UCF.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_HepG2_ZNF143_ChIPseq_ENCLB338WAD --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_HepG2_ZNF143_ChIPseq_ENCLB338WAD.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_HepG2_ZNF143_ChIPseq_ENCLB844JXX.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_HepG2_Input_ENCLB730UCF.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_HepG2_ZNF143_ChIPseq_ENCLB844JXX --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_HepG2_ZNF143_ChIPseq_ENCLB844JXX.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_H1_ZNF143_ChIPseq_ENCLB209ABL.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_H1_IgG_ENCLB674MWE.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_H1_ZNF143_ChIPseq_ENCLB209ABL --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_H1_ZNF143_ChIPseq_ENCLB209ABL.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_H1_ZNF143_ChIPseq_ENCLB209AIM.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_H1_IgG_ENCLB674MWE.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_H1_ZNF143_ChIPseq_ENCLB209AIM --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_H1_ZNF143_ChIPseq_ENCLB209AIM.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_WTC11_ZNF143_ChIPseq_ENCLB573UDX.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_WTC11_Input_ENCLB216WMR.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_WTC11_ZNF143_ChIPseq_ENCLB573UDX --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_WTC11_ZNF143_ChIPseq_ENCLB573UDX.log
    
macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_WTC11_ZNF143_ChIPseq_ENCLB656SHY.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_WTC11_Input_ENCLB216WMR.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_WTC11_ZNF143_ChIPseq_ENCLB656SHY --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_WTC11_ZNF143_ChIPseq_ENCLB656SHY.log

###
### Human datasets: paired-end with input
###
macs2 callpeak -f BAMPE --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/ENCODE_GM12878_ZNF143_ChIPseq_ENCLB901VQJ.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/ENCODE_GM12878_Input_ENCLB793DEG.hg38.mapq.proper.sorted.rmdup.bam \
	--name=ENCODE_GM12878_ZNF143_ChIPseq_ENCLB901VQJ --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_ENCODE_GM12878_ZNF143_ChIPseq_ENCLB901VQJ.log
    
macs2 callpeak -f BAMPE --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/Lyu_H9_ZNF143_ChIPseq.hg38.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/Lyu_H9_IgG.hg38.mapq.proper.sorted.rmdup.bam \
	--name=Lyu_H9_ZNF143_ChIPseq --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_Lyu_H9_ZNF143_ChIPseq.log

###
### Mouse datasets: single-end without input
###
for SAMPLE in Ngondo-Mbongo_3T3_Zfp143_ChIPseq Ngondo-Mbongo_MEF_Zfp143_ChIPseq Ngondo-Mbongo_mESC_Zfp143_ChIPseq
do
	macs2 callpeak -f BAM --gsize=hs --qvalue=0.05 --keep-dup all --nomodel \
		-t ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam \
		--name=${SAMPLE} --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_${SAMPLE}.log
done

###
### Mouse datasets: paired-end without input
###
for SAMPLE in Jung_Sperm_Zfp143_ChIPseq_rep1 Jung_Sperm_Zfp143_ChIPseq_rep2 
do
	macs2 callpeak -f BAMPE --gsize=mm --qvalue=0.05 --keep-dup all --nomodel \
		-t ${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.rmdup.bam \
		--name=${SAMPLE} --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_${SAMPLE}.log
done

###
### Mouse datasets: paired-end with input
###
macs2 callpeak -f BAMPE --gsize=mm --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/Zhou_WT_Zfp143_ChIPseq_rep1.mm10.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/Zhou_WT_Input.mm10.mapq.proper.sorted.rmdup.bam \
	--name=Zhou_WT_Zfp143_ChIPseq_rep1 --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_Zhou_WT_Zfp143_ChIPseq_rep1.log

macs2 callpeak -f BAMPE --gsize=mm --qvalue=0.05 --keep-dup all --nomodel \
	-t ${INPUT_PATH}/bam/Zhou_WT_Zfp143_ChIPseq_rep2.mm10.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/Zhou_WT_Input.mm10.mapq.proper.sorted.rmdup.bam \
	--name=Zhou_WT_Zfp143_ChIPseq_rep2 --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs2_Zhou_WT_Zfp143_ChIPseq_rep2.log