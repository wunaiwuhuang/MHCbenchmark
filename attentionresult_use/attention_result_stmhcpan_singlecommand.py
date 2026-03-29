import subprocess

command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "0",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 0")
else:
    print(f"LIME Error for index 0: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "1",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 1")
else:
    print(f"LIME Error for index 1: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "2",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 2")
else:
    print(f"LIME Error for index 2: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "3",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 3")
else:
    print(f"LIME Error for index 3: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "4",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 4")
else:
    print(f"LIME Error for index 4: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "5",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 5")
else:
    print(f"LIME Error for index 5: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "6",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 6")
else:
    print(f"LIME Error for index 6: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "7",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 7")
else:
    print(f"LIME Error for index 7: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "8",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 8")
else:
    print(f"LIME Error for index 8: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "9",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 9")
else:
    print(f"LIME Error for index 9: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "10",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 10")
else:
    print(f"LIME Error for index 10: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "11",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 11")
else:
    print(f"LIME Error for index 11: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "12",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 12")
else:
    print(f"LIME Error for index 12: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "13",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 13")
else:
    print(f"LIME Error for index 13: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "14",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 14")
else:
    print(f"LIME Error for index 14: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "15",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 15")
else:
    print(f"LIME Error for index 15: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "16",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 16")
else:
    print(f"LIME Error for index 16: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "17",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 17")
else:
    print(f"LIME Error for index 17: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "18",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 18")
else:
    print(f"LIME Error for index 18: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "19",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 19")
else:
    print(f"LIME Error for index 19: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "20",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 20")
else:
    print(f"LIME Error for index 20: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "21",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 21")
else:
    print(f"LIME Error for index 21: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "22",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 22")
else:
    print(f"LIME Error for index 22: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "23",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 23")
else:
    print(f"LIME Error for index 23: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "24",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 24")
else:
    print(f"LIME Error for index 24: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "25",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 25")
else:
    print(f"LIME Error for index 25: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "26",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 26")
else:
    print(f"LIME Error for index 26: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "27",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 27")
else:
    print(f"LIME Error for index 27: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "28",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 28")
else:
    print(f"LIME Error for index 28: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "29",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 29")
else:
    print(f"LIME Error for index 29: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "30",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 30")
else:
    print(f"LIME Error for index 30: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "31",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 31")
else:
    print(f"LIME Error for index 31: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "32",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 32")
else:
    print(f"LIME Error for index 32: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "33",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 33")
else:
    print(f"LIME Error for index 33: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "34",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 34")
else:
    print(f"LIME Error for index 34: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "35",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 35")
else:
    print(f"LIME Error for index 35: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "36",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 36")
else:
    print(f"LIME Error for index 36: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "37",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 37")
else:
    print(f"LIME Error for index 37: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "38",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 38")
else:
    print(f"LIME Error for index 38: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "39",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 39")
else:
    print(f"LIME Error for index 39: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "40",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 40")
else:
    print(f"LIME Error for index 40: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "41",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 41")
else:
    print(f"LIME Error for index 41: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "42",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 42")
else:
    print(f"LIME Error for index 42: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "43",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 43")
else:
    print(f"LIME Error for index 43: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "44",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 44")
else:
    print(f"LIME Error for index 44: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "45",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 45")
else:
    print(f"LIME Error for index 45: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "46",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 46")
else:
    print(f"LIME Error for index 46: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "47",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 47")
else:
    print(f"LIME Error for index 47: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "48",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 48")
else:
    print(f"LIME Error for index 48: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "49",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 49")
else:
    print(f"LIME Error for index 49: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "50",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 50")
else:
    print(f"LIME Error for index 50: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "51",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 51")
else:
    print(f"LIME Error for index 51: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "52",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 52")
else:
    print(f"LIME Error for index 52: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "53",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 53")
else:
    print(f"LIME Error for index 53: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "54",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 54")
else:
    print(f"LIME Error for index 54: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "55",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 55")
else:
    print(f"LIME Error for index 55: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "56",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 56")
else:
    print(f"LIME Error for index 56: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "57",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 57")
else:
    print(f"LIME Error for index 57: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "58",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 58")
else:
    print(f"LIME Error for index 58: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "59",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 59")
else:
    print(f"LIME Error for index 59: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "60",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 60")
else:
    print(f"LIME Error for index 60: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "61",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 61")
else:
    print(f"LIME Error for index 61: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "62",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 62")
else:
    print(f"LIME Error for index 62: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "63",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 63")
else:
    print(f"LIME Error for index 63: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "64",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 64")
else:
    print(f"LIME Error for index 64: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "65",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 65")
else:
    print(f"LIME Error for index 65: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "66",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 66")
else:
    print(f"LIME Error for index 66: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "67",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 67")
else:
    print(f"LIME Error for index 67: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "68",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 68")
else:
    print(f"LIME Error for index 68: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "69",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 69")
else:
    print(f"LIME Error for index 69: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "70",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 70")
else:
    print(f"LIME Error for index 70: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "71",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 71")
else:
    print(f"LIME Error for index 71: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "72",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 72")
else:
    print(f"LIME Error for index 72: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "73",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 73")
else:
    print(f"LIME Error for index 73: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "74",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 74")
else:
    print(f"LIME Error for index 74: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "75",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 75")
else:
    print(f"LIME Error for index 75: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "76",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 76")
else:
    print(f"LIME Error for index 76: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "77",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 77")
else:
    print(f"LIME Error for index 77: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "78",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 78")
else:
    print(f"LIME Error for index 78: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "79",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 79")
else:
    print(f"LIME Error for index 79: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "80",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 80")
else:
    print(f"LIME Error for index 80: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "81",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 81")
else:
    print(f"LIME Error for index 81: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "82",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 82")
else:
    print(f"LIME Error for index 82: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "83",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 83")
else:
    print(f"LIME Error for index 83: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "84",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 84")
else:
    print(f"LIME Error for index 84: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "85",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 85")
else:
    print(f"LIME Error for index 85: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "86",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 86")
else:
    print(f"LIME Error for index 86: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "87",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 87")
else:
    print(f"LIME Error for index 87: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "88",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 88")
else:
    print(f"LIME Error for index 88: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "89",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 89")
else:
    print(f"LIME Error for index 89: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "90",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 90")
else:
    print(f"LIME Error for index 90: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "91",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 91")
else:
    print(f"LIME Error for index 91: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "92",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 92")
else:
    print(f"LIME Error for index 92: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "93",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 93")
else:
    print(f"LIME Error for index 93: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "94",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 94")
else:
    print(f"LIME Error for index 94: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "95",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 95")
else:
    print(f"LIME Error for index 95: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "96",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 96")
else:
    print(f"LIME Error for index 96: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "97",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 97")
else:
    print(f"LIME Error for index 97: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "98",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 98")
else:
    print(f"LIME Error for index 98: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "99",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 99")
else:
    print(f"LIME Error for index 99: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "0",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 0")
else:
    print(f"LIME Error for index 0: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "1",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 1")
else:
    print(f"LIME Error for index 1: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "2",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 2")
else:
    print(f"LIME Error for index 2: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "3",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 3")
else:
    print(f"LIME Error for index 3: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "4",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 4")
else:
    print(f"LIME Error for index 4: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "5",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 5")
else:
    print(f"LIME Error for index 5: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "6",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 6")
else:
    print(f"LIME Error for index 6: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "7",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 7")
else:
    print(f"LIME Error for index 7: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "8",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 8")
else:
    print(f"LIME Error for index 8: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "9",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 9")
else:
    print(f"LIME Error for index 9: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "10",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 10")
else:
    print(f"LIME Error for index 10: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "11",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 11")
else:
    print(f"LIME Error for index 11: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "12",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 12")
else:
    print(f"LIME Error for index 12: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "13",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 13")
else:
    print(f"LIME Error for index 13: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "14",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 14")
else:
    print(f"LIME Error for index 14: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "15",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 15")
else:
    print(f"LIME Error for index 15: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "16",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 16")
else:
    print(f"LIME Error for index 16: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "17",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 17")
else:
    print(f"LIME Error for index 17: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "18",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 18")
else:
    print(f"LIME Error for index 18: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "19",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 19")
else:
    print(f"LIME Error for index 19: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "20",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 20")
else:
    print(f"LIME Error for index 20: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "21",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 21")
else:
    print(f"LIME Error for index 21: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "22",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 22")
else:
    print(f"LIME Error for index 22: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "23",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 23")
else:
    print(f"LIME Error for index 23: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "24",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 24")
else:
    print(f"LIME Error for index 24: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "25",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 25")
else:
    print(f"LIME Error for index 25: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "26",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 26")
else:
    print(f"LIME Error for index 26: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "27",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 27")
else:
    print(f"LIME Error for index 27: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "28",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 28")
else:
    print(f"LIME Error for index 28: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "29",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 29")
else:
    print(f"LIME Error for index 29: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "30",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 30")
else:
    print(f"LIME Error for index 30: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "31",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 31")
else:
    print(f"LIME Error for index 31: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "32",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 32")
else:
    print(f"LIME Error for index 32: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "33",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 33")
else:
    print(f"LIME Error for index 33: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "34",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 34")
else:
    print(f"LIME Error for index 34: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "35",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 35")
else:
    print(f"LIME Error for index 35: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "36",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 36")
else:
    print(f"LIME Error for index 36: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "37",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 37")
else:
    print(f"LIME Error for index 37: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "38",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 38")
else:
    print(f"LIME Error for index 38: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "39",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 39")
else:
    print(f"LIME Error for index 39: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "40",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 40")
else:
    print(f"LIME Error for index 40: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "41",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 41")
else:
    print(f"LIME Error for index 41: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "42",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 42")
else:
    print(f"LIME Error for index 42: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "43",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 43")
else:
    print(f"LIME Error for index 43: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "44",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 44")
else:
    print(f"LIME Error for index 44: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "45",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 45")
else:
    print(f"LIME Error for index 45: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "46",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 46")
else:
    print(f"LIME Error for index 46: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "47",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 47")
else:
    print(f"LIME Error for index 47: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "48",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 48")
else:
    print(f"LIME Error for index 48: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "49",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 49")
else:
    print(f"LIME Error for index 49: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "50",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 50")
else:
    print(f"LIME Error for index 50: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "51",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 51")
else:
    print(f"LIME Error for index 51: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "52",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 52")
else:
    print(f"LIME Error for index 52: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "53",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 53")
else:
    print(f"LIME Error for index 53: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "54",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 54")
else:
    print(f"LIME Error for index 54: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "55",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 55")
else:
    print(f"LIME Error for index 55: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "56",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 56")
else:
    print(f"LIME Error for index 56: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "57",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 57")
else:
    print(f"LIME Error for index 57: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "58",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 58")
else:
    print(f"LIME Error for index 58: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "59",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 59")
else:
    print(f"LIME Error for index 59: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "60",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 60")
else:
    print(f"LIME Error for index 60: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "61",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 61")
else:
    print(f"LIME Error for index 61: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "62",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 62")
else:
    print(f"LIME Error for index 62: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "63",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 63")
else:
    print(f"LIME Error for index 63: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "64",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 64")
else:
    print(f"LIME Error for index 64: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "65",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 65")
else:
    print(f"LIME Error for index 65: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "66",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 66")
else:
    print(f"LIME Error for index 66: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "67",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 67")
else:
    print(f"LIME Error for index 67: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "68",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 68")
else:
    print(f"LIME Error for index 68: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "69",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 69")
else:
    print(f"LIME Error for index 69: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "70",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 70")
else:
    print(f"LIME Error for index 70: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "71",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 71")
else:
    print(f"LIME Error for index 71: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "72",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 72")
else:
    print(f"LIME Error for index 72: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "73",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 73")
else:
    print(f"LIME Error for index 73: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "74",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 74")
else:
    print(f"LIME Error for index 74: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "75",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 75")
else:
    print(f"LIME Error for index 75: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "76",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 76")
else:
    print(f"LIME Error for index 76: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "77",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 77")
else:
    print(f"LIME Error for index 77: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "78",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 78")
else:
    print(f"LIME Error for index 78: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "79",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 79")
else:
    print(f"LIME Error for index 79: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "80",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 80")
else:
    print(f"LIME Error for index 80: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "81",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 81")
else:
    print(f"LIME Error for index 81: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "82",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 82")
else:
    print(f"LIME Error for index 82: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "83",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 83")
else:
    print(f"LIME Error for index 83: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "84",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 84")
else:
    print(f"LIME Error for index 84: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "85",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 85")
else:
    print(f"LIME Error for index 85: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "86",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 86")
else:
    print(f"LIME Error for index 86: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "87",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 87")
else:
    print(f"LIME Error for index 87: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "88",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 88")
else:
    print(f"LIME Error for index 88: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "89",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 89")
else:
    print(f"LIME Error for index 89: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "90",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 90")
else:
    print(f"LIME Error for index 90: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "91",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 91")
else:
    print(f"LIME Error for index 91: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "92",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 92")
else:
    print(f"LIME Error for index 92: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "93",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 93")
else:
    print(f"LIME Error for index 93: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "94",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 94")
else:
    print(f"LIME Error for index 94: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "95",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 95")
else:
    print(f"LIME Error for index 95: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "96",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 96")
else:
    print(f"LIME Error for index 96: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "97",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 97")
else:
    print(f"LIME Error for index 97: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "98",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 98")
else:
    print(f"LIME Error for index 98: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "99",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 99")
else:
    print(f"LIME Error for index 99: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "0",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 0")
else:
    print(f"LIME Error for index 0: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "1",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 1")
else:
    print(f"LIME Error for index 1: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "2",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 2")
else:
    print(f"LIME Error for index 2: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "3",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 3")
else:
    print(f"LIME Error for index 3: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "4",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 4")
else:
    print(f"LIME Error for index 4: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "5",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 5")
else:
    print(f"LIME Error for index 5: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "6",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 6")
else:
    print(f"LIME Error for index 6: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "7",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 7")
else:
    print(f"LIME Error for index 7: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "8",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 8")
else:
    print(f"LIME Error for index 8: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "9",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 9")
else:
    print(f"LIME Error for index 9: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "10",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 10")
else:
    print(f"LIME Error for index 10: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "11",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 11")
else:
    print(f"LIME Error for index 11: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "12",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 12")
else:
    print(f"LIME Error for index 12: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "13",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 13")
else:
    print(f"LIME Error for index 13: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "14",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 14")
else:
    print(f"LIME Error for index 14: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "15",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 15")
else:
    print(f"LIME Error for index 15: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "16",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 16")
else:
    print(f"LIME Error for index 16: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "17",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 17")
else:
    print(f"LIME Error for index 17: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "18",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 18")
else:
    print(f"LIME Error for index 18: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "19",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 19")
else:
    print(f"LIME Error for index 19: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "20",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 20")
else:
    print(f"LIME Error for index 20: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "21",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 21")
else:
    print(f"LIME Error for index 21: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "22",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 22")
else:
    print(f"LIME Error for index 22: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "23",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 23")
else:
    print(f"LIME Error for index 23: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "24",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 24")
else:
    print(f"LIME Error for index 24: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "25",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 25")
else:
    print(f"LIME Error for index 25: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "26",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 26")
else:
    print(f"LIME Error for index 26: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "27",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 27")
else:
    print(f"LIME Error for index 27: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "28",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 28")
else:
    print(f"LIME Error for index 28: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "29",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 29")
else:
    print(f"LIME Error for index 29: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "30",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 30")
else:
    print(f"LIME Error for index 30: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "31",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 31")
else:
    print(f"LIME Error for index 31: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "32",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 32")
else:
    print(f"LIME Error for index 32: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "33",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 33")
else:
    print(f"LIME Error for index 33: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "34",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 34")
else:
    print(f"LIME Error for index 34: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "35",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 35")
else:
    print(f"LIME Error for index 35: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "36",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 36")
else:
    print(f"LIME Error for index 36: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "37",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 37")
else:
    print(f"LIME Error for index 37: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "38",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 38")
else:
    print(f"LIME Error for index 38: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "39",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 39")
else:
    print(f"LIME Error for index 39: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "40",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 40")
else:
    print(f"LIME Error for index 40: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "41",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 41")
else:
    print(f"LIME Error for index 41: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "42",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 42")
else:
    print(f"LIME Error for index 42: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "43",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 43")
else:
    print(f"LIME Error for index 43: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "44",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 44")
else:
    print(f"LIME Error for index 44: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "45",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 45")
else:
    print(f"LIME Error for index 45: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "46",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 46")
else:
    print(f"LIME Error for index 46: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "47",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 47")
else:
    print(f"LIME Error for index 47: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "48",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 48")
else:
    print(f"LIME Error for index 48: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "49",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 49")
else:
    print(f"LIME Error for index 49: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "50",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 50")
else:
    print(f"LIME Error for index 50: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "51",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 51")
else:
    print(f"LIME Error for index 51: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "52",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 52")
else:
    print(f"LIME Error for index 52: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "53",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 53")
else:
    print(f"LIME Error for index 53: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "54",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 54")
else:
    print(f"LIME Error for index 54: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "55",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 55")
else:
    print(f"LIME Error for index 55: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "56",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 56")
else:
    print(f"LIME Error for index 56: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "57",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 57")
else:
    print(f"LIME Error for index 57: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "58",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 58")
else:
    print(f"LIME Error for index 58: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "59",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 59")
else:
    print(f"LIME Error for index 59: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "60",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 60")
else:
    print(f"LIME Error for index 60: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "61",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 61")
else:
    print(f"LIME Error for index 61: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "62",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 62")
else:
    print(f"LIME Error for index 62: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "63",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 63")
else:
    print(f"LIME Error for index 63: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "64",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 64")
else:
    print(f"LIME Error for index 64: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "65",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 65")
else:
    print(f"LIME Error for index 65: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "66",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 66")
else:
    print(f"LIME Error for index 66: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "67",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 67")
else:
    print(f"LIME Error for index 67: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "68",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 68")
else:
    print(f"LIME Error for index 68: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "69",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 69")
else:
    print(f"LIME Error for index 69: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "70",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 70")
else:
    print(f"LIME Error for index 70: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "71",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 71")
else:
    print(f"LIME Error for index 71: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "72",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 72")
else:
    print(f"LIME Error for index 72: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "73",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 73")
else:
    print(f"LIME Error for index 73: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "74",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 74")
else:
    print(f"LIME Error for index 74: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "75",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 75")
else:
    print(f"LIME Error for index 75: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "76",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 76")
else:
    print(f"LIME Error for index 76: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "77",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 77")
else:
    print(f"LIME Error for index 77: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "78",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 78")
else:
    print(f"LIME Error for index 78: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "79",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 79")
else:
    print(f"LIME Error for index 79: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "80",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 80")
else:
    print(f"LIME Error for index 80: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "81",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 81")
else:
    print(f"LIME Error for index 81: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "82",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 82")
else:
    print(f"LIME Error for index 82: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "83",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 83")
else:
    print(f"LIME Error for index 83: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "84",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 84")
else:
    print(f"LIME Error for index 84: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "85",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 85")
else:
    print(f"LIME Error for index 85: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "86",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 86")
else:
    print(f"LIME Error for index 86: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "87",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 87")
else:
    print(f"LIME Error for index 87: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "88",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 88")
else:
    print(f"LIME Error for index 88: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "89",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 89")
else:
    print(f"LIME Error for index 89: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "90",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 90")
else:
    print(f"LIME Error for index 90: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "91",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 91")
else:
    print(f"LIME Error for index 91: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "92",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 92")
else:
    print(f"LIME Error for index 92: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "93",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 93")
else:
    print(f"LIME Error for index 93: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "94",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 94")
else:
    print(f"LIME Error for index 94: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "95",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 95")
else:
    print(f"LIME Error for index 95: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "96",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 96")
else:
    print(f"LIME Error for index 96: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "97",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 97")
else:
    print(f"LIME Error for index 97: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "98",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 98")
else:
    print(f"LIME Error for index 98: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "99",
    "--predictor", "stmhcpan",
    "--xai", "LIME",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.csv",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"LIME binding affinity done for index 99")
else:
    print(f"LIME Error for index 99: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "0",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 0")
else:
    print(f"SHAP Error for index 0: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "1",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 1")
else:
    print(f"SHAP Error for index 1: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "2",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 2")
else:
    print(f"SHAP Error for index 2: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "3",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 3")
else:
    print(f"SHAP Error for index 3: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "4",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 4")
else:
    print(f"SHAP Error for index 4: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "5",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 5")
else:
    print(f"SHAP Error for index 5: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "6",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 6")
else:
    print(f"SHAP Error for index 6: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "7",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 7")
else:
    print(f"SHAP Error for index 7: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "8",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 8")
else:
    print(f"SHAP Error for index 8: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "9",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 9")
else:
    print(f"SHAP Error for index 9: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "10",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 10")
else:
    print(f"SHAP Error for index 10: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "11",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 11")
else:
    print(f"SHAP Error for index 11: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "12",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 12")
else:
    print(f"SHAP Error for index 12: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "13",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 13")
else:
    print(f"SHAP Error for index 13: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "14",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 14")
else:
    print(f"SHAP Error for index 14: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "15",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 15")
else:
    print(f"SHAP Error for index 15: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "16",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 16")
else:
    print(f"SHAP Error for index 16: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "17",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 17")
else:
    print(f"SHAP Error for index 17: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "18",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 18")
else:
    print(f"SHAP Error for index 18: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "19",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 19")
else:
    print(f"SHAP Error for index 19: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "20",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 20")
else:
    print(f"SHAP Error for index 20: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "21",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 21")
else:
    print(f"SHAP Error for index 21: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "22",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 22")
else:
    print(f"SHAP Error for index 22: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "23",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 23")
else:
    print(f"SHAP Error for index 23: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "24",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 24")
else:
    print(f"SHAP Error for index 24: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "25",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 25")
else:
    print(f"SHAP Error for index 25: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "26",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 26")
else:
    print(f"SHAP Error for index 26: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "27",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 27")
else:
    print(f"SHAP Error for index 27: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "28",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 28")
else:
    print(f"SHAP Error for index 28: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "29",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 29")
else:
    print(f"SHAP Error for index 29: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "30",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 30")
else:
    print(f"SHAP Error for index 30: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "31",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 31")
else:
    print(f"SHAP Error for index 31: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "32",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 32")
else:
    print(f"SHAP Error for index 32: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "33",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 33")
else:
    print(f"SHAP Error for index 33: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "34",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 34")
else:
    print(f"SHAP Error for index 34: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "35",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 35")
else:
    print(f"SHAP Error for index 35: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "36",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 36")
else:
    print(f"SHAP Error for index 36: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "37",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 37")
else:
    print(f"SHAP Error for index 37: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "38",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 38")
else:
    print(f"SHAP Error for index 38: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "39",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 39")
else:
    print(f"SHAP Error for index 39: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "40",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 40")
else:
    print(f"SHAP Error for index 40: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "41",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 41")
else:
    print(f"SHAP Error for index 41: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "42",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 42")
else:
    print(f"SHAP Error for index 42: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "43",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 43")
else:
    print(f"SHAP Error for index 43: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "44",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 44")
else:
    print(f"SHAP Error for index 44: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "45",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 45")
else:
    print(f"SHAP Error for index 45: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "46",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 46")
else:
    print(f"SHAP Error for index 46: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "47",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 47")
else:
    print(f"SHAP Error for index 47: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "48",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 48")
else:
    print(f"SHAP Error for index 48: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "49",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 49")
else:
    print(f"SHAP Error for index 49: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "50",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 50")
else:
    print(f"SHAP Error for index 50: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "51",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 51")
else:
    print(f"SHAP Error for index 51: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "52",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 52")
else:
    print(f"SHAP Error for index 52: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "53",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 53")
else:
    print(f"SHAP Error for index 53: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "54",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 54")
else:
    print(f"SHAP Error for index 54: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "55",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 55")
else:
    print(f"SHAP Error for index 55: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "56",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 56")
else:
    print(f"SHAP Error for index 56: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "57",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 57")
else:
    print(f"SHAP Error for index 57: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "58",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 58")
else:
    print(f"SHAP Error for index 58: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "59",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 59")
else:
    print(f"SHAP Error for index 59: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "60",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 60")
else:
    print(f"SHAP Error for index 60: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "61",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 61")
else:
    print(f"SHAP Error for index 61: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "62",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 62")
else:
    print(f"SHAP Error for index 62: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "63",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 63")
else:
    print(f"SHAP Error for index 63: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "64",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 64")
else:
    print(f"SHAP Error for index 64: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "65",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 65")
else:
    print(f"SHAP Error for index 65: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "66",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 66")
else:
    print(f"SHAP Error for index 66: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "67",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 67")
else:
    print(f"SHAP Error for index 67: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "68",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 68")
else:
    print(f"SHAP Error for index 68: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "69",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 69")
else:
    print(f"SHAP Error for index 69: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "70",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 70")
else:
    print(f"SHAP Error for index 70: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "71",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 71")
else:
    print(f"SHAP Error for index 71: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "72",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 72")
else:
    print(f"SHAP Error for index 72: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "73",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 73")
else:
    print(f"SHAP Error for index 73: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "74",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 74")
else:
    print(f"SHAP Error for index 74: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "75",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 75")
else:
    print(f"SHAP Error for index 75: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "76",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 76")
else:
    print(f"SHAP Error for index 76: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "77",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 77")
else:
    print(f"SHAP Error for index 77: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "78",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 78")
else:
    print(f"SHAP Error for index 78: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "79",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 79")
else:
    print(f"SHAP Error for index 79: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "80",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 80")
else:
    print(f"SHAP Error for index 80: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "81",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 81")
else:
    print(f"SHAP Error for index 81: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "82",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 82")
else:
    print(f"SHAP Error for index 82: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "83",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 83")
else:
    print(f"SHAP Error for index 83: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "84",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 84")
else:
    print(f"SHAP Error for index 84: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "85",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 85")
else:
    print(f"SHAP Error for index 85: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "86",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 86")
else:
    print(f"SHAP Error for index 86: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "87",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 87")
else:
    print(f"SHAP Error for index 87: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "88",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 88")
else:
    print(f"SHAP Error for index 88: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "89",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 89")
else:
    print(f"SHAP Error for index 89: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "90",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 90")
else:
    print(f"SHAP Error for index 90: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "91",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 91")
else:
    print(f"SHAP Error for index 91: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "92",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 92")
else:
    print(f"SHAP Error for index 92: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "93",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 93")
else:
    print(f"SHAP Error for index 93: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "94",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 94")
else:
    print(f"SHAP Error for index 94: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "95",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 95")
else:
    print(f"SHAP Error for index 95: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "96",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 96")
else:
    print(f"SHAP Error for index 96: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "97",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 97")
else:
    print(f"SHAP Error for index 97: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "98",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 98")
else:
    print(f"SHAP Error for index 98: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-A*02:01_9.csv",
    "--index", "99",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-A*02:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 99")
else:
    print(f"SHAP Error for index 99: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "0",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 0")
else:
    print(f"SHAP Error for index 0: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "1",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 1")
else:
    print(f"SHAP Error for index 1: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "2",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 2")
else:
    print(f"SHAP Error for index 2: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "3",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 3")
else:
    print(f"SHAP Error for index 3: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "4",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 4")
else:
    print(f"SHAP Error for index 4: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "5",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 5")
else:
    print(f"SHAP Error for index 5: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "6",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 6")
else:
    print(f"SHAP Error for index 6: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "7",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 7")
else:
    print(f"SHAP Error for index 7: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "8",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 8")
else:
    print(f"SHAP Error for index 8: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "9",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 9")
else:
    print(f"SHAP Error for index 9: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "10",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 10")
else:
    print(f"SHAP Error for index 10: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "11",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 11")
else:
    print(f"SHAP Error for index 11: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "12",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 12")
else:
    print(f"SHAP Error for index 12: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "13",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 13")
else:
    print(f"SHAP Error for index 13: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "14",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 14")
else:
    print(f"SHAP Error for index 14: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "15",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 15")
else:
    print(f"SHAP Error for index 15: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "16",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 16")
else:
    print(f"SHAP Error for index 16: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "17",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 17")
else:
    print(f"SHAP Error for index 17: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "18",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 18")
else:
    print(f"SHAP Error for index 18: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "19",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 19")
else:
    print(f"SHAP Error for index 19: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "20",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 20")
else:
    print(f"SHAP Error for index 20: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "21",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 21")
else:
    print(f"SHAP Error for index 21: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "22",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 22")
else:
    print(f"SHAP Error for index 22: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "23",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 23")
else:
    print(f"SHAP Error for index 23: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "24",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 24")
else:
    print(f"SHAP Error for index 24: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "25",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 25")
else:
    print(f"SHAP Error for index 25: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "26",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 26")
else:
    print(f"SHAP Error for index 26: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "27",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 27")
else:
    print(f"SHAP Error for index 27: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "28",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 28")
else:
    print(f"SHAP Error for index 28: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "29",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 29")
else:
    print(f"SHAP Error for index 29: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "30",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 30")
else:
    print(f"SHAP Error for index 30: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "31",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 31")
else:
    print(f"SHAP Error for index 31: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "32",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 32")
else:
    print(f"SHAP Error for index 32: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "33",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 33")
else:
    print(f"SHAP Error for index 33: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "34",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 34")
else:
    print(f"SHAP Error for index 34: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "35",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 35")
else:
    print(f"SHAP Error for index 35: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "36",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 36")
else:
    print(f"SHAP Error for index 36: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "37",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 37")
else:
    print(f"SHAP Error for index 37: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "38",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 38")
else:
    print(f"SHAP Error for index 38: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "39",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 39")
else:
    print(f"SHAP Error for index 39: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "40",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 40")
else:
    print(f"SHAP Error for index 40: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "41",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 41")
else:
    print(f"SHAP Error for index 41: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "42",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 42")
else:
    print(f"SHAP Error for index 42: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "43",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 43")
else:
    print(f"SHAP Error for index 43: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "44",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 44")
else:
    print(f"SHAP Error for index 44: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "45",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 45")
else:
    print(f"SHAP Error for index 45: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "46",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 46")
else:
    print(f"SHAP Error for index 46: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "47",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 47")
else:
    print(f"SHAP Error for index 47: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "48",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 48")
else:
    print(f"SHAP Error for index 48: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "49",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 49")
else:
    print(f"SHAP Error for index 49: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "50",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 50")
else:
    print(f"SHAP Error for index 50: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "51",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 51")
else:
    print(f"SHAP Error for index 51: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "52",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 52")
else:
    print(f"SHAP Error for index 52: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "53",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 53")
else:
    print(f"SHAP Error for index 53: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "54",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 54")
else:
    print(f"SHAP Error for index 54: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "55",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 55")
else:
    print(f"SHAP Error for index 55: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "56",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 56")
else:
    print(f"SHAP Error for index 56: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "57",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 57")
else:
    print(f"SHAP Error for index 57: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "58",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 58")
else:
    print(f"SHAP Error for index 58: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "59",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 59")
else:
    print(f"SHAP Error for index 59: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "60",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 60")
else:
    print(f"SHAP Error for index 60: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "61",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 61")
else:
    print(f"SHAP Error for index 61: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "62",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 62")
else:
    print(f"SHAP Error for index 62: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "63",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 63")
else:
    print(f"SHAP Error for index 63: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "64",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 64")
else:
    print(f"SHAP Error for index 64: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "65",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 65")
else:
    print(f"SHAP Error for index 65: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "66",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 66")
else:
    print(f"SHAP Error for index 66: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "67",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 67")
else:
    print(f"SHAP Error for index 67: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "68",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 68")
else:
    print(f"SHAP Error for index 68: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "69",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 69")
else:
    print(f"SHAP Error for index 69: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "70",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 70")
else:
    print(f"SHAP Error for index 70: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "71",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 71")
else:
    print(f"SHAP Error for index 71: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "72",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 72")
else:
    print(f"SHAP Error for index 72: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "73",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 73")
else:
    print(f"SHAP Error for index 73: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "74",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 74")
else:
    print(f"SHAP Error for index 74: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "75",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 75")
else:
    print(f"SHAP Error for index 75: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "76",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 76")
else:
    print(f"SHAP Error for index 76: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "77",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 77")
else:
    print(f"SHAP Error for index 77: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "78",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 78")
else:
    print(f"SHAP Error for index 78: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "79",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 79")
else:
    print(f"SHAP Error for index 79: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "80",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 80")
else:
    print(f"SHAP Error for index 80: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "81",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 81")
else:
    print(f"SHAP Error for index 81: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "82",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 82")
else:
    print(f"SHAP Error for index 82: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "83",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 83")
else:
    print(f"SHAP Error for index 83: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "84",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 84")
else:
    print(f"SHAP Error for index 84: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "85",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 85")
else:
    print(f"SHAP Error for index 85: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "86",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 86")
else:
    print(f"SHAP Error for index 86: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "87",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 87")
else:
    print(f"SHAP Error for index 87: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "88",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 88")
else:
    print(f"SHAP Error for index 88: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "89",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 89")
else:
    print(f"SHAP Error for index 89: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "90",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 90")
else:
    print(f"SHAP Error for index 90: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "91",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 91")
else:
    print(f"SHAP Error for index 91: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "92",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 92")
else:
    print(f"SHAP Error for index 92: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "93",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 93")
else:
    print(f"SHAP Error for index 93: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "94",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 94")
else:
    print(f"SHAP Error for index 94: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "95",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 95")
else:
    print(f"SHAP Error for index 95: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "96",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 96")
else:
    print(f"SHAP Error for index 96: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "97",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 97")
else:
    print(f"SHAP Error for index 97: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "98",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 98")
else:
    print(f"SHAP Error for index 98: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-B*15:02_9.csv",
    "--index", "99",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-B*15:02_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 99")
else:
    print(f"SHAP Error for index 99: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "0",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 0")
else:
    print(f"SHAP Error for index 0: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "1",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 1")
else:
    print(f"SHAP Error for index 1: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "2",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 2")
else:
    print(f"SHAP Error for index 2: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "3",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 3")
else:
    print(f"SHAP Error for index 3: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "4",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 4")
else:
    print(f"SHAP Error for index 4: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "5",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 5")
else:
    print(f"SHAP Error for index 5: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "6",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 6")
else:
    print(f"SHAP Error for index 6: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "7",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 7")
else:
    print(f"SHAP Error for index 7: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "8",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 8")
else:
    print(f"SHAP Error for index 8: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "9",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 9")
else:
    print(f"SHAP Error for index 9: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "10",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 10")
else:
    print(f"SHAP Error for index 10: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "11",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 11")
else:
    print(f"SHAP Error for index 11: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "12",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 12")
else:
    print(f"SHAP Error for index 12: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "13",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 13")
else:
    print(f"SHAP Error for index 13: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "14",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 14")
else:
    print(f"SHAP Error for index 14: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "15",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 15")
else:
    print(f"SHAP Error for index 15: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "16",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 16")
else:
    print(f"SHAP Error for index 16: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "17",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 17")
else:
    print(f"SHAP Error for index 17: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "18",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 18")
else:
    print(f"SHAP Error for index 18: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "19",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 19")
else:
    print(f"SHAP Error for index 19: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "20",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 20")
else:
    print(f"SHAP Error for index 20: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "21",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 21")
else:
    print(f"SHAP Error for index 21: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "22",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 22")
else:
    print(f"SHAP Error for index 22: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "23",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 23")
else:
    print(f"SHAP Error for index 23: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "24",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 24")
else:
    print(f"SHAP Error for index 24: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "25",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 25")
else:
    print(f"SHAP Error for index 25: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "26",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 26")
else:
    print(f"SHAP Error for index 26: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "27",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 27")
else:
    print(f"SHAP Error for index 27: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "28",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 28")
else:
    print(f"SHAP Error for index 28: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "29",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 29")
else:
    print(f"SHAP Error for index 29: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "30",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 30")
else:
    print(f"SHAP Error for index 30: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "31",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 31")
else:
    print(f"SHAP Error for index 31: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "32",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 32")
else:
    print(f"SHAP Error for index 32: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "33",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 33")
else:
    print(f"SHAP Error for index 33: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "34",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 34")
else:
    print(f"SHAP Error for index 34: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "35",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 35")
else:
    print(f"SHAP Error for index 35: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "36",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 36")
else:
    print(f"SHAP Error for index 36: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "37",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 37")
else:
    print(f"SHAP Error for index 37: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "38",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 38")
else:
    print(f"SHAP Error for index 38: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "39",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 39")
else:
    print(f"SHAP Error for index 39: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "40",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 40")
else:
    print(f"SHAP Error for index 40: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "41",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 41")
else:
    print(f"SHAP Error for index 41: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "42",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 42")
else:
    print(f"SHAP Error for index 42: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "43",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 43")
else:
    print(f"SHAP Error for index 43: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "44",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 44")
else:
    print(f"SHAP Error for index 44: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "45",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 45")
else:
    print(f"SHAP Error for index 45: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "46",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 46")
else:
    print(f"SHAP Error for index 46: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "47",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 47")
else:
    print(f"SHAP Error for index 47: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "48",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 48")
else:
    print(f"SHAP Error for index 48: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "49",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 49")
else:
    print(f"SHAP Error for index 49: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "50",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 50")
else:
    print(f"SHAP Error for index 50: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "51",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 51")
else:
    print(f"SHAP Error for index 51: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "52",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 52")
else:
    print(f"SHAP Error for index 52: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "53",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 53")
else:
    print(f"SHAP Error for index 53: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "54",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 54")
else:
    print(f"SHAP Error for index 54: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "55",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 55")
else:
    print(f"SHAP Error for index 55: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "56",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 56")
else:
    print(f"SHAP Error for index 56: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "57",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 57")
else:
    print(f"SHAP Error for index 57: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "58",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 58")
else:
    print(f"SHAP Error for index 58: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "59",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 59")
else:
    print(f"SHAP Error for index 59: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "60",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 60")
else:
    print(f"SHAP Error for index 60: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "61",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 61")
else:
    print(f"SHAP Error for index 61: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "62",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 62")
else:
    print(f"SHAP Error for index 62: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "63",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 63")
else:
    print(f"SHAP Error for index 63: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "64",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 64")
else:
    print(f"SHAP Error for index 64: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "65",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 65")
else:
    print(f"SHAP Error for index 65: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "66",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 66")
else:
    print(f"SHAP Error for index 66: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "67",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 67")
else:
    print(f"SHAP Error for index 67: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "68",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 68")
else:
    print(f"SHAP Error for index 68: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "69",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 69")
else:
    print(f"SHAP Error for index 69: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "70",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 70")
else:
    print(f"SHAP Error for index 70: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "71",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 71")
else:
    print(f"SHAP Error for index 71: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "72",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 72")
else:
    print(f"SHAP Error for index 72: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "73",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 73")
else:
    print(f"SHAP Error for index 73: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "74",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 74")
else:
    print(f"SHAP Error for index 74: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "75",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 75")
else:
    print(f"SHAP Error for index 75: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "76",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 76")
else:
    print(f"SHAP Error for index 76: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "77",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 77")
else:
    print(f"SHAP Error for index 77: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "78",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 78")
else:
    print(f"SHAP Error for index 78: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "79",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 79")
else:
    print(f"SHAP Error for index 79: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "80",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 80")
else:
    print(f"SHAP Error for index 80: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "81",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 81")
else:
    print(f"SHAP Error for index 81: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "82",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 82")
else:
    print(f"SHAP Error for index 82: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "83",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 83")
else:
    print(f"SHAP Error for index 83: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "84",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 84")
else:
    print(f"SHAP Error for index 84: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "85",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 85")
else:
    print(f"SHAP Error for index 85: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "86",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 86")
else:
    print(f"SHAP Error for index 86: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "87",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 87")
else:
    print(f"SHAP Error for index 87: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "88",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 88")
else:
    print(f"SHAP Error for index 88: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "89",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 89")
else:
    print(f"SHAP Error for index 89: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "90",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 90")
else:
    print(f"SHAP Error for index 90: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "91",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 91")
else:
    print(f"SHAP Error for index 91: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "92",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 92")
else:
    print(f"SHAP Error for index 92: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "93",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 93")
else:
    print(f"SHAP Error for index 93: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "94",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 94")
else:
    print(f"SHAP Error for index 94: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "95",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 95")
else:
    print(f"SHAP Error for index 95: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "96",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 96")
else:
    print(f"SHAP Error for index 96: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "97",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 97")
else:
    print(f"SHAP Error for index 97: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "98",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 98")
else:
    print(f"SHAP Error for index 98: {result.stderr}")


command = [
    "python", 
    "/home/wuguojia/biocode/mhc_benchmark/MHCXAI.py",
    "--input_list", "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/HLA-C*05:01_9.csv",
    "--index", "99",
    "--predictor", "stmhcpan",
    "--xai", "SHAP",
    "--mode", "None",
    "--trainf_path", "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_use/HLA-C*05:01_9.pkl",
    "--dest", "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan"
]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
if result.returncode == 0:
    print(f"SHAP binding affinity done for index 99")
else:
    print(f"SHAP Error for index 99: {result.stderr}")

