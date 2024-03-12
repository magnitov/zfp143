# !/bin/bash
INPUT_DIR=/DATA/users/magnitov/znf143/rnaseq
GENOME_DIR=/DATA/users/magnitov/znf143/genome
STAR=/DATA/users/magnitov/software/STAR-2.7.9a/bin/Linux_x86_64/STAR

mkdir -p ${GENOME_DIR}/hg38_STARgenome
${STAR} --runMode genomeGenerate --runThreadN 16 --genomeDir ${GENOME_DIR}/hg38_STARgenome --genomeFastaFiles ${GENOME_DIR}/Homo_sapiens.GRCh38.dna.primary_assembly.fa --sjdbGTFfile ${GENOME_DIR}/gencode.v42.annotation.gtf

mkdir -p ${INPUT_DIR}/bam
mkdir -p ${INPUT_DIR}/stats

for SAMPLE in ZFP143_DMSO_24H ZFP143_DMSO_24H_RA_24H ZFP143_dTAG_24H ZFP143_dTAG_24H_RA_24H
do
	for REPLICATE in rep1 rep2
	do
		echo "Mapping reads"
		${STAR} --runThreadN 16 --outSAMtype BAM SortedByCoordinate --readFilesCommand zcat --quantMode GeneCounts \
			--genomeDir ${GENOME_DIR}/mm10_STARgenome --outFileNamePrefix ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_ \
			--readFilesIn ${INPUT_DIR}/fastqlinks/${SAMPLE}_${REPLICATE}_R1.fastq.gz ${INPUT_DIR}/fastqlinks/${SAMPLE}_${REPLICATE}_R2.fastq.gz
		mv ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_Log.final.out ${INPUT_DIR}/stats/${SAMPLE}_${REPLICATE}_Log.final.out
	done
done

