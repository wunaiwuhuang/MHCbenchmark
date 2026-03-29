#!/bin/bash
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*01:01_10.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*01:01_10.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*01:01_11.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*01:01_11.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*01:01_8.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*01:01_8.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*01:01_9.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*01:01_9.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*02:01_10.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*02:01_10.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*02:01_11.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*02:01_11.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*02:01_8.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*02:01_8.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*02:01_9.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*02:01_9.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*11:01_10.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*11:01_10.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*11:01_11.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*11:01_11.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*11:01_8.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*11:01_8.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*11:01_9.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*11:01_9.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*23:01_10.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*23:01_10.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*23:01_11.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*23:01_11.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*23:01_8.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*23:01_8.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*23:01_9.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*23:01_9.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*24:02_10.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*24:02_10.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*24:02_11.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*24:02_11.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*24:02_8.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*24:02_8.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-A*24:02_9.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-A*24:02_9.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*07:02_10.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*07:02_10.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*07:02_11.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*07:02_11.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*07:02_8.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*07:02_8.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*07:02_9.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*07:02_9.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*15:02_10.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*15:02_10.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*15:02_11.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*15:02_11.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*15:02_8.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*15:02_8.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*15:02_9.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*15:02_9.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*40:01_10.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*40:01_10.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*40:01_11.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*40:01_11.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*40:01_8.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*40:01_8.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*40:01_9.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*40:01_9.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*44:02_10.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*44:02_10.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*44:02_11.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*44:02_11.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*44:02_8.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*44:02_8.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*44:02_9.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*44:02_9.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*51:01_10.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*51:01_10.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*51:01_11.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*51:01_11.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*51:01_8.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*51:01_8.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
sed -i "140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/result/HLA-B*51:01_9.csv',index=False)|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
sed -i "144s|df = pd.read_csv(.*)|df = pd.read_csv('/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan/HLA-B*51:01_9.csv')|" "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
python /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py
