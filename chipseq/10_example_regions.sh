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

###
### 4C examples
###
pyGenomeTracks --tracks ${DATA_PATH}/example_CTCF_ZFP143.ini --region chr16:58478501-58977284 \
        -o ${DATA_PATH}/example_4C_CTCF_ZFP143_Cldn1.png --dpi 300 --width 15 --height 10 --fontSize 10 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_CTCF_ZFP143.ini --region chr16:58421954-58921807 \
        -o ${DATA_PATH}/example_4C_CTCF_ZFP143_Cpox.png --dpi 300 --width 15 --height 10 --fontSize 10 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_CTCF_ZFP143.ini --region chr7:24004686-24503794 \
        -o ${DATA_PATH}/example_4C_CTCF_ZFP143_Zfp108.png --dpi 300 --width 15 --height 10 --fontSize 10 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_CTCF_ZFP143.ini --region chr7:23958193-24457739 \
        -o ${DATA_PATH}/example_4C_CTCF_ZFP143_Zfp111.png --dpi 300 --width 15 --height 10 --fontSize 10 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_CTCF_ZFP143.ini --region chr3:110000999-110499477 \
        -o ${DATA_PATH}/example_4C_CTCF_ZFP143_Prmt6.png --dpi 300 --width 15 --height 10 --fontSize 10 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_CTCF_ZFP143.ini --region chrX:139747559-140247149 \
        -o ${DATA_PATH}/example_4C_CTCF_ZFP143_Rbm41.png --dpi 300 --width 15 --height 10 --fontSize 10 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_CTCF_ZFP143.ini --region chr12:16644392-17145064 \
        -o ${DATA_PATH}/example_4C_CTCF_ZFP143_Rock2.png --dpi 300 --width 15 --height 10 --fontSize 10 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_CTCF_ZFP143.ini --region chr17:31606523-32105198 \
        -o ${DATA_PATH}/example_4C_CTCF_ZFP143_Sik1.png --dpi 300 --width 15 --height 10 --fontSize 10 --trackLabelHAlign right
