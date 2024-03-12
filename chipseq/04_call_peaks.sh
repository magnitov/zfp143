# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq
BLACKLIST=/DATA/users/magnitov/znf143/genome/mm10-blacklist.v2.bed

mkdir -p ${INPUT_PATH}/peaks

macs2 callpeak --name=ZFP143 -f BAMPE --gsize=mm --qvalue=0.01 --keep-dup all \
        -t ${INPUT_PATH}/bam/ZFP143_DMSO.mm10.mapq.proper.sorted.rmdup.bam \
        -c ${INPUT_PATH}/bam/Input_ZFP143_DMSO.mm10.mapq.proper.sorted.rmdup.bam --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs_ZFP143.log

macs2 callpeak --name=CTCF_DMSO -f BAMPE --gsize=mm --qvalue=0.05 --keep-dup all \
        -t ${INPUT_PATH}/bam/CTCF_DMSO.mm10.mapq.proper.sorted.rmdup.bam \
        -c ${INPUT_PATH}/bam/Input_CTCF_DMSO.mm10.mapq.proper.sorted.rmdup.bam --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs_CTCF_DMSO.log

macs2 callpeak --name=CTCF_6H -f BAMPE --gsize=mm --qvalue=0.05 --keep-dup all \
	-t ${INPUT_PATH}/bam/CTCF_6H.mm10.mapq.proper.sorted.rmdup.bam \
	-c ${INPUT_PATH}/bam/Input_CTCF_DMSO.mm10.mapq.proper.sorted.rmdup.bam --outdir=${INPUT_PATH}/peaks 2> ${INPUT_PATH}/peaks/macs_CTCF_6H.log

for SAMPLE in ZFP143 CTCF_DMSO CTCF_6H
do
	grep -v -e 'GL' -e 'JH' -e 'KI' -e 'chrM' -e 'chrY' ${INPUT_PATH}/peaks/${SAMPLE}_peaks.narrowPeak |\
		sort -k1,1 -k2,2n | bedtools intersect -v -a stdin -b ${BLACKLIST} | sort -k1,1 -k2,2n > ${INPUT_PATH}/peaks/${SAMPLE}_peaks.bed
done
