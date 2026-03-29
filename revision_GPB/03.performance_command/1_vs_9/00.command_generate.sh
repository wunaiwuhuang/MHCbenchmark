#!/bin/bash
################################################################
    set -u
    # define fold
    fold="1_vs_9"

    # this part should load before analysis
    path_code="/home/wuguojia/biocode/mhc_benchmark/revision_GPB/03.performance_command/$fold"
    path_data="/data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_base/$fold"
    path_result="/data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_result/$fold"

    ################################    
    path_fasta="$path_data/fasta"
    filelist_mhci_fasta="$path_fasta/archive_mhci.txt"

    path_HLA_fasta="$path_data/HLA_fasta"
    filelist_mhci_HLA_fasta="$path_HLA_fasta/archive_mhci.txt"

    path_csv="$path_data/csv"
    filelist_mhci_csv="$path_csv/archive_mhci.txt"

    path_txt_casan="$path_data/txt_casan"
    filelist_mhci_txt_casan="$path_txt_casan/archive_mhci.txt"

    path_txt_casie="$path_data/txt_casie"
    filelist_mhci_txt_casie="$path_txt_casie/archive_mhci.txt"

    path_csv_stmhcpan="$path_data/csv_stmhcpan"
    filelist_mhci_csv_stmhcpan="$path_csv_stmhcpan/archive_mhci.txt"

    path_txt_acme="$path_data/txt_acme"
    filelist_mhci_txt_acme="$path_txt_acme/archive_mhci.txt"

    path_csv_deephlapan="$path_data/csv_deephlapan"
    filelist_mhci_csv_deephlapan="$path_csv_deephlapan/archive_mhci.txt"

    path_txt_deepnetbim="$path_data/txt_deepnetbim"
    filelist_mhci_txt_deepnetbim="$path_txt_deepnetbim/archive_mhci.txt"

    path_csv_bigmhc="$path_data/csv_bigmhc"
    filelist_mhci_csv_bigmhc="$path_csv_bigmhc/archive_mhci.txt"
################################################################

################################################################
################################ IEDBconsensus-2.18
    #https://downloads.iedb.org/tools/mhci/LATEST/README
    tool_consensus="/data1/wuguojia/data/mhc_benchmark/tools/mhc_i"
    result_consensus="$path_result/consensus"
    mkdir -p "$result_consensus"
    #run configure
    cd "$tool_consensus" || { echo "Failed to change directory to $tool_consensus"; exit 1; }
    ./configure || { echo "Configuration failed"; exit 1; }
    #produce command lines
    rm -f "$path_code/consensus_command.sh"
    cat > "$path_code/consensus_command.sh" << EOF
#!/bin/bash
cd $tool_consensus || { echo "Failed to cd to $tool_consensus"; exit 1; }
./configure || { echo "Configuration failed"; exit 1; }
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_consensus/src/predict_binding.py consensus \"$hla_part\" $number $file_path > $result_consensus/${hla_part}_$number.txt" >> "$path_code/consensus_command.sh"
    done < "$filelist_mhci_fasta"
    #add x right
    chmod +x "$path_code/consensus_command.sh"
################################ Netmhccons-1.1
    #https://downloads.iedb.org/tools/mhci/LATEST/README
    tool_netmhccons="/data1/wuguojia/data/mhc_benchmark/tools/mhc_i"
    result_netmhccons="$path_result/netmhccons"
    mkdir -p "$result_netmhccons"
    #run configure
    cd "$tool_netmhccons" || { echo "Failed to change directory to $tool_netmhccons"; exit 1; }
    ./configure || { echo "Configuration failed"; exit 1; }
    #produce command lines
    rm -f "$path_code/netmhccons_command.sh"
    cat > "$path_code/netmhccons_command.sh" << EOF
#!/bin/bash
cd $tool_netmhccons || { echo "Failed to cd to $tool_netmhccons"; exit 1; }
./configure || { echo "Configuration failed"; exit 1; }
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_netmhccons/src/predict_binding.py netmhccons \"$hla_part\" $number $file_path > $result_netmhccons/${hla_part}_$number.txt" >> "$path_code/netmhccons_command.sh"
    done < "$filelist_mhci_fasta"
    #add x right
    chmod +x "$path_code/netmhccons_command.sh"
################################ Netmhcstabpan-1.0
    #https://downloads.iedb.org/tools/mhci/LATEST/README
    tool_netmhcstabpan="/data1/wuguojia/data/mhc_benchmark/tools/mhc_i"
    result_netmhcstabpan="$path_result/netmhcstabpan"
    mkdir -p "$result_netmhcstabpan"
    #run configure
    cd "$tool_netmhcstabpan" || { echo "Failed to change directory to $tool_netmhcstabpan"; exit 1; }
    ./configure || { echo "Configuration failed"; exit 1; }
    #produce command lines
    rm -f "$path_code/netmhcstabpan_command.sh"
    cat > "$path_code/netmhcstabpan_command.sh" << EOF
#!/bin/bash
cd $tool_netmhcstabpan || { echo "Failed to cd to $tool_netmhcstabpan"; exit 1; }
./configure || { echo "Configuration failed"; exit 1; }
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_netmhcstabpan/src/predict_binding.py netmhcstabpan \"$hla_part\" $number $file_path > $result_netmhcstabpan/${hla_part}_$number.txt" >> "$path_code/netmhcstabpan_command.sh"
    done < "$filelist_mhci_fasta"
    #add x right
    chmod +x "$path_code/netmhcstabpan_command.sh"
################################ netmhcpan_ba-4.1
    #https://downloads.iedb.org/tools/mhci/LATEST/README
    tool_netmhcpan_ba="/data1/wuguojia/data/mhc_benchmark/tools/mhc_i"
    result_netmhcpan_ba="$path_result/netmhcpan_ba"
    mkdir -p "$result_netmhcpan_ba"
    #run configure
    cd "$tool_netmhcpan_ba" || { echo "Failed to change directory to $tool_netmhcpan_ba"; exit 1; }
    ./configure || { echo "Configuration failed"; exit 1; }
    #produce command lines
    rm -f "$path_code/netmhcpan_ba_command.sh"
    cat > "$path_code/netmhcpan_ba_command.sh" << EOF
#!/bin/bash
cd $tool_netmhcpan_ba || { echo "Failed to cd to $tool_netmhcpan_ba"; exit 1; }
./configure || { echo "Configuration failed"; exit 1; }
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_netmhcpan_ba/src/predict_binding.py netmhcpan_ba \"$hla_part\" $number $file_path > $result_netmhcpan_ba/${hla_part}_$number.txt" >> "$path_code/netmhcpan_ba_command.sh"
    done < "$filelist_mhci_fasta"
    #add x right
    chmod +x "$path_code/netmhcpan_ba_command.sh"
################################ netmhcpan_el-4.1
    #https://downloads.iedb.org/tools/mhci/LATEST/README
    tool_netmhcpan_el="/data1/wuguojia/data/mhc_benchmark/tools/mhc_i"
    result_netmhcpan_el="$path_result/netmhcpan_el"
    mkdir -p "$result_netmhcpan_el"
    #run configure
    cd "$tool_netmhcpan_el" || { echo "Failed to change directory to $tool_netmhcpan_el"; exit 1; }
    ./configure || { echo "Configuration failed"; exit 1; }
    #produce command lines
    rm -f "$path_code/netmhcpan_el_command.sh"
    cat > "$path_code/netmhcpan_el_command.sh" << EOF
#!/bin/bash
cd $tool_netmhcpan_el || { echo "Failed to cd to $tool_netmhcpan_el"; exit 1; }
./configure || { echo "Configuration failed"; exit 1; }
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_netmhcpan_el/src/predict_binding.py netmhcpan_el \"$hla_part\" $number $file_path > $result_netmhcpan_el/${hla_part}_$number.txt" >> "$path_code/netmhcpan_el_command.sh"
    done < "$filelist_mhci_fasta"
    #add x right
    chmod +x "$path_code/netmhcpan_el_command.sh"
################################ MHCflurry 2.0
    #https://openvax.github.io/mhcflurry/index.html
    #should activate mhcflurry-env environment
    conda activate mhcflurry-env
    result_mhcflurry="$path_result/mhcflurry"
    mkdir -p "$result_mhcflurry"
    #produce command lines
    rm -f "$path_code/mhcflurry_command.sh"
    cat > "$path_code/mhcflurry_command.sh" << EOF
#!/bin/bash
source /data1/wuguojia/software/miniconda/etc/profile.d/conda.sh
conda activate mhcflurry-env
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.csv}" #remove appendix
        echo "mhcflurry-predict $file_path --out $result_mhcflurry/${hla_part}_$number.csv" >> "$path_code/mhcflurry_command.sh"
    done < "$filelist_mhci_csv"
    #add x right
    chmod +x "$path_code/mhcflurry_command.sh"
################################ MixMHCpred3.0
    #https://github.com/GfellerLab/MixMHCpred
    tool_mixmhcpred="/data1/wuguojia/data/mhc_benchmark/tools/MixMHCpred"
    result_mixmhcpred="$path_result/mixmhcpred"
    mkdir -p "$result_mixmhcpred"
    #produce command lines
    rm -f "$path_code/mixmhcpred_command.sh"
    cat > "$path_code/mixmhcpred_command.sh" << EOF
#!/bin/bash
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_mixmhcpred/MixMHCpred" -i $file_path -o "$result_mixmhcpred/${hla_part}_$number.txt" -a $hla_part >> "$path_code/mixmhcpred_command.sh"
    done < "$filelist_mhci_fasta"
    #add x right
    chmod +x "$path_code/mixmhcpred_command.sh"
################################ CapsNet-MHC anthem model
    #https://github.com/s7776d/CapsNet-MHC
    #should change source code, gup to cpu
    tool_casan="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/codes/Anthem_codes"
    tool_test_casan="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/dataset/Anthem_dataset"
    tool_result_casan="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/codes/Anthem_codes/Anthem_test"
    result_casan="$path_result/capsnetmhc_an"
    mkdir -p "$result_casan"
    rm -f "$path_code/capsnetmhc_an_command.sh"
    cat > "$path_code/capsnetmhc_an_command.sh" << EOF
#!/bin/bash
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "rm -f $tool_test_casan/test_data.txt" >> "$path_code/capsnetmhc_an_command.sh"
        echo "rm -f $tool_result_casan/weekly_result.txt" >> "$path_code/capsnetmhc_an_command.sh"   
        echo "rm -f $tool_result_casan/log.txt" >> "$path_code/capsnetmhc_an_command.sh"             
        echo "cp $file_path $tool_test_casan/test_data.txt" >> "$path_code/capsnetmhc_an_command.sh"
        echo "python $tool_casan/test.py $tool_result_casan/config.json" >> "$path_code/capsnetmhc_an_command.sh"
        echo "cp $tool_result_casan/weekly_result.txt $result_casan/$file_name" >> "$path_code/capsnetmhc_an_command.sh"
    done < "$filelist_mhci_txt_casan"
    #add x right
    chmod +x "$path_code/capsnetmhc_an_command.sh"
################################ CapsNet-MHC iedb model
    #https://github.com/s7776d/CapsNet-MHC
    #should change source code, gup to cpu
    tool_casie="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/codes/IEDB_codes"
    tool_test_casie="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/dataset/IEDB_dataset"
    tool_result_casie="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/codes/IEDB_codes/IEDB_test"
    result_casie="$path_result/capsnetmhc_ie"
    mkdir -p "$result_casie"
    rm -f "$path_code/capsnetmhc_ie_command.sh"
    cat > "$path_code/capsnetmhc_ie_command.sh" << EOF
#!/bin/bash
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "rm -f $tool_test_casie/testing_set.txt" >> "$path_code/capsnetmhc_ie_command.sh"
        echo "rm -f $tool_result_casie/weekly_result.txt" >> "$path_code/capsnetmhc_ie_command.sh"   
        echo "rm -f $tool_result_casie/weekly_result_METRICS.txt" >> "$path_code/capsnetmhc_ie_command.sh"   
        echo "rm -f $tool_result_casie/log.txt" >> "$path_code/capsnetmhc_ie_command.sh"
        echo "cp $file_path $tool_test_casie/testing_set.txt" >> "$path_code/capsnetmhc_ie_command.sh"
        echo "python $tool_casie/test.py $tool_result_casie/config.json" >> "$path_code/capsnetmhc_ie_command.sh"
        echo "cp $tool_result_casie/weekly_result.txt $result_casie/$file_name" >> "$path_code/capsnetmhc_ie_command.sh"
    done < "$filelist_mhci_txt_casie"
    #add x right
    chmod +x "$path_code/capsnetmhc_ie_command.sh"
################################ STMHCpan
    #https://github.com/Luckysoutheast/STMHCPan
    #should activate STMHCpan environment
    #change source code from gpu to cpu
    conda activate STMHCpan
    tool_stmhcpan="/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code"
    code="$tool_stmhcpan/predict_ensemble.py"
    result_stmhcpan="$path_result/stmhcpan"
    mkdir -p "$result_stmhcpan"
    rm -f "$path_code/stmhcpan_command.sh"
    cd $tool_stmhcpan #must turn to this directory
    cat > "$path_code/stmhcpan_command.sh" << EOF
#!/bin/bash
source /data1/wuguojia/software/miniconda/etc/profile.d/conda.sh
conda activate STMHCpan
cd $tool_stmhcpan #must turn to this directory
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "sed -i \"140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('$result_stmhcpan/$file_name',index=False)|\" \"$code\"" >> "$path_code/stmhcpan_command.sh"
        echo "sed -i \"144s|df = pd.read_csv(.*)|df = pd.read_csv('$file_path')|\" \"$code\"" >> "$path_code/stmhcpan_command.sh"
        echo "python $code" >> "$path_code/stmhcpan_command.sh"
    done < "$filelist_mhci_csv_stmhcpan"
    #add x right
    chmod +x "$path_code/stmhcpan_command.sh"
################################ TransPHLA
    #https://github.com/a96123155/TransPHLA-AOMP
    #should activate transphla environment
    #set --output_attention/ --output_heatmap/ --output_mutation = FALSE
    conda activate transphla
    tool_transphla="/data1/wuguojia/data/mhc_benchmark/tools/TransPHLA-AOMP/TransPHLA-AOMP" 
    result_transphla="$path_result/transphla"
    mkdir -p "$result_transphla"
    rm -f "$path_code/transphla_command.sh"
    cd $tool_transphla #must turn to this directory
    cat > "$path_code/transphla_command.sh" << EOF
#!/bin/bash
source /data1/wuguojia/software/miniconda/etc/profile.d/conda.sh
conda activate transphla
cd $tool_transphla #must turn to this directory
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        #rm $tool_transphla/results/predict_results.csv
        file_name=$(basename "$file_path")
        name="${file_name%.fasta}" #remove appendix
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "cp $file_path $tool_transphla/peptides.fasta" >> "$path_code/transphla_command.sh"
        echo "cp $path_HLA_fasta/$file_name $tool_transphla/hlas.fasta" >> "$path_code/transphla_command.sh"
        echo "python $tool_transphla/pHLAIformer.py --peptide_file \"peptides.fasta\" --HLA_file \"hlas.fasta\" --threshold 0.5 --cut_length $number --cut_peptide False --output_dir $tool_transphla/results/" >> "$path_code/transphla_command.sh"
        echo "mv $tool_transphla/results/predict_results.csv $result_transphla/$name.csv" >> "$path_code/transphla_command.sh"
    done < "$filelist_mhci_fasta"
    #add x right
    chmod +x "$path_code/transphla_command.sh"
################################ DeepAttentionPan
    #https://github.com/jjin49/DeepAttentionPan
    #similar to CapsNet-MHC, just turn gpu to cpu
    tool_deepattentionpan="/data1/wuguojia/data/mhc_benchmark/tools/DeepAttentionPan/codes"
    tool_test_deepattentionpan="/data1/wuguojia/data/mhc_benchmark/tools/DeepAttentionPan/dataset"
    tool_result_deepattentionpan="/data1/wuguojia/data/mhc_benchmark/tools/DeepAttentionPan/codes/dup_0"
    result_deepattentionpan="$path_result/deepattentionpan"
    mkdir -p "$result_deepattentionpan"
    rm -f "$path_code/deepattentionpan_command.sh"
    cat > "$path_code/deepattentionpan_command.sh" << EOF
#!/bin/bash
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "rm -f $tool_test_deepattentionpan/testing_set.txt" >> "$path_code/deepattentionpan_command.sh"
        echo "rm -f $tool_result_deepattentionpan/weekly_result.txt" >> "$path_code/deepattentionpan_command.sh"   
        echo "rm -f $tool_result_deepattentionpan/weekly_result_METRICS.txt" >> "$path_code/deepattentionpan_command.sh"
        echo "rm -f $tool_result_deepattentionpan/log.txt" >> "$path_code/deepattentionpan_command.sh"
        echo "cp $file_path $tool_test_deepattentionpan/testing_set.txt" >> "$path_code/deepattentionpan_command.sh"
        echo "python $tool_deepattentionpan/test.py $tool_result_deepattentionpan/config.json" >> "$path_code/deepattentionpan_command.sh"
        echo "cp $tool_result_deepattentionpan/weekly_result.txt $result_deepattentionpan/$file_name" >> "$path_code/deepattentionpan_command.sh"
    done < "$filelist_mhci_txt_casie" #they use same files
    #add x right
    chmod +x "$path_code/deepattentionpan_command.sh"
################################ ACME
    #https://github.com/HYsxe/ACME
    #should activate acme environment
    #Tsinghua University is good, code and data are frank!!
    conda activate acme
    tool_acme="/data1/wuguojia/data/mhc_benchmark/tools/ACME/ACME_codes"
    tool_test_acme="$tool_acme/binding_prediction"
    tool_result_acme="$tool_acme/results"
    result_acme="$path_result/acme" 
    mkdir -p "$result_acme"
    rm -f "$path_code/acme_command.sh"
    cat > "$path_code/acme_command.sh" << EOF
#!/bin/bash
source /data1/wuguojia/software/miniconda/etc/profile.d/conda.sh
conda activate acme
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "rm -f $tool_test_acme/prediction_input.txt" >> "$path_code/acme_command.sh"
        echo "rm -f $tool_result_acme/binding_prediction.txt" >> "$path_code/acme_command.sh"
        echo "cp $file_path $tool_test_acme/prediction_input.txt" >> "$path_code/acme_command.sh"
        echo "python $tool_acme/binding_prediction.py" >> "$path_code/acme_command.sh"
        echo "cp $tool_result_acme/binding_prediction.txt $result_acme/$file_name" >> "$path_code/acme_command.sh"
    done < "$filelist_mhci_txt_acme" #they use same files
    #add x right
    chmod +x "$path_code/acme_command.sh"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/acme_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/acme.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ DeepHLApan
    #https://github.com/jiujiezz/deephlapan
    #though requirements.txt showed tensorflow should be 2.7 ,i found all dependencies are uncompatible and no suitable python version can meet their requirements. so i change tensorflow version to 1.14.0, it work!
    #the source code are written under python2, but i run them under python3. so i have to change all code style, like print -> print();from attention import xxx -> from .attention import xxx
    #should activate deephlapan3.6 environment
    conda activate deephlapan3.6
    result_deephlapan="$path_result/deephlapan"
    mkdir -p "$result_deephlapan"
    rm -f "$path_code/deephlapan_command.sh"
    cat > "$path_code/deephlapan_command.sh" << EOF
#!/bin/bash
source /data1/wuguojia/software/miniconda/etc/profile.d/conda.sh
conda activate deephlapan3.6
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        name="${file_name%.csv}" #remove appendix
        echo "deephlapan -F $file_path -O $result_deephlapan" >> "$path_code/deephlapan_command.sh" #run code
        echo "mv $result_deephlapan/${name}_predicted_result.csv $result_deephlapan/$file_name" >> "$path_code/deephlapan_command.sh"
        echo "rm $result_deephlapan/${name}_predicted_result_rank.csv" >> "$path_code/deephlapan_command.sh"
    done < "$filelist_mhci_csv_deephlapan"
    #add x right
    chmod +x "$path_code/deephlapan_command.sh"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/deephlapan_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/deephlapan.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ DeepNetBim
    #https://github.com/Li-Lab-SJTU/DeepNetBim
    #dependency: sklearn 1.16.4 -> scikit-learn==0.20.3 , install tensorflow==1.5.0 .
    #should edit /data1/wuguojia/software/miniconda/envs/deepnetbim/lib/python3.6/site-packages/keras/engine/saving.py ".decode('utf8')" words. due to error message provided by bash terminal
    #Attention! Deepnetbim only accept 9-aa peptides, so just need to calculate 9-mer files. filelist_mhci_txt_deepnetbim only contain 9-aa files
    #should activate deepnetbim environment
    conda activate deepnetbim
    tool_deepnetbim="/data1/wuguojia/data/mhc_benchmark/tools/DeepNetBim/src"
    tool_test_deepnetbim="/data1/wuguojia/data/mhc_benchmark/tools/DeepNetBim/data"
    tool_result_deepnetbim="/data1/wuguojia/data/mhc_benchmark/tools/DeepNetBim/data"
    result_deepnetbim="$path_result/deepnetbim"
    mkdir -p "$result_deepnetbim"
    rm -f "$path_code/deepnetbim_command.sh"
    cd $tool_deepnetbim #must turn to this directory
    cat > "$path_code/deepnetbim_command.sh" << EOF
#!/bin/bash
source /data1/wuguojia/software/miniconda/etc/profile.d/conda.sh
conda activate deepnetbim
cd $tool_deepnetbim #must turn to this directory
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "rm -f $tool_test_deepnetbim/sample.txt" >> "$path_code/deepnetbim_command.sh"
        echo "rm -f $tool_result_deepnetbim/result_prediction.txt" >> "$path_code/deepnetbim_command.sh"
        echo "cp $file_path $tool_test_deepnetbim/sample.txt" >> "$path_code/deepnetbim_command.sh"
        echo "python $tool_deepnetbim/predict.py $file_path" >> "$path_code/deepnetbim_command.sh"
        echo "cp $tool_result_deepnetbim/result_prediction.txt $result_deepnetbim/$file_name" >> "$path_code/deepnetbim_command.sh"
    done < "$filelist_mhci_txt_deepnetbim"
    #add x right
    chmod +x "$path_code/deepnetbim_command.sh"
################################ bigMHC_el
    #https://github.com/KarchinLab/bigmhc/tree/master
    #should activate bigmhc environment
    conda activate bigmhc
    tool_bigmhc="/data1/wuguojia/data/mhc_benchmark/tools/bigmhc/src"
    result_bigmhc="$path_result/bigmhc_el"
    mkdir -p "$result_bigmhc"
    rm -f "$path_code/bigmhc_command.sh"
    cd $tool_bigmhc #must turn to this directory
    cat > "$path_code/bigmhc_command.sh" << EOF
#!/bin/bash
source /data1/wuguojia/software/miniconda/etc/profile.d/conda.sh
conda activate bigmhc
cd $tool_bigmhc #must turn to this directory
#----------------------------------------------------------------
EOF
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "python $tool_bigmhc/predict.py -i=$file_path -o=$result_bigmhc/$file_name -m=el -d=\"cpu\"" >> "$path_code/bigmhc_command.sh"
    done < "$filelist_mhci_csv_bigmhc"
    #add x right
    chmod +x "$path_code/bigmhc_command.sh"
################################################################
