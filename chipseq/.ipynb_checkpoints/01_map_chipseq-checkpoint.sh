# !/bin/bash
GENOME_MOUSE=/DATA/users/magnitov/znf143/genome/Mus_musculus.GRCm38.dna.primary_assembly.fa
GENOME_HUMAN=/DATA/users/magnitov/znf143/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq
PICARD=/DATA/users/magnitov/software/picard_2.25.6.jar

mkdir -p ${INPUT_PATH}/bam

###
### CTCF spike-in ChIP-seq processing
###
# 1. Mapping
for SAMPLE in CTCF_DMSO_lane1 CTCF_DMSO_lane2 CTCF_6H_lane1 CTCF_6H_lane2 Input_CTCF_DMSO
do
	bwa mem -t 16 -M ${GENOME_MOUSE} ${INPUT_PATH}/fastqlinks/${SAMPLE}_R1.fastq.gz ${INPUT_PATH}/fastqlinks/${SAMPLE}_R2.fastq.gz | \
		samtools view -@ 16 -h -S -b -f 2 -q 10 | \
		samtools sort -@ 16 - > ${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.bam

	bwa mem -t 16 -M ${GENOME_HUMAN} ${INPUT_PATH}/fastqlinks/${SAMPLE}_R1.fastq.gz ${INPUT_PATH}/fastqlinks/${SAMPLE}_R2.fastq.gz | \
		samtools view -@ 16 -h -S -b -f 2 -q 10 | \
		samtools sort -@ 16 - > ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam
done

# 2. Merging BAM files
cd ${INPUT_PATH}/bam
samtools merge -@ 16 CTCF_DMSO.mm10.mapq.proper.sorted.bam CTCF_DMSO_lane1.mm10.mapq.proper.sorted.bam CTCF_DMSO_lane2.mm10.mapq.proper.sorted.bam
samtools merge -@ 16 CTCF_6H.mm10.mapq.proper.sorted.bam CTCF_6H_lane1.mm10.mapq.proper.sorted.bam CTCF_6H_lane2.mm10.mapq.proper.sorted.bam
samtools merge -@ 16 CTCF_DMSO.hg38.mapq.proper.sorted.bam CTCF_DMSO_lane1.hg38.mapq.proper.sorted.bam CTCF_DMSO_lane2.hg38.mapq.proper.sorted.bam
samtools merge -@ 16 CTCF_6H.hg38.mapq.proper.sorted.bam CTCF_6H_lane1.hg38.mapq.proper.sorted.bam CTCF_6H_lane2.hg38.mapq.proper.sorted.bam

# 3. Removing duplicates
for SAMPLE in Input_CTCF_DMSO CTCF_DMSO CTCF_6H Input_CTCF_DMSO
do
	java -jar ${PICARD} MarkDuplicates \
	I=${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.bam \
		O=${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.rmdup.bam \
		M=${INPUT_PATH}/bam/${SAMPLE}.mm10.dedupMetrics.txt \
		REMOVE_DUPLICATES=true

	java -jar ${PICARD} MarkDuplicates \
		I=${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam \
		O=${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam \
		M=${INPUT_PATH}/bam/${SAMPLE}.hg38.dedupMetrics.txt \
		REMOVE_DUPLICATES=true
done

# 4. Getting flagstat and indexing BAM
for SAMPLE in Input_CTCF_DMSO CTCF_DMSO CTCF_6H Input_CTCF_DMSO
do
	samtools flagstat ${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.rmdup.bam > ${INPUT_PATH}/bam/flagstat.${SAMPLE}.mm10.mapq.proper.sorted.rmdup.txt
	samtools flagstat ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam > ${INPUT_PATH}/bam/flagstat.${SAMPLE}.hg38.mapq.proper.sorted.rmdup.txt
	samtools index ${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.rmdup.bam
	samtools index ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam
done

###
### ZFP143-HA ChIP-seq processing
###
# 1. Mapping
for SAMPLE in ZFP143_DMSO_lane1 ZFP143_DMSO_lane2 ZFP143_2H Input_ZFP143_DMSO
do
	# Mapping
	echo "Mapping reads"
	bwa mem -t 24 -M ${GENOME_MOUSE} ${INPUT_PATH}/fastqlinks/${SAMPLE}_R1.fastq.gz ${INPUT_PATH}/fastqlinks/${SAMPLE}_R2.fastq.gz | \
		samtools view -@ 24 -h -S -b -f 2 -q 10 | \
		samtools sort -@ 24 - > ${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.bam
done

# 2. Merging BAM files
cd ${INPUT_PATH}/bam
samtools merge -@ 16 ZFP143_DMSO.mm10.mapq.proper.sorted.bam ZFP143_DMSO_lane1.mm10.mapq.proper.sorted.bam ZFP143_DMSO_lane2.mm10.mapq.proper.sorted.bam


# 3. Removing duplicates, getting flagstat and indexing BAM
for SAMPLE in ZFP143_DMSO ZFP143_2H Input_ZFP143_DMSO
do
	java -jar ${PICARD} MarkDuplicates \
		I=${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.bam \
		O=${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.rmdup.bam \
		M=${INPUT_PATH}/bam/${SAMPLE}.mm10.dedupMetrics.txt \
		REMOVE_DUPLICATES=true

	samtools flagstat ${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.rmdup.bam > ${INPUT_PATH}/bam/flagstat.${SAMPLE}.mm10.mapq.proper.sorted.rmdup.txt
	samtools index ${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.rmdup.bam
done
