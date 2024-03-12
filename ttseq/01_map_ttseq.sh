# !/bin/bash
INPUT_DIR=/DATA/users/magnitov/znf143/ttseq
GENOME_DIR=/DATA/users/magnitov/znf143/genome
STAR=/DATA/users/magnitov/software/STAR-2.7.9a/bin/Linux_x86_64/STAR
PICARD=/DATA/users/magnitov/software/picard_2.25.6.jar

mkdir -p ${GENOME_DIR}/mm10_STARgenome
${STAR} --runMode genomeGenerate --runThreadN 16 --genomeDir ${GENOME_DIR}/mm10_STARgenome --genomeFastaFiles ${GENOME_DIR}/Mus_musculus.GRCm38.dna.primary_assembly.fa --sjdbGTFfile ${GENOME_DIR}/gencode.vM25.annotation.gtf

mkdir -p ${INPUT_DIR}/bam
mkdir -p ${INPUT_DIR}/stats

for SAMPLE in ZFP143_DMSO ZFP143_2H ZFP143_6H ZFP143_24H
do
	for REPLICATE in rep1 rep2
	do
		echo "Mapping reads"
		${STAR} --runThreadN 8 --outSAMtype BAM SortedByCoordinate --readFilesCommand zcat --quantMode GeneCounts \
			--genomeDir ${GENOME_DIR}/mm10_STARgenome --outFileNamePrefix ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_ \
			--readFilesIn ${INPUT_DIR}/fastqlinks/${SAMPLE}_${REPLICATE}_R1.fastq.gz ${INPUT_DIR}/fastqlinks/${SAMPLE}_${REPLICATE}_R2.fastq.gz	
		rm ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_SJ.out.tab ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_Log.out ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_Log.progress.out
		num_pairs=`zcat ${INPUT_DIR}/fastqlinks/${SAMPLE}_${REPLICATE}_R1.fastq.gz | wc -l | awk '{print $0/4}'`

		echo "Filtering mapped pairs by MAPQ"
		samtools view -@ 16 -h -S -b -q 10 -o ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_mapq.bam \
			${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_Aligned.sortedByCoord.out.bam
		num_mapq=`samtools view ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_mapq.bam | wc -l | awk '{print $0/2}'`
		rm ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_Aligned.sortedByCoord.out.bam

		echo "Removing duplicates"
		java -jar ${PICARD} MarkDuplicates I=${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_mapq.bam \
			O=${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_mapq_nodups.bam \
			M=${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_dedupMetrics.txt REMOVE_DUPLICATES= true
		num_mapq_nodups=`samtools view ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_mapq_nodups.bam | wc -l | awk '{print $0/2}'`
		rm ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_mapq.bam

		echo "Cleaning files"
		mv ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_mapq_nodups.bam ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}.bam
		samtools index -@ 16 ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}.bam
		mv ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_Log.final.out ${INPUT_DIR}/stats/${SAMPLE}_${REPLICATE}_Log.final.out
		mv ${INPUT_DIR}/bam/${SAMPLE}_${REPLICATE}_dedupMetrics.txt ${INPUT_DIR}/stats/${SAMPLE}_${REPLICATE}_dedupMetrics.txt
	done
done
