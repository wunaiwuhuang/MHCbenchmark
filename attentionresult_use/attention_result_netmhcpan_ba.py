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
output_path = '/data1/wuguojia/data/mhc_benchmark/attentionbase/result/netmhcpan_ba/'#you have to add / in the end,otherwise lots of redundant files will be created in result folder.
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
            "--predictor", "netmhcpan",
            "--xai", "LIME",
            "--mode", "BA_Rank",
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
            "--predictor", "netmhcpan",
            "--xai", "SHAP",
            "--mode", "BA_Rank",
            "--trainf_path", train,
            "--dest", output_path
        ]
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        if result.returncode == 0:
            print(f"SHAP binding affinity done for index {index}")
        else:
            print(f"SHAP Error for index {index}: {result.stderr}")