# !/bin/bash
DATA_PATH=/DATA/users/magnitov/znf143/chipseq/public_data/
BLACKLIST=/DATA/users/magnitov/znf143/genome/mm10-blacklist.v2.bed
GENOME_2BIT=/DATA/users/magnitov/znf143/genome/mm10.2bit

computeGCBias -p 32 --effectiveGenomeSize 2652783500 -g ${GENOME_2BIT} -bl ${BLACKLIST} \
	-b ${DATA_PATH}/bam/Zhou_WT_CTCF_ChIPseq_rep1.mm10.mapq.proper.sorted.rmdup.bam \
	--GCbiasFrequenciesFile ${DATA_PATH}/zhou_data/gc_bias/gc_bias_WT_CTCF_rep1.txt

computeGCBias -p 32 --effectiveGenomeSize 2652783500 -g ${GENOME_2BIT} -bl ${BLACKLIST} \
	-b ${DATA_PATH}/bam/Zhou_WT_CTCF_ChIPseq_rep2.mm10.mapq.proper.sorted.rmdup.bam \
	--GCbiasFrequenciesFile ${DATA_PATH}/zhou_data/gc_bias/gc_bias_WT_CTCF_rep2.txt

computeGCBias -p 32 --effectiveGenomeSize 2652783500 -g ${GENOME_2BIT} -bl ${BLACKLIST} \
	-b ${DATA_PATH}/bam/Zhou_KO_CTCF_ChIPseq_rep1.mm10.mapq.proper.sorted.rmdup.bam \
	--GCbiasFrequenciesFile ${DATA_PATH}/zhou_data/gc_bias/gc_bias_KO_CTCF_rep1.txt
    
computeGCBias -p 32 --effectiveGenomeSize 2652783500 -g ${GENOME_2BIT} -bl ${BLACKLIST} \
	-b ${DATA_PATH}/bam/Zhou_KO_CTCF_ChIPseq_rep2.mm10.mapq.proper.sorted.rmdup.bam \
	--GCbiasFrequenciesFile ${DATA_PATH}/zhou_data/gc_bias/gc_bias_KO_CTCF_rep2.txt
