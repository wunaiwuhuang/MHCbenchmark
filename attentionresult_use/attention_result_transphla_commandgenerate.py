# main.py
import os
import glob
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import seaborn as sns
import pickle
import importlib
import argparse
import subprocess
import sys

#####################################
test_path = '/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use'
train_path = '/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use'
output_path = '/data1/wuguojia/data/mhc_benchmark/attentionbase/result/transphla'
test_file = glob.glob(os.path.join(test_path, '*.csv'))
train_file_csv = glob.glob(os.path.join(train_path, '*.csv'))
train_file_pkl = glob.glob(os.path.join(train_path, '*.pkl'))
#####################################

# 函数生成 LIME 命令
def generate_lime_commands(test_file, train_file_csv, output_path):
    commands = []
    for test in test_file:
        base_name = os.path.basename(test).replace('.csv', '')
        train = next((file for file in train_file_csv if base_name in file), None)
        with open(test, 'r') as file:
            length = sum(1 for line in file) - 1  # number of peptide
        for index in range(length):
            command = f"""
command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "{test}",
    "--index", "{index}",
    "--predictor", "transphla",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "{train}",
    "--dest", "{output_path}"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index {index}")
else:
    print(f"LIME Error for index {index}: {{result.stderr}}")
"""
            commands.append(command)
    return commands

# 函数生成 SHAP 命令
def generate_shap_commands(test_file, train_file_pkl, output_path):
    commands = []
    for test in test_file:
        base_name = os.path.basename(test).replace('.csv', '')
        train = next((file for file in train_file_pkl if base_name in file), None)
        with open(test, 'r') as file:
            length = sum(1 for line in file) - 1  # number of peptide
        for index in range(length):
            command = f"""
command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "{test}",
    "--index", "{index}",
    "--predictor", "transphla",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "{train}",
    "--dest", "{output_path}"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index {index}")
else:
    print(f"SHAP Error for index {index}: {{result.stderr}}")
"""
            commands.append(command)
    return commands

# 生成命令并写入文件
lime_commands = generate_lime_commands(test_file, train_file_csv, output_path)
shap_commands = generate_shap_commands(test_file, train_file_pkl, output_path)

with open('attention_result_transphla_singlecommand.py', 'w') as f:
    f.write("import subprocess\n")
    for cmd in lime_commands + shap_commands:
        f.write(cmd)
        f.write("\n")
