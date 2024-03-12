# !/bin/bash
INPUT_DIR=/DATA/users/magnitov/znf143/ttseq
mkdir -p ${INPUT_DIR}/bigwig

# Scale factors were calculated as the number of reads per sample adjusted to match the coverage of the sample with the highest coverage.
SCALEFACTOR_DMSO=1.27573886711
SCALEFACTOR_2H=1
SCALEFACTOR_6H=1.14938659086
SCALEFACTOR_24H=1.29167175248

bamCoverage --scaleFactor $SCALEFACTOR_DMSO -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_DMSO.bam -o ${INPUT_DIR}/bigwig/ZFP143_DMSO.bw
bamCoverage --scaleFactor $SCALEFACTOR_DMSO -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_DMSO_forward.bam -o ${INPUT_DIR}/bigwig/ZFP143_DMSO_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_DMSO -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_DMSO_reverse.bam -o ${INPUT_DIR}/bigwig/ZFP143_DMSO_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_2H -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_2H.bam -o ${INPUT_DIR}/bigwig/ZFP143_2H.bw
bamCoverage --scaleFactor $SCALEFACTOR_2H -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_2H_forward.bam -o ${INPUT_DIR}/bigwig/ZFP143_2H_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_2H -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_2H_reverse.bam -o ${INPUT_DIR}/bigwig/ZFP143_2H_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_6H -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_6H.bam -o ${INPUT_DIR}/bigwig/ZFP143_6H.bw
bamCoverage --scaleFactor $SCALEFACTOR_6H -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_6H_forward.bam -o ${INPUT_DIR}/bigwig/ZFP143_6H_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_6H -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_6H_reverse.bam -o ${INPUT_DIR}/bigwig/ZFP143_6H_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_24H -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_24H.bam -o ${INPUT_DIR}/bigwig/ZFP143_24H.bw
bamCoverage --scaleFactor $SCALEFACTOR_24H -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_24H_forward.bam -o ${INPUT_DIR}/bigwig/ZFP143_24H_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_24H -p 16 -b ${INPUT_DIR}/bam/TTseq_ZFP143_24H_reverse.bam -o ${INPUT_DIR}/bigwig/ZFP143_24H_reverse.bw
