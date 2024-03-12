# !/bin/bash

mkdir -p expected

for SAMPLE in ZFP143_DMSO ZFP143_dTAG_6h
do
	for RESOLUTION in 5 #10 100
	do
		cooltools compute-expected -p 16 --ignore-diags 0 ./coolers/${SAMPLE}.mm10.mapq_30.5000.mcool::resolutions/${RESOLUTION}000 > ./expected/${SAMPLE}_oe_cis_${RESOLUTION}K.tsv
		cooltools compute-expected -p 16 --ignore-diags 0 ./coolers/${SAMPLE}.mm10.mapq_30.5000.mcool::resolutions/${RESOLUTION}000 > ./expected/${SAMPLE}_oe_cis_${RESOLUTION}K.tsv
	done
done

