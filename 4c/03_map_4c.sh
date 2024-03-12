# !/bin/bash
GENOME=/DATA/users/magnitov/znf143/genome/Mus_musculus.GRCm38.dna.primary_assembly.fa
INPUT_PATH=/DATA/users/magnitov/znf143/4c

mkdir -p ${INPUT_PATH}/bam

for SAMPLE in 4C_DMSO_rep1 4C_DMSO_rep2 4C_dTAG_6H_rep1 4C_dTAG_6H_rep2
do
	for VIEWPOINT in Cpox Cldn1 Zfp111 Zfp108 Prmt6 Rbm41 Sik1
	do
		echo "Mapping ${SAMPLE} ${VIEWPOINT}"
		bwa aln -t 32 ${GENOME} ${INPUT_PATH}/fastq_split/${SAMPLE}.${VIEWPOINT}.fastq.gz > ${INPUT_PATH}/bam/${SAMPLE}.${VIEWPOINT}.sai
		bwa samse ${GENOME} ${INPUT_PATH}/bam/${SAMPLE}.${VIEWPOINT}.sai ${INPUT_PATH}/fastq_split/${SAMPLE}.${VIEWPOINT}.fastq.gz |\
			samtools view -@ 32 -h -S -b -q 3 -F 4 | \
			samtools sort -@ 32 - > ${INPUT_PATH}/bam/${SAMPLE}.${VIEWPOINT}.mapped.mapq.sorted.bam
		rm ${INPUT_PATH}/bam/${SAMPLE}.${VIEWPOINT}.sai
	done
done
