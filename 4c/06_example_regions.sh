DATA_PATH=/DATA/users/magnitov/znf143/4c/tracks

pyGenomeTracks --tracks ${DATA_PATH}/example_ChIPseq_TTseq_Cldn1_Cpox.ini -o ${DATA_PATH}/example_4C_Cldn1_Cpox.pdf \
	--region chr16:58400000-58800000 --dpi 300 --width 10 --height 7 --fontSize 6 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_ChIPseq_TTseq_Zfp108_Zfp111.ini -o ${DATA_PATH}/example_4C_Zfp108_Zfp111.pdf \
	--region chr7:24110000-24350000 --dpi 300 --width 10 --height 7 --fontSize 6 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_ChIPseq_TTseq_Prmt6.ini -o ${DATA_PATH}/example_4C_Prmt6.pdf \
	--region chr3:110050000-110350000 --dpi 300 --width 10 --height 7 --fontSize 6 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_ChIPseq_TTseq_Rbm41.ini -o ${DATA_PATH}/example_4C_Rbm41.pdf \
	--region chrX:139910000-140150000 --dpi 300 --width 10 --height 7 --fontSize 6 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_ChIPseq_TTseq_Sik1.ini -o ${DATA_PATH}/example_4C_Sik1.pdf \
	--region chr17:31630000-31915000 --dpi 300 --width 10 --height 7 --fontSize 6 --trackLabelHAlign right

pyGenomeTracks --tracks ${DATA_PATH}/example_ChIPseq_TTseq_Cldn1_Cpox_bed_genes.ini -o ${DATA_PATH}/example_4C_Cldn1_Cpox_bed_genes.png \
	--region chr16:58400000-58800000 --dpi 300 --width 10 --height 7 --fontSize 6 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_ChIPseq_TTseq_Zfp108_Zfp111_bed_genes.ini -o ${DATA_PATH}/example_4C_Zfp108_Zfp111_bed_genes.png \
	--region chr7:24110000-24350000 --dpi 300 --width 10 --height 7 --fontSize 6 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_ChIPseq_TTseq_Prmt6_bed_genes.ini -o ${DATA_PATH}/example_4C_Prmt6_bed_genes.png \
	--region chr3:110050000-110350000 --dpi 300 --width 10 --height 7 --fontSize 6 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_ChIPseq_TTseq_Rbm41_bed_genes.ini -o ${DATA_PATH}/example_4C_Rbm41_bed_genes.png \
	--region chrX:139910000-140150000 --dpi 300 --width 10 --height 7 --fontSize 6 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_ChIPseq_TTseq_Sik1_bed_genes.ini -o ${DATA_PATH}/example_4C_Sik1_bed_genes.png \
	--region chr17:31630000-31915000 --dpi 300 --width 10 --height 7 --fontSize 6 --trackLabelHAlign right
