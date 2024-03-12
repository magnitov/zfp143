# !/bin/bash
GENOME_MOUSE=/DATA/users/magnitov/znf143/genome/Mus_musculus.GRCm38.dna.primary_assembly.fa
GENOME_HUMAN=/DATA/users/magnitov/znf143/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa
INPUT_PATH=/DATA/users/magnitov/znf143/chipseq/public_data
PICARD=/DATA/users/magnitov/software/picard_2.25.6.jar

mkdir -p ${INPUT_PATH}/bam

###
### Paired-end ChIP-seq
###
# Mouse samples
for SAMPLE in HSPC_Ochi_Input_rep1 HSPC_Ochi_Input_rep2 HSPC_Ochi_CTCF_ChIPseq_rep1 HSPC_Ochi_CTCF_ChIPseq_rep2 Zhou_WT_CTCF_ChIPseq_rep1 Zhou_WT_CTCF_ChIPseq_rep2 Zhou_KO_CTCF_ChIPseq_rep1 Zhou_KO_CTCF_ChIPseq_rep2 Zhou_WT_Input Zhou_WT_Zfp143_ChIPseq_rep1 Zhou_WT_Zfp143_ChIPseq_rep2 Jung_Sperm_Zfp143_ChIPseq_rep1 Jung_Sperm_Zfp143_ChIPseq_rep2
do
	# Mapping
	echo "Mapping reads"
	bwa mem -t 16 -M ${GENOME_MOUSE} ${INPUT_PATH}/${SAMPLE}_R1.fastq.gz ${INPUT_PATH}/${SAMPLE}_R2.fastq.gz | \
		samtools view -@ 16 -h -S -b -f 2 -q 10 | \
		samtools sort -@ 16 - > ${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.bam

	# Remove duplicates
	echo "Removing duplicated reads"
	java -jar ${PICARD} MarkDuplicates \
		I=${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.bam \
		O=${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.rmdup.bam \
		M=${INPUT_PATH}/bam/${SAMPLE}.mm10.dedupMetrics.txt \
		REMOVE_DUPLICATES=true
done

# Human samples
for SAMPLE in ENCODE_GM12878_Input_ENCLB793DEG Lyu_H9_IgG ENCODE_GM12878_ZNF143_ChIPseq_ENCLB901VQJ Lyu_H9_ZNF143_ChIPseq
do
	# Mapping
	echo "Mapping reads"
	bwa mem -t 32 -M ${GENOME_HUMAN} ${INPUT_PATH}/${SAMPLE}_R1.fastq.gz ${INPUT_PATH}/${SAMPLE}_R2.fastq.gz | \
		samtools view -@ 32 -h -S -b -f 2 -q 10 | \
		samtools sort -@ 32 - > ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam

	# Remove duplicates
	echo "Removing duplicated reads"
	java -jar ${PICARD} MarkDuplicates \
		I=${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam \
		O=${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam \
		M=${INPUT_PATH}/bam/${SAMPLE}.hg38.dedupMetrics.txt \
		REMOVE_DUPLICATES=true
done

###
### Single-end ChIP-seq
###
# Mouse samples
for SAMPLE in HSPC_Viny_Input HSPC_Viny_CTCF_ChIPseq_rep1 HSPC_Viny_CTCF_ChIPseq_rep2 Ngondo-Mbongo_3T3_Zfp143_ChIPseq Ngondo-Mbongo_MEF_Zfp143_ChIPseq Ngondo-Mbongo_mESC_Zfp143_ChIPseq
do
	# Mapping
	echo "Mapping reads"
	bwa mem -t 16 -M ${GENOME_MOUSE} ${INPUT_PATH}/${SAMPLE}.fastq.gz | \
		samtools view -@ 16 -h -S -b -q 10 | \
		samtools sort -@ 16 - > ${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.bam

	# Remove duplicates
	echo "Removing duplicated reads"
	java -jar ${PICARD} MarkDuplicates \
		I=${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.bam \
		O=${INPUT_PATH}/bam/${SAMPLE}.mm10.mapq.proper.sorted.rmdup.bam \
		M=${INPUT_PATH}/bam/${SAMPLE}.mm10.dedupMetrics.txt \
		REMOVE_DUPLICATES=true
done

# Human samples
for SAMPLE in Zhang_HEC1B_ZNF143_ChIPnexus Zhang_HEC1B_AID_ZNF143_ChIPnexus K562_Input_Broad_run1 K562_Input_Broad_run2 K562_Input_Broad_run3 K562_Input_Broad_run4 K562_Input_Broad_run5 K562_CTCF_Broad_rep1 K562_CTCF_Broad_rep2 Cobo_Macrophages_Input_rep1 Cobo_Macrophages_Input_rep2 ENCODE_HepG2_Input_ENCLB730UCF ENCODE_K562_Input_ENCLB271UTF ENCODE_WTC11_Input_ENCLB216WMR Michaud_HeLa_Input_lane1 Michaud_HeLa_Input_lane2 Michaud_HeLa_Input_lane3 Tao_BE2C_Input Tenen_U937_Input Wang_CUTLL_Input_rep1 Wang_CUTLL_Input_rep2 Yan_LoVo_IgG Michaud_HeLa_ZNF143_ChIPseq Tenen_U937_ZNF143_ChIPexo Wang_CUTLL_ZNF143_ChIPseq Ngondo-Mbongo_HEK293_ZNF143_ChIPseq Ngondo-Mbongo_K562_ZNF143_ChIPseq Ngondo-Mbongo_HPB_ALL_ZNF143_ChIPseq Ngondo-Mbongo_HeLa_ZNF143_ChIPseq_rep1 Ngondo-Mbongo_HeLa_ZNF143_ChIPseq_rep2 Yan_LoVo_ZNF143_ChIPseq Treloar_MCF7_ZNF143_ChIPseq_rep1 Treloar_MCF7_ZNF143_ChIPseq_rep2 Cobo_Macrophages_ZNF143_ChIPseq_rep1 Cobo_Macrophages_ZNF143_ChIPseq_rep2 Tao_BE2C_ZNF143_ChIPseq ENCODE_HeLa_ZNF143_ChIPseq_ENCLB209APP ENCODE_HeLa_ZNF143_ChIPseq_ENCLB209APQ ENCODE_HepG2_ZNF143_ChIPseq_ENCLB844JXX ENCODE_HepG2_ZNF143_ChIPseq_ENCLB338WAD ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQS ENCODE_K562_ZNF143_ChIPseq_ENCLB209AQT ENCODE_K562_ZNF143_ChIPseq_ENCLB658FFM ENCODE_K562_ZNF143_ChIPseq_ENCLB046RFO ENCODE_WTC11_ZNF143_ChIPseq_ENCLB573UDX ENCODE_WTC11_ZNF143_ChIPseq_ENCLB656SHY ENCODE_H1_ZNF143_ChIPseq_ENCLB209AIM ENCODE_H1_ZNF143_ChIPseq_ENCLB209ABL ENCODE_GM12878_ZNF143_ChIPseq_ENCLB209ACW ENCODE_GM12878_ZNF143_ChIPseq_ENCLB209ACX 
do
	# Mapping
	echo "Mapping reads"
	bwa mem -t 32 -M ${GENOME_HUMAN} ${INPUT_PATH}/${SAMPLE}.fastq.gz | \
		samtools view -@ 32 -h -S -b -q 10 | \
		samtools sort -@ 32 - > ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam

	# Remove duplicates
	echo "Removing duplicated reads"
	java -jar ${PICARD} MarkDuplicates \
		I=${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam \
		O=${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam \
		M=${INPUT_PATH}/bam/${SAMPLE}.hg38.dedupMetrics.txt \
		REMOVE_DUPLICATES=true
done

# ENCODE IgG samples
for SAMPLE in ENCODE_GM12878_IgG_ENCLB209AHM ENCODE_GM12878_IgG_ENCLB596MBK ENCODE_HeLa_IgG_ENCLB209AFI ENCODE_K562_IgG_ENCLB603BJA ENCODE_H1_IgG_ENCLB674MWE
do
	# Mapping
	echo "Mapping reads"
	bwa aln -t 32 ${GENOME_HUMAN} ${INPUT_PATH}/${SAMPLE}.fastq.gz > ${INPUT_PATH}/${SAMPLE}.sai
	bwa samse ${GENOME_HUMAN} ${INPUT_PATH}/${SAMPLE}.sai ${INPUT_PATH}/${SAMPLE}.fastq.gz |\
		samtools view -@ 32 -h -S -b -q 10 -F 4 | \
		samtools sort -@ 32 - > ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam

	# Remove duplicates
	echo "Removing duplicated reads"
	java -jar ${PICARD} MarkDuplicates \
		I=${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam \
		O=${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam \
		M=${INPUT_PATH}/bam/${SAMPLE}.hg38.dedupMetrics.txt \
		REMOVE_DUPLICATES=true
done