# !/bin/bash
DATA_PATH=/DATA/users/magnitov/znf143/chipseq/examples

###
### ZFP143-HA ChIP-seq example
###
pyGenomeTracks --tracks ${DATA_PATH}/example_ZFP143_Tcp1.ini --region chr17:12,914,500-12,918,500 \
	-o ${DATA_PATH}/example_ZFP143_Tcp1_promoter.png --dpi 300 --width 5 --height 12 --fontSize 10 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_ZFP143_Taldo1.ini --region chr7:141,390,000-141,394,000 \
	-o ${DATA_PATH}/example_ZFP143_Taldo1_promoter.png --dpi 300 --width 5 --height 12 --fontSize 10 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_ZFP143_Mrps11.ini --region chr7:78,781,000-78,785,000 \
	-o ${DATA_PATH}/example_ZFP143_Mrps11_promoter.png --dpi 300 --width 5 --height 12 --fontSize 10 --trackLabelHAlign right

###
### CTCF ChIP-seq example
###
pyGenomeTracks --tracks ${DATA_PATH}/example_CTCF_ZFP143.ini --region chr1:75,405,000-75,465,000 \
	-o ${DATA_PATH}/example_CTCF_ZFP143_chr1.pdf --dpi 300 --width 25 --height 12 --fontSize 10 --trackLabelHAlign right
