# !/bin/bash
GENOME_HUMAN=/DATA/users/magnitov/znf143/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq/cross_reactivity
PICARD=/DATA/users/magnitov/software/picard_2.25.6.jar

mkdir -p ${INPUT_PATH}/bam

for SAMPLE in Guertin_ZNF143_Proteintech_DMSO_rep1 Guertin_ZNF143_Proteintech_DMSO_rep2 Guertin_ZNF143_Proteintech_DMSO_rep3 Guertin_ZNF143_Proteintech_DMSO_rep4 Guertin_ZNF143_Proteintech_dTAG_30min_rep1 Guertin_ZNF143_Proteintech_dTAG_30min_rep2 Guertin_ZNF143_Proteintech_dTAG_30min_rep3 Guertin_ZNF143_Proteintech_dTAG_30min_rep4 Guertin_CTCF_DMSO_rep1 Guertin_CTCF_DMSO_rep2 Guertin_CTCF_DMSO_rep3 Guertin_CTCF_dTAG_30min_rep1 Guertin_CTCF_dTAG_30min_rep2 Guertin_CTCF_dTAG_30min_rep3 Dong_ZNF143_HA_DMSO_rep1 Dong_ZNF143_HA_DMSO_rep2 Dong_ZNF143_HA_dTAG_30min_rep1 Dong_ZNF143_HA_dTAG_30min_rep2
do
	bwa mem -t 48 -M ${GENOME_HUMAN} ${INPUT_PATH}/fastq/${SAMPLE}_R1.fastq.gz ${INPUT_PATH}/fastq/${SAMPLE}_R2.fastq.gz | \
		samtools view -@ 48 -h -S -b -f 2 -q 10 | \
		samtools sort -@ 48 - > ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam

	java -jar ${PICARD} MarkDuplicates \
		I=${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam \
		O=${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam \
		M=${INPUT_PATH}/bam/${SAMPLE}.hg38.dedupMetrics.txt \
		REMOVE_DUPLICATES=true

	samtools flagstat ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam > ${INPUT_PATH}/bam/flagstat.${SAMPLE}.hg38.mapq.proper.sorted.rmdup.txt
	samtools index ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam
done

cd ${INPUT_PATH}/bam
samtools merge -@ 36 Guertin_ZNF143_Proteintech_DMSO.hg38.mapq.proper.sorted.rmdup.bam \
	Guertin_ZNF143_Proteintech_DMSO_rep1.hg38.mapq.proper.sorted.rmdup.bam Guertin_ZNF143_Proteintech_DMSO_rep2.hg38.mapq.proper.sorted.rmdup.bam Guertin_ZNF143_Proteintech_DMSO_rep3.hg38.mapq.proper.sorted.rmdup.bam Guertin_ZNF143_Proteintech_DMSO_rep4.hg38.mapq.proper.sorted.rmdup.bam
samtools merge -@ 36 Guertin_ZNF143_Proteintech_dTAG_30min.hg38.mapq.proper.sorted.rmdup.bam \
	Guertin_ZNF143_Proteintech_dTAG_30min_rep1.hg38.mapq.proper.sorted.rmdup.bam Guertin_ZNF143_Proteintech_dTAG_30min_rep2.hg38.mapq.proper.sorted.rmdup.bam Guertin_ZNF143_Proteintech_dTAG_30min_rep3.hg38.mapq.proper.sorted.rmdup.bam Guertin_ZNF143_Proteintech_dTAG_30min_rep4.hg38.mapq.proper.sorted.rmdup.bam
samtools merge -@ 36 Dong_ZNF143_HA_DMSO.hg38.mapq.proper.sorted.rmdup.bam \
	Dong_ZNF143_HA_DMSO_rep1.hg38.mapq.proper.sorted.rmdup.bam Dong_ZNF143_HA_DMSO_rep2.hg38.mapq.proper.sorted.rmdup.bam
samtools merge -@ 36 Dong_ZNF143_HA_dTAG_30min.hg38.mapq.proper.sorted.rmdup.bam \
	Dong_ZNF143_HA_dTAG_30min_rep1.hg38.mapq.proper.sorted.rmdup.bam Dong_ZNF143_HA_dTAG_30min_rep2.hg38.mapq.proper.sorted.rmdup.bam
samtools merge -@ 36 Guertin_CTCF_DMSO.hg38.mapq.proper.sorted.rmdup.bam \
	Guertin_CTCF_DMSO_rep1.hg38.mapq.proper.sorted.rmdup.bam Guertin_CTCF_DMSO_rep2.hg38.mapq.proper.sorted.rmdup.bam Guertin_CTCF_DMSO_rep3.hg38.mapq.proper.sorted.rmdup.bam
samtools merge -@ 36 Guertin_CTCF_dTAG_30min.hg38.mapq.proper.sorted.rmdup.bam \
	Guertin_CTCF_dTAG_30min_rep1.hg38.mapq.proper.sorted.rmdup.bam Guertin_CTCF_dTAG_30min_rep2.hg38.mapq.proper.sorted.rmdup.bam Guertin_CTCF_dTAG_30min_rep3.hg38.mapq.proper.sorted.rmdup.bam

