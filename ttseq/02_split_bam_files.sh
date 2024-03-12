# !/bin/bash
cd ./bam/

for DATASET in ZFP143_DMSO ZFP143_2H ZFP143_6H ZFP143_24H
do
	for REPLICATE in rep1 rep2
	do
		samtools view -@ 16 -b -f 128 -F 16 ${DATASET}_${REPLICATE}.bam > ${DATASET}_${REPLICATE}_for1.bam
		samtools view -@ 16 -b -f 80 ${DATASET}_${REPLICATE}.bam > ${DATASET}_${REPLICATE}_for2.bam
		samtools merge -@ 16 ${DATASET}_${REPLICATE}_forward_unsorted.bam ${DATASET}_${REPLICATE}_for1.bam ${DATASET}_${REPLICATE}_for2.bam
		samtools sort -@ 16 -o ${DATASET}_${REPLICATE}_forward.bam ${DATASET}_${REPLICATE}_forward_unsorted.bam
		rm ${DATASET}_${REPLICATE}_for1.bam ${DATASET}_${REPLICATE}_for2.bam ${DATASET}_${REPLICATE}_forward_unsorted.bam

		samtools view -@ 16 -b -f 144 ${DATASET}_${REPLICATE}.bam > ${DATASET}_${REPLICATE}_rev1.bam
		samtools view -@ 16 -b -f 64 -F 16 ${DATASET}_${REPLICATE}.bam > ${DATASET}_${REPLICATE}_rev2.bam
		samtools merge -@ 16 ${DATASET}_${REPLICATE}_reverse_unsorted.bam ${DATASET}_${REPLICATE}_rev1.bam ${DATASET}_${REPLICATE}_rev2.bam
		samtools sort -@ 16 -o ${DATASET}_${REPLICATE}_reverse.bam ${DATASET}_${REPLICATE}_reverse_unsorted.bam
		rm ${DATASET}_${REPLICATE}_rev1.bam ${DATASET}_${REPLICATE}_rev2.bam ${DATASET}_${REPLICATE}_reverse_unsorted.bam

		samtools index ${DATASET}_${REPLICATE}_forward.bam
		samtools index ${DATASET}_${REPLICATE}_reverse.bam
	done

	samtools merge -@ 16 TTseq_${DATASET}_unsorted.bam ${DATASET}_rep1.bam ${DATASET}_rep2.bam
	samtools sort -@ 16 -o TTseq_${DATASET}.bam TTseq_${DATASET}_unsorted.bam
	rm TTseq_${DATASET}_unsorted.bam
	samtools index TTseq_${DATASET}.bam

	samtools merge -@ 16 TTseq_${DATASET}_forward_unsorted.bam ${DATASET}_rep1_forward.bam ${DATASET}_rep2_forward.bam
	samtools sort -@ 16 -o TTseq_${DATASET}_forward.bam TTseq_${DATASET}_forward_unsorted.bam
	rm TTseq_${DATASET}_forward_unsorted.bam
	samtools index TTseq_${DATASET}_forward.bam

	samtools merge -@ 16 TTseq_${DATASET}_reverse_unsorted.bam ${DATASET}_rep1_reverse.bam ${DATASET}_rep2_reverse.bam
	samtools sort -@ 16 -o TTseq_${DATASET}_reverse.bam TTseq_${DATASET}_reverse_unsorted.bam
	rm TTseq_${DATASET}_reverse_unsorted.bam
	samtools index TTseq_${DATASET}_reverse.bam

done
