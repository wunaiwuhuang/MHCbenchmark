#!/bin/bash
source /data1/wuguojia/software/miniconda/etc/profile.d/conda.sh
conda activate mhcflurry-env

mhcflurry-predict /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_base/1_vs_4/csv/HLA-B*39:01_11.csv --out /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_result/1_vs_4/mhcflurry/HLA-B*39:01_11.csv
mhcflurry-predict /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_base/1_vs_9/csv/HLA-B*13:02_9.csv --out /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_result/1_vs_9/mhcflurry/HLA-B*13:02_9.csv