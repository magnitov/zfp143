# !/bin/bash
DATA_PATH=/DATA/users/magnitov/znf143/chipseq
GENOME_MOUSE=/DATA/users/magnitov/znf143/genome/Mus_musculus.GRCm38.dna.primary_assembly.fa

mkdir -p ${DATA_PATH}/motifs

for PEAKS in ZFP143 CTCF_DMSO CTCF_6H
do
	bedtools getfasta -fi /DATA/users/magnitov/znf143/genome/Mus_musculus.GRCm38.dna.primary_assembly.fa \
		-bed ${DATA_PATH}/peaks/${PEAKS}_peaks.bed > ${DATA_PATH}/peaks/${PEAKS}_peaks.bed.fa

	meme ${DATA_PATH}/peaks/${PEAKS}_peaks.bed.fa -dna -revcomp -mod zoops -p 16 \
		-oc ${DATA_PATH}/motifs/${PEAKS} -nmotifs 5 -minw 6 -maxw 50 -markov_order 0
done
