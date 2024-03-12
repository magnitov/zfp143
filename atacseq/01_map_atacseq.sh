# !/bin/bash
DATA_PATH=/DATA/users/magnitov/znf143/atacseq
GENOME_PATH=/DATA/users/magnitov/znf143/genome/Mus_musculus.GRCm38.dna.primary_assembly.fa
PICARD=/DATA/users/magnitov/software/picard_2.25.6.jar

mkdir -p ${DATA_PATH}/bam

for SAMPLE in gastruloids_72H_DMSO gastruloids_96H_DMSO gastruloids_72H_dTAG_48H gastruloids_96H_dTAG_48H gastruloids_96H_dTAG_72H
do
	# Mapping reads
	bwa mem -t 16 -M ${GENOME_PATH} \
		${DATA_PATH}/fastqlinks/${SAMPLE}_R1.fastq.gz ${DATA_PATH}/fastqlinks/${SAMPLE}_R2.fastq.gz |\
		awk '{ if ($3!="chrM") print $0}' |\
		samtools view -@ 16 -h -S -b |\
		samtools sort -@ 16 - > ${DATA_PATH}/bam/${SAMPLE}_Aligned.sortedByCoord.out.bam

	# Filtering reads by mapping quality
	samtools view -h -S -b -q 10 -@ 16 -o ${DATA_PATH}/bam/${SAMPLE}_Aligned.sortedByCoord.mapq.bam \
		${DATA_PATH}/bam/${SAMPLE}_Aligned.sortedByCoord.out.bam
    
	# Mark duplicated read pairs
	java -jar ${PICARD} MarkDuplicates REMOVE_DUPLICATES= true \
		I=${DATA_PATH}/bam/${SAMPLE}_Aligned.sortedByCoord.mapq.bam \
		O=${DATA_PATH}/bam/${SAMPLE}_Aligned.sortedByCoord.mapq.nodups.bam \
		M=${DATA_PATH}/bam/${SAMPLE}_dedupMetrics.txt
done
