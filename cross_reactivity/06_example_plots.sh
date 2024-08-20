DATA_PATH=/DATA/users/magnitov/znf143/chipseq/cross_reactivity/examples

pyGenomeTracks --tracks ${DATA_PATH}/example_1_common_and_proteintech.ini \
	--region chr1:54,045,000-54,130,000 \
	-o ${DATA_PATH}/example_1_common_and_proteintech.png \
	--dpi 300 --width 18 --height 14 --fontSize 10 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_1_common_and_proteintech_zoomed.ini \
	--region chr1:54,060,000-54,130,000 \
	-o ${DATA_PATH}/example_1_common_and_proteintech_zoomed.png \
	--dpi 300 --width 18 --height 14 --fontSize 10 --trackLabelHAlign right

pyGenomeTracks --tracks ${DATA_PATH}/example_2_common_and_proteintech.ini \
	--region chr19:49,077,002-49,126,000 \
	-o ${DATA_PATH}/example_2_common_and_proteintech.pdf \
	--dpi 300 --width 18 --height 14 --fontSize 10 --trackLabelHAlign right
pyGenomeTracks --tracks ${DATA_PATH}/example_2_common_and_proteintech_zoomed.ini \
	--region chr19:49,094,000-49,112,000 \
	-o ${DATA_PATH}/example_2_common_and_proteintech_zoomed.pdf \
	--dpi 300 --width 18 --height 14 --fontSize 10 --trackLabelHAlign right
