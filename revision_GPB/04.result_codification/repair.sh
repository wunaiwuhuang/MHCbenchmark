#!/bin/bash
cd /data1/wuguojia/data/mhc_benchmark/tools/mhc_i || { echo "Failed to cd to /data1/wuguojia/data/mhc_benchmark/tools/mhc_i"; exit 1; }
./configure || { echo "Configuration failed"; exit 1; }

/data1/wuguojia/data/mhc_benchmark/tools/mhc_i/src/predict_binding.py netmhccons "HLA-B*57:01" 9 /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_base/1_vs_4/fasta/HLA-B*57:01_9.fasta > /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_result/1_vs_4/netmhccons/HLA-B*57:01_9.txt
/data1/wuguojia/data/mhc_benchmark/tools/mhc_i/src/predict_binding.py netmhccons "HLA-A*24:02" 9 /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_base/1_vs_9/fasta/HLA-A*24:02_9.fasta > /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_result/1_vs_9/netmhccons/HLA-A*24:02_9.txt
/data1/wuguojia/data/mhc_benchmark/tools/mhc_i/src/predict_binding.py netmhccons "HLA-A*33:01" 9 /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_base/1_vs_9/fasta/HLA-A*33:01_9.fasta > /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_result/1_vs_9/netmhccons/HLA-A*33:01_9.txt
/data1/wuguojia/data/mhc_benchmark/tools/mhc_i/src/predict_binding.py netmhccons "HLA-C*03:04" 9 /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_base/1_vs_9/fasta/HLA-C*03:04_9.fasta > /data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_result/1_vs_9/netmhccons/HLA-C*03:04_9.txt
