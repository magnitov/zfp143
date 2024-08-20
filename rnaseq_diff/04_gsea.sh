# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/znf143/
TARGETS_PATH=/DATA/users/magnitov/znf143/chipseq
GSEA=/DATA/users/magnitov/software/GSEA_Linux_4.3.2/gsea-cli.sh

for TIME in dtag_dmso ra_dmso ra_dtag ra_dtag_dmso
do
	# Hallmarks
	${GSEA} GSEAPreranked -gmx ${INPUT_PATH}/genome/msigdb_mouse/mh.all.v2023.2.Mm.symbols.gmt -rnk ${INPUT_PATH}/rnaseq_diff/gsea/genes_${TIME}.ranked.rnk \
		-set_max 1000000 -set_min 0 -rpt_label Hallmarks_${TIME} -out ${INPUT_PATH}/rnaseq_diff/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -plot_top_x 25 -rnd_seed timestamp -zip_report false

	# GO terms
	${GSEA} GSEAPreranked -gmx ${INPUT_PATH}/genome/msigdb_mouse/m5.go.bp.v2023.2.Mm.symbols.gmt -rnk ${INPUT_PATH}/rnaseq_diff/gsea/genes_${TIME}.ranked.rnk \
		-set_max 1000000 -set_min 0 -rpt_label GO_BP_${TIME} -out ${INPUT_PATH}/rnaseq_diff/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -plot_top_x 25 -rnd_seed timestamp -zip_report false
	${GSEA} GSEAPreranked -gmx ${INPUT_PATH}/genome/msigdb_mouse/m5.go.mf.v2023.2.Mm.symbols.gmt -rnk ${INPUT_PATH}/rnaseq_diff/gsea/genes_${TIME}.ranked.rnk \
		-set_max 1000000 -set_min 0 -rpt_label GO_MF_${TIME} -out ${INPUT_PATH}/rnaseq_diff/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -plot_top_x 25 -rnd_seed timestamp -zip_report false
	${GSEA} GSEAPreranked -gmx ${INPUT_PATH}/genome/msigdb_mouse/m5.go.cc.v2023.2.Mm.symbols.gmt -rnk ${INPUT_PATH}/rnaseq_diff/gsea/genes_${TIME}.ranked.rnk \
		-set_max 1000000 -set_min 0 -rpt_label GO_CC_${TIME} -out ${INPUT_PATH}/rnaseq_diff/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -plot_top_x 25 -rnd_seed timestamp -zip_report false

	# Pathways
	${GSEA} GSEAPreranked -gmx ${INPUT_PATH}/genome/msigdb_mouse/m2.cp.reactome.v2023.2.Mm.symbols.gmt -rnk ${INPUT_PATH}/rnaseq_diff/gsea/genes_${TIME}.ranked.rnk \
		-set_max 1000000 -set_min 0 -rpt_label Canonical_pathways_${TIME} -out ${INPUT_PATH}/rnaseq_diff/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -plot_top_x 25 -rnd_seed timestamp -zip_report false

	# Cell types
	${GSEA} GSEAPreranked -gmx ${INPUT_PATH}/genome/msigdb_mouse/m8.all.v2023.2.Mm.symbols.gmt -rnk ${INPUT_PATH}/rnaseq_diff/gsea/genes_${TIME}.ranked.rnk \
		-set_max 1000000 -set_min 0 -rpt_label Cell_type_${TIME} -out ${INPUT_PATH}/rnaseq_diff/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -rnd_seed timestamp -zip_report false
 
	# ZFP143 targets
	${GSEA} GSEAPreranked -gmx ${TARGETS_PATH}/genes/ZFP143_target_genes.gmx \
		-rnk ${INPUT_PATH}/rnaseq_diff/gsea/genes_${TIME}.ranked.ensid.rnk \
		-set_max 1000000 -set_min 0 -rpt_label ZFP143_targets_${TIME} -out ${INPUT_PATH}/rnaseq_diff/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -rnd_seed timestamp -zip_report false
done
