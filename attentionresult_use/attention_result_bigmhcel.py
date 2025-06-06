#should goto /data1/wuguojia/data/mhc_benchmark/tools/bigmhc/src/ path to run the code
#should set /data1/wuguojia/data/mhc_benchmark/tools/bigmhc/src/predict.py #torch.set_num_threads(10)# 设置线程数，例如限制为 10 个线程 #torch.set_num_interop_threads(10)  # 控制并行任务间线程数 to avoid mistake, otherwise bigmhc could use over 80 cpu cores and will shut down quickly.
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import seaborn as sns
import pickle, importlib
import argparse
import subprocess
import sys
import lime
import lime.lime_tabular
import shap
import glob
import os
#####################################
test_path = '/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use'
train_path = '/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use'
output_path = '/data1/wuguojia/data/mhc_benchmark/attentionbase/result/bigmhc'
test_file = glob.glob(os.path.join(test_path, '*.csv'))
train_file_csv = glob.glob(os.path.join(train_path, '*.csv'))
train_file_pkl = glob.glob(os.path.join(train_path, '*.pkl'))
#####################################
#LIME
for test in test_file:
    base_name = os.path.basename(test).replace('.csv', '')
    train = next((file for file in train_file_csv if base_name in file), None)
    with open(test, 'r') as file:
        length = sum(1 for line in file)-1 #number of peptide
    for index in range(length):
        command = [
            "python", 
            "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
            "--input_list", test,
            "--index", str(index),
            "--predictor", "bigmhc",
            "--xai", "LIME",
            "--mode", "None",
            "--trainf_path", train,
            "--dest", output_path
        ]
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        if result.returncode == 0:
            print(f"LIME binding affinity done for index {index}")
        else:
            print(f"LIME Error for index {index}: {result.stderr}")
#SHAP
for test in test_file:
    base_name = os.path.basename(test).replace('.csv', '')
    train = next((file for file in train_file_pkl if base_name in file), None)
    with open(test, 'r') as file:
        length = sum(1 for line in file)-1 #number of peptide
    for index in range(length):
        command = [
            "python", 
            "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
            "--input_list", test,
            "--index", str(index),
            "--predictor", "bigmhc",
            "--xai", "SHAP",
            "--mode", "None",
            "--trainf_path", train,
            "--dest", output_path
        ]
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        if result.returncode == 0:
            print(f"SHAP binding affinity done for index {index}")
        else:
            print(f"SHAP Error for index {index}: {result.stderr}")