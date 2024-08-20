# !/bin/bash
INPUT_DIR=/DATA/users/magnitov/znf143/rnaseq
GENOME_DIR=/DATA/users/magnitov/znf143/genome
STAR=/DATA/users/magnitov/software/STAR-2.7.9a/bin/Linux_x86_64/STAR

mkdir -p ${INPUT_DIR}/bam
mkdir -p ${INPUT_DIR}/stats

for SAMPLE in ZFP143_DMSO ZFP143_24H ZFP143_48H ZFP143_72H
do
	for REPLICATE in rep1 rep2
	do
		echo "Mapping reads"
		${STAR} --runThreadN 16 --outSAMtype BAM SortedByCoordinate --readFilesCommand zcat --quantMode GeneCounts \
			--genomeDir ${GENOME_DIR}/mm10_STARgenome --outFileNamePrefix ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_ \
			--readFilesIn ${INPUT_DIR}/fastqlinks/${SAMPLE}_${REPLICATE}_R1.fastq.gz ${INPUT_DIR}/fastqlinks/${SAMPLE}_${REPLICATE}_R2.fastq.gz
		rm ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_SJ.out.tab
		rm ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_Log.out ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_Log.progress.out
		mv ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_Log.final.out ${INPUT_DIR}/stats/${SAMPLE}_${REPLICATE}_Log.final.out
	done
done

