#in shaplime, we install SHAP==0.41.0 Lime==0.2.0.1 Scikit_learn==1.3.2 Numpy==1.24.3 
#reference:https://static-content.springer.com/esm/art%3A10.1038%2Fs42003-024-05968-2/MediaObjects/42003_2024_5968_MOESM4_ESM.pdf
import numpy as np
np.int = int  # 临时修复 NumPy 的弃用问题,不然shap可用不了
import pandas as pd
import lime
import lime.lime_tabular
import shap
import sklearn
from sklearn.utils import check_random_state
import pickle
import argparse
import subprocess
import sys

class MHCXAI:
    def __init__(self):
        self.AA = ['0=A','1=R','2=N','3=D','4=C','5=E','6=Q','7=G','8=H','9=I','10=L','11=K','12=M','13=F','14=P','15=S','16=T','17=W','18=Y','19=V','20=B','21=J','22=O','23=U','24=X','25=Z']
        
    def AA_to_num(self,peptide):
        values = dict([(x.split('=')[1], x.split('=')[0]) for x in self.AA])
        peptide = np.array(list(map(lambda x: values[x], peptide)))
        return peptide

    def num_to_AA(self,peptide):
        values = dict([(int(x.split('=')[0]), x.split('=')[1]) for x in self.AA])
        peptide = list(map(lambda x: values[x], peptide))
        str_peptide = ''
        for aa in peptide:
            str_peptide+=aa
        return str_peptide

    def transform_train(self,train_file):
        df = pd.read_csv(train_file)
        peptides = df['antigen_peptide'].tolist()
        train = np.array([self.AA_to_num(peptide) for peptide in peptides], dtype='<U20')
        return train.astype(float)

    def transform_peptide(self,peptide):
        peptide = [aa for aa in peptide]
        return self.AA_to_num(peptide).astype(float)

#mhcflurry done! use shaplime conda env.
    def mhcflurry_predict_class(self, peptides_arr):
        # Some predictors need change of path therefore import only if needed. 
        from mhcflurry import Class1PresentationPredictor

        peptides_arr = [self.num_to_AA(instance) for instance in peptides_arr]
        predictor = Class1PresentationPredictor.load()
        df = predictor.predict(
            peptides=peptides_arr,
            alleles=[self.alleles],
            verbose=0)
        
        # MHCflurry allows presentation score and binding affinity as two outputs
        if self.mode=='affinity':
            label = 1 - np.log(df[self.mode])/np.log(50000)
        elif self.mode!=None:
            label = df[self.mode].to_numpy()
        else:
            print('ERROR: '+self.mode+' is not valid')

        if self.xai=='LIME':
            label_mat = np.zeros((len(label),2))
            label_mat[:,0] = 1-label
            label_mat[:,1] = label
            return label_mat

        elif self.xai=='SHAP':
            return label
        else:
            print('ERROR: '+self.xai+' is not valid')
#netmhcpan done! use shaplime conda env.           
    def netmhcpan_predict_class(self,peptides_arr):
        peptides_arr = [self.num_to_AA(instance) for instance in peptides_arr]
        if len(peptides_arr)==1:
            input_f = self.dest+self.peptide+"_temp_original_"+self.xai+".txt"
            f = open(input_f,"w")
            for p in peptides_arr:
                f.write(p+"\n")
            f.close()
        else:
            input_f = self.dest+self.peptide+"_mutations_original_"+self.xai+".txt"
            f = open(input_f,"w")
            for p in peptides_arr:
                f.write(p+"\n")
            f.close()    
        allele = self.alleles.replace("*", "")  # 去掉 * 的等位基因字符串，符合netmhcpan的输入
        len_pep = str(len(peptides_arr[0])) # 固定一下长度
        output_f = self.dest+self.peptide+"_NetMHCpan_out_"+self.xai+".xls"
        command = ["/data1/wuguojia/data/mhc_benchmark/tools/mhc_i/method/netmhcpan-4.1-executable/netmhcpan_4_1_executable/netMHCpan","-p", input_f,"-xls","-a", allele,'-xlsfile', output_f,"-BA","-l",len_pep,"-tdir",self.dest+"/netMHCpanXXXXXX"]
        result = subprocess.run(command,stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        output_pd = pd.read_csv(output_f,sep='\t',header = 1)
        
        label = output_pd[self.mode].to_numpy()
            
        label = np.array([1-(y*0.25) if y<=4 else 0 for y in label])

        if self.xai=='LIME':
            label_mat = np.zeros((len(label),2))
            label_mat[:,0] = 1-label
            label_mat[:,1] = label
            return label_mat

        elif self.xai=='SHAP':
            return label
        else:
            print('ERROR: '+self.xai+' is not valid')
#transphla done! use shaplime_trans conda env.
    #should turn to '/data1/wuguojia/data/mhc_benchmark/tools/TransPHLA-AOMP/TransPHLA-AOMP'path to run code
    def transphla_predict_class(self,peptides_arr):
        #load input info
        peptides_arr = [self.num_to_AA(instance) for instance in peptides_arr]#peptides input
        len_pep = str(len(peptides_arr[0]))#peptide length cut
        hla_seq_pd = pd.read_csv('./common_hla_sequence.csv')
        hla_seq = list(hla_seq_pd[hla_seq_pd['HLA']==self.alleles]['HLA_sequence'])[0]
        hla_seq = [hla_seq] * len(peptides_arr)#alleles input
        #save them as fasta file
        with open('peptides.fasta', 'w') as fasta_file:
            for i, peptide in enumerate(peptides_arr):
                fasta_file.write(f'>peptide_{i + 1}\n')  # title
                fasta_file.write(peptide)  # sequence
                if i < len(peptides_arr) - 1:  # 如果不是最后一行，则换行
                    fasta_file.write('\n')
        with open('hlas.fasta', 'w') as fasta_file:
            for i in range(len(peptides_arr)):
                fasta_file.write(f'>{hla_seq[0]}\n')  # title
                fasta_file.write(hla_seq[0])  # sequence
                if i < len(peptides_arr) - 1:  # 如果不是最后一行，则换行
                    fasta_file.write('\n')
        #run pHLAIformer code
        command = [
            "python", 
            "./pHLAIformer.py", 
            "--peptide_file", "peptides.fasta", 
            "--HLA_file", "hlas.fasta", 
            "--threshold", "0.5", 
            "--cut_length", str(len_pep),
            "--cut_peptide", "False", 
            "--output_dir", "./results/"]
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        output_pd = pd.read_csv("./results/predict_results.csv",sep=',',header = 0)
        label = output_pd['y_prob'].to_numpy()
        if self.xai=='LIME':
            label_mat = np.zeros((len(label),2))
            label_mat[:,0] = 1-label
            label_mat[:,1] = label
            return label_mat

        elif self.xai=='SHAP':
            return label
        else:
            print('ERROR: '+self.xai+' is not valid')
         
    def mhcfovea_predict_class(self, peptides_arr):
        # Some predictors need change of path therefore import only if needed. 
        sys.path.append("./MHCfovea/")
        sys.path.append("./MHCfovea/mhcfovea")
        from mhcfovea import predictor_mhcxai
        
        peptides_arr = [self.num_to_AA(instance) for instance in peptides_arr]
        df = pd.DataFrame.from_dict({"sequence":peptides_arr,"mhc":len(peptides_arr)*[self.alleles]})
        output_df = predictor_mhcxai.main(input_file = df, output_dir = self.dest+"/tmp/")

        label = output_df[self.alleles].to_numpy()
        if self.xai=='LIME':
            label_mat = np.zeros((len(label),2))
            label_mat[:,0] = 1-label
            label_mat[:,1] = label
            return label_mat

        elif self.xai=='SHAP':
            return label
        else:
            print('ERROR: '+self.xai+' is not valid')
#stmhcpan done! use shaplime_stm conda env.
    #should goto /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code to run code     
    #should change /data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py line 140 to /data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan_dump/output_file.csv, change line 144 to /data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan_dump/input_file.csv
    def stmhcpan_predict_class(self,peptides_arr):
        #load input info
        peptide = [self.num_to_AA(instance) for instance in peptides_arr]
        allele = [self.alleles] * len(peptides_arr)#alleles input
        #peptides input
        label = ['none'] * len(peptides_arr) #create label column
        length = str(len(peptides_arr[0]))#peptide length
        #save input info as csv file
        df = pd.DataFrame({
            'allele': allele,
            'peptide': peptide,
            'label': label,
            'length': [length] * len(peptides_arr)  # 长度列
        })
        df.to_csv('/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan_dump/input_file.csv', index=False)
        #run pHLAIformer code
        command = [
            "python", 
            "/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code/predict_ensemble.py"
            ]
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        output_pd = pd.read_csv("/data1/wuguojia/data/mhc_benchmark/attentionbase/result/stmhcpan_dump/output_file.csv",sep=',',header = 0)
        label = output_pd['presentation'].to_numpy()
        if self.xai=='LIME':
            label_mat = np.zeros((len(label),2))
            label_mat[:,0] = 1-label
            label_mat[:,1] = label
            return label_mat

        elif self.xai=='SHAP':
            return label
        else:
            print('ERROR: '+self.xai+' is not valid')
#bigmhc_el done! use shaplime_big conda env
    #should goto /data1/wuguojia/data/mhc_benchmark/tools/bigmhc/src/ path to run the code
    #should set /data1/wuguojia/data/mhc_benchmark/tools/bigmhc/src/predict.py #torch.set_num_threads(10)# 设置线程数，例如限制为 10 个线程 #torch.set_num_interop_threads(10)  # 控制并行任务间线程数 to avoid mistake, otherwise bigmhc could use over 80 cpu cores and will shut down quickly.
    def bigmhc_predict_class(self,peptides_arr):
        #load input info
        peptide = [self.num_to_AA(instance) for instance in peptides_arr]
        allele = [self.alleles] * len(peptides_arr)#alleles input
        #peptides input
        label = ['none'] * len(peptides_arr) #create label column
        #save input info as csv file
        df = pd.DataFrame({
            'mhc': allele,
            'pep': peptide,
            'tgt': label,
        })
        df.to_csv('/data1/wuguojia/data/mhc_benchmark/attentionbase/result/bigmhc_dump/input_file.csv', index=False)
        #run pHLAIformer code
        command = [
            "python", 
            "/data1/wuguojia/data/mhc_benchmark/tools/bigmhc/src/predict.py", 
            "-i=/data1/wuguojia/data/mhc_benchmark/attentionbase/result/bigmhc_dump/input_file.csv", 
            "-o=/data1/wuguojia/data/mhc_benchmark/attentionbase/result/bigmhc_dump/output_file.csv", 
            "-m=el", 
            "-d=cpu"
        ]
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        output_pd = pd.read_csv("/data1/wuguojia/data/mhc_benchmark/attentionbase/result/bigmhc_dump/output_file.csv",sep=',',header = 0)
        label = output_pd['BigMHC_EL'].to_numpy()
        if self.xai=='LIME':
            label_mat = np.zeros((len(label),2))
            label_mat[:,0] = 1-label
            label_mat[:,1] = label
            return label_mat

        elif self.xai=='SHAP':
            return label
        else:
            print('ERROR: '+self.xai+' is not valid')
#capsnetmhc_an done! use shaplime_cas conda env
    def capsnetmhcAN_predict_class(self,peptides_arr):
        #load input info
        peptide = [self.num_to_AA(instance) for instance in peptides_arr]
        allele = [self.alleles] * len(peptides_arr)#alleles input
        #peptides input
        label = ['none'] * len(peptides_arr) #create label column
        length = str(len(peptides_arr[0]))#peptide length
        #save input info as csv file
        df = pd.DataFrame({
            'HLA': allele,
            'peptide': peptide,
            'Label': label,
            'length': [length] * len(peptides_arr)  # 长度列
        })
        df.to_csv('/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/dataset/Anthem_dataset/test_data.txt', sep='\t',index=False)
        #run pHLAIformer code
        command = [
            "python", 
            "/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/codes/Anthem_codes/test.py",
            "/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/codes/Anthem_codes/Anthem_test/config.json"
            ]
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        output_pd = pd.read_csv("/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/codes/Anthem_codes/Anthem_test/weekly_result.txt",sep='\t',header = 0)
        label = output_pd['length'].to_numpy()  # i don't know why ,but this column in python output is affinity
        if self.xai=='LIME':
            label_mat = np.zeros((len(label),2))
            label_mat[:,0] = 1-label
            label_mat[:,1] = label
            return label_mat

        elif self.xai=='SHAP':
            return label
        else:
            print('ERROR: '+self.xai+' is not valid')

#num_samples=25000有点多了，根据https://static-content.springer.com/esm/art%3A10.1038%2Fs42003-024-05968-2/MediaObjects/42003_2024_5968_MOESM1_ESM.pdf做出的指导，SHAP在10000，LIME在7500就可以了。
    def LIMEtabular(self,peptide,alleles,train_file,predictor,dest,mode=None,num_samples=7500):
        self.peptide = peptide
        self.peptide_size = len(peptide)
        self.class_names = ["0", "1"]
        self.feature_names = ['Pos'+str(i+1) for i in range(self.peptide_size)]
        self.categorical_features = range(self.peptide_size)
        self.categorical_names = {}
        self.alleles = alleles
        self.xai = 'LIME'
        self.mode = mode
        self.dest = dest
        
        values = list([x.split('=')[1] for x in self.AA])
        for i in self.categorical_features:
            self.categorical_names[i] = values
        
        
        train = self.transform_train(train_file)
        peptide = self.transform_peptide(peptide)

        explainer = lime.lime_tabular.LimeTabularExplainer(train, class_names=self.class_names, feature_names = self.feature_names,mode="classification",
                                                   categorical_features=self.categorical_features, 
                                                   categorical_names=self.categorical_names, kernel_width=3, verbose=False, random_state=42)
        
        if predictor=='mhcflurry':
            exp = explainer.explain_instance(peptide, self.mhcflurry_predict_class, num_features=len(peptide), num_samples=num_samples)
        elif predictor=='netmhcpan':
            exp = explainer.explain_instance(peptide, self.netmhcpan_predict_class, num_features=len(peptide), num_samples=num_samples)
        elif predictor=='mhcfovea':
            exp = explainer.explain_instance(peptide, self.mhcfovea_predict_class, num_features=len(peptide), num_samples=num_samples)
        elif predictor=='transphla':
            exp = explainer.explain_instance(peptide, self.transphla_predict_class, num_features=len(peptide), num_samples=num_samples)
        elif predictor=='stmhcpan':
            exp = explainer.explain_instance(peptide, self.stmhcpan_predict_class, num_features=len(peptide), num_samples=num_samples)
        elif predictor=='bigmhc':
            exp = explainer.explain_instance(peptide, self.bigmhc_predict_class, num_features=len(peptide), num_samples=num_samples)
        elif predictor=='capsnetmhcAN':
            exp = explainer.explain_instance(peptide, self.capsnetmhcAN_predict_class, num_features=len(peptide), num_samples=num_samples)            
        return explainer, exp
        
    def SHAPtabular(self,peptide,alleles,trainf_path,predictor,dest,mode=None,num_samples=200): #10000/50=200，之前做过kmeans
        self.peptide = peptide
        self.peptide_size = len(peptide)
        self.class_names = ["0", "1"]
        self.feature_names = ['Pos'+str(i) for i in range(self.peptide_size)]
        self.categorical_features = range(self.peptide_size)
        self.categorical_names = {}
        self.alleles = alleles
        self.xai = 'SHAP'
        self.mode = mode
        self.dest = dest

        values = list([x.split('=')[1] for x in self.AA])
        for i in self.categorical_features:
            self.categorical_names[i] = values
            
        fileObj = open(trainf_path, 'rb')
        train_summary = pickle.load(fileObj)
        fileObj.close()
        #train_summary = self.transform_train(trainf_path)
        peptide = self.transform_peptide(peptide)
        
        if predictor=='mhcflurry':
            explainer = shap.KernelExplainer(self.mhcflurry_predict_class, train_summary)
            shap_values = explainer.shap_values(peptide, nsamples=num_samples)
        elif predictor=='netmhcpan':
            explainer = shap.KernelExplainer(self.netmhcpan_predict_class, train_summary)
            shap_values = explainer.shap_values(peptide, nsamples=num_samples)
        elif predictor=='mhcfovea':
            explainer = shap.KernelExplainer(self.mhcfovea_predict_class, train_summary)
            shap_values = explainer.shap_values(peptide, nsamples=num_samples)
        elif predictor=='transphla':
            explainer = shap.KernelExplainer(self.transphla_predict_class, train_summary)
            shap_values = explainer.shap_values(peptide, nsamples=num_samples)
        elif predictor=='stmhcpan':
            explainer = shap.KernelExplainer(self.stmhcpan_predict_class, train_summary)
            shap_values = explainer.shap_values(peptide, nsamples=num_samples)
        elif predictor=='bigmhc':
            explainer = shap.KernelExplainer(self.bigmhc_predict_class, train_summary)
            shap_values = explainer.shap_values(peptide, nsamples=num_samples)            
        elif predictor=='capsnetmhcAN':
            explainer = shap.KernelExplainer(self.capsnetmhcAN_predict_class, train_summary)
            shap_values = explainer.shap_values(peptide, nsamples=num_samples)             
        return explainer, shap_values

#parameters of function           
parser = argparse.ArgumentParser(description="usage help",
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("--input_list", help="input peptide list file")
parser.add_argument("--trainf_path", help="Training File path")
parser.add_argument("--predictor", help="MHC predictor")
parser.add_argument("--xai", help="LIME/SHAP")
parser.add_argument("--mode", help="Name of the column: binding affinity, presentation score, Rank, etc.")
parser.add_argument("--dest", help="Destination location")
parser.add_argument("--index", help="Index of peptide in input list")
args = parser.parse_args()
config = vars(args)
#variables
input_list = args.input_list
trainf_path = args.trainf_path
mode = args.mode
predictor = args.predictor
xai = args.xai
index = int(args.index)
dest = args.dest
peptide_arr = pd.read_csv(input_list,index_col=False).antigen_peptide.to_list()
peptide = peptide_arr[index]
allele_arr = pd.read_csv(input_list,index_col=False).hlatype.to_list()
allele = allele_arr[index]

#start generating results
mhcxai = MHCXAI()
if xai=="LIME":
    print("LIME")
    explainer, exp = mhcxai.LIMEtabular(peptide,allele,trainf_path,predictor,dest,mode=mode,num_samples=7500)
    col_num = len(peptide) + 3
    lime_arr = np.zeros(col_num)
    lime_arr[0] = exp.intercept[1] # Intercept
    for i in range(0,len(peptide)):  # Weights
        # idx = exp.as_list()[i][0][3] #这个人代码写的稀碎。举个例子：idx = exp.as_list()[0][0]结果为Pos10=Y，他只取第三个字符，那便是1，他妈的和Pos1重合了。怪不得老子怎么算都算不对，10以后都一个样，全是空的数据。让我帮他改改。
        import re #正则表达式
        idx_match = re.search(r'\d+', exp.as_list()[i][0])  # 匹配数字
        idx = idx_match.group()  # 提取出匹配到的数字
        lime_arr[int(idx)] = exp.as_list()[i][1] 
    lime_arr[-2] = exp.score # R^2
    lime_arr[-1] = exp.local_pred # LIME model prediction
    np.save(dest+"/"+xai+"_"+peptide+"_"+allele+"_"+predictor+"_"+mode+".npy",lime_arr)

elif xai=="SHAP":
    print("SHAP")
    explainer, shap_values = mhcxai.SHAPtabular(peptide,allele,trainf_path,predictor,dest,mode=mode,num_samples=200)
    np.save(dest+"/"+xai+"_"+peptide+"_"+allele+"_"+predictor+"_"+mode+".npy",shap_values)

else:
    print("Incorrect XAI :",xai)