################################################################
#this part should load before analysis
    path_code="/home/wuguojia/biocode/mhc_benchmark/speed_command"
    path_result="/data1/wuguojia/data/mhc_benchmark/speedbase/result"
    ################################    
    path_fasta="/data1/wuguojia/data/mhc_benchmark/speedbase/fasta"
    filelist_mhci_fasta="$path_fasta/archive_mhci.txt"
    filelist_mhcii_fasta="$path_fasta/archive_mhcii.txt"
    path_HLA_fasta="/data1/wuguojia/data/mhc_benchmark/speedbase/HLA_fasta"
    filelist_mhci_HLA_fasta="$path_HLA_fasta/archive_mhci.txt"
    filelist_mhcii_HLA_fasta="$path_HLA_fasta/archive_mhcii.txt"
    path_csv="/data1/wuguojia/data/mhc_benchmark/speedbase/csv"
    filelist_mhci_csv="$path_csv/archive_mhci.txt"
    filelist_mhcii_csv="$path_csv/archive_mhcii.txt"
    path_txt_casan="/data1/wuguojia/data/mhc_benchmark/speedbase/txt_casan"
    filelist_mhci_txt_casan="$path_txt_casan/archive_mhci.txt"
    filelist_mhcii_txt_casan="$path_txt_casan/archive_mhcii.txt"
    path_txt_casie="/data1/wuguojia/data/mhc_benchmark/speedbase/txt_casie"
    filelist_mhci_txt_casie="$path_txt_casie/archive_mhci.txt"
    filelist_mhcii_txt_casie="$path_txt_casie/archive_mhcii.txt"
    path_csv_stmhcpan="/data1/wuguojia/data/mhc_benchmark/speedbase/csv_stmhcpan"
    filelist_mhci_csv_stmhcpan="$path_csv_stmhcpan/archive_mhci.txt"
    filelist_mhcii_csv_stmhcpan="$path_csv_stmhcpan/archive_mhcii.txt"
    path_txt_acme="/data1/wuguojia/data/mhc_benchmark/speedbase/txt_acme"
    filelist_mhci_txt_acme="$path_txt_acme/archive_mhci.txt"
    filelist_mhcii_txt_acme="$path_txt_acme/archive_mhcii.txt"
    path_csv_deephlapan="/data1/wuguojia/data/mhc_benchmark/speedbase/csv_deephlapan"
    filelist_mhci_csv_deephlapan="$path_csv_deephlapan/archive_mhci.txt"
    filelist_mhcii_csv_deephlapan="$path_csv_deephlapan/archive_mhcii.txt"
    path_txt_deepnetbim="/data1/wuguojia/data/mhc_benchmark/speedbase/txt_deepnetbim"
    filelist_mhci_txt_deepnetbim="$path_txt_deepnetbim/archive_mhci.txt"
    filelist_mhcii_txt_deepnetbim="$path_txt_deepnetbim/archive_mhcii.txt"
    path_csv_bigmhc="/data1/wuguojia/data/mhc_benchmark/speedbase/csv_bigmhc"
    filelist_mhci_csv_bigmhc="$path_csv_bigmhc/archive_mhci.txt"
    filelist_mhcii_csv_bigmhc="$path_csv_bigmhc/archive_mhcii.txt"
################################################################

################################################################
################################ IEDBconsensus-2.18
    #https://downloads.iedb.org/tools/mhci/LATEST/README
    tool_consensus="/data1/wuguojia/data/mhc_benchmark/tools/mhc_i"
    #run configure
    cd "$tool_consensus"
    ./configure
    #produce command lines
    rm "$path_code/consensus_command.sh"
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_consensus/src/predict_binding.py consensus \"$hla_part\" $number $file_path > $path_result/${hla_part}_$number.txt" >> "$path_code/consensus_command.sh"
    done < "$filelist_mhci_fasta"
    #give #!/bin/bash
    com_file="$path_code/consensus_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/consensus_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/consensus.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ Netmhccons-1.1
    #https://downloads.iedb.org/tools/mhci/LATEST/README
    tool_netmhccons="/data1/wuguojia/data/mhc_benchmark/tools/mhc_i"
    #run configure
    cd "$tool_netmhccons"
    ./configure
    #produce command lines
    rm "$path_code/netmhccons_command.sh"
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_netmhccons/src/predict_binding.py netmhccons \"$hla_part\" $number $file_path > $path_result/${hla_part}_$number.txt" >> "$path_code/netmhccons_command.sh"
    done < "$filelist_mhci_fasta"
    #give #!/bin/bash
    com_file="$path_code/netmhccons_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/netmhccons_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/netmhccons.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ Netmhcstabpan-1.0
    #https://downloads.iedb.org/tools/mhci/LATEST/README
    tool_netmhcstabpan="/data1/wuguojia/data/mhc_benchmark/tools/mhc_i"
    #run configure
    cd "$tool_netmhcstabpan"
    ./configure
    #produce command lines
    rm "$path_code/netmhcstabpan_command.sh"
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_netmhcstabpan/src/predict_binding.py netmhcstabpan \"$hla_part\" $number $file_path > $path_result/${hla_part}_$number.txt" >> "$path_code/netmhcstabpan_command.sh"
    done < "$filelist_mhci_fasta"
    #give #!/bin/bash
    com_file="$path_code/netmhcstabpan_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/netmhcstabpan_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/netmhcstabpan.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ netmhcpan_ba-4.1
    #https://downloads.iedb.org/tools/mhci/LATEST/README
    tool_netmhcpan_ba="/data1/wuguojia/data/mhc_benchmark/tools/mhc_i"
    #run configure
    cd "$tool_netmhcpan_ba"
    ./configure
    #produce command lines
    rm "$path_code/netmhcpan_ba_command.sh"
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_netmhcpan_ba/src/predict_binding.py netmhcpan_ba \"$hla_part\" $number $file_path > $path_result/${hla_part}_$number.txt" >> "$path_code/netmhcpan_ba_command.sh"
    done < "$filelist_mhci_fasta"
    #give #!/bin/bash
    com_file="$path_code/netmhcpan_ba_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/netmhcpan_ba_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/netmhcpan_ba.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ netmhcpan_el-4.1
    #https://downloads.iedb.org/tools/mhci/LATEST/README
    tool_netmhcpan_el="/data1/wuguojia/data/mhc_benchmark/tools/mhc_i"
    #run configure
    cd "$tool_netmhcpan_el"
    ./configure
    #produce command lines
    rm "$path_code/netmhcpan_el_command.sh"
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_netmhcpan_el/src/predict_binding.py netmhcpan_el \"$hla_part\" $number $file_path > $path_result/${hla_part}_$number.txt" >> "$path_code/netmhcpan_el_command.sh"
    done < "$filelist_mhci_fasta"
    #give #!/bin/bash
    com_file="$path_code/netmhcpan_el_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/netmhcpan_el_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/netmhcpan_el.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ MHCflurry 2.0
    #https://openvax.github.io/mhcflurry/index.html
    #produce command lines
    rm "$path_code/mhcflurry_command.sh"
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.csv}" #remove appendix
        echo "mhcflurry-predict $file_path --out $path_result/${hla_part}_$number.csv" >> "$path_code/mhcflurry_command.sh"
    done < "$filelist_mhci_csv"
    #give #!/bin/bash
    com_file="$path_code/mhcflurry_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/mhcflurry_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/mhcflurry.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ MixMHCpred3.0
    #https://github.com/GfellerLab/MixMHCpred
    tool_mixmhcpred="/data1/wuguojia/data/mhc_benchmark/tools/MixMHCpred"
    #produce command lines
    rm "$path_code/mixmhcpred_command.sh"
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        hla_part="${file_name%%_*}"
        number_part="${file_name##*_}"
        number="${number_part%.fasta}" #remove appendix
        echo "$tool_mixmhcpred/MixMHCpred" -i $file_path -o "$path_result/${hla_part}_$number.txt" -a $hla_part >> "$path_code/mixmhcpred_command.sh"
    done < "$filelist_mhci_fasta"
    #give #!/bin/bash
    com_file="$path_code/mixmhcpred_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/mixmhcpred_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/mixmhcpred.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ CapsNet-MHC anthem model
    #https://github.com/s7776d/CapsNet-MHC
    #should change source code, gup to cpu
    tool_casan="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/codes/Anthem_codes"
    tool_test_casan="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/dataset/Anthem_dataset"
    tool_result_casan="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/codes/Anthem_codes/Anthem_test"
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "cp $file_path $tool_test_casan/test_data.txt" >> "$path_code/capsnetmhc_an_command.sh"
        echo "python $tool_casan/test.py $tool_result_casan/config.json" >> "$path_code/capsnetmhc_an_command.sh"
    done < "$filelist_mhci_txt_casan"
    #give #!/bin/bash
    com_file="$path_code/capsnetmhc_an_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/capsnetmhc_an_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/capsnetmhc_an.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ CapsNet-MHC iedb model
    #https://github.com/s7776d/CapsNet-MHC
    #should change source code, gup to cpu
    tool_casie="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/codes/IEDB_codes"
    tool_test_casie="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/dataset/IEDB_dataset"
    tool_result_casie="/data1/wuguojia/data/mhc_benchmark/tools/CapsNet-MHC/codes/IEDB_codes/IEDB_test"
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "cp $file_path $tool_test_casie/testing_set.txt" >> "$path_code/capsnetmhc_ie_command.sh"
        echo "python $tool_casie/test.py $tool_result_casie/config.json" >> "$path_code/capsnetmhc_ie_command.sh"
    done < "$filelist_mhci_txt_casie"
    #give #!/bin/bash
    com_file="$path_code/capsnetmhc_ie_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/capsnetmhc_ie_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/capsnetmhc_ie.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ STMHCpan
    #https://github.com/Luckysoutheast/STMHCPan
    #change source code from gpu to cpu
    conda activate STMHCpan
    tool_stmhcpan="/data1/wuguojia/data/mhc_benchmark/tools/STMHCPan/code"
    code="$tool_stmhcpan/predict_ensemble.py"
    cd $tool_stmhcpan
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "sed -i \"140s|df_candicated_all_hla.to_csv(.*)|df_candicated_all_hla.to_csv('$path_result/$file_name',index=False)|\" \"$code\"" >> "$path_code/stmhcpan_command.sh"
        echo "sed -i \"144s|df = pd.read_csv(.*)|df = pd.read_csv('$file_path')|\" \"$code\"" >> "$path_code/stmhcpan_command.sh"
        echo "python $code" >> "$path_code/stmhcpan_command.sh"
    done < "$filelist_mhci_csv_stmhcpan"
    #give #!/bin/bash
    com_file="$path_code/stmhcpan_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/stmhcpan_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/stmhcpan.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ TransPHLA
    #https://github.com/a96123155/TransPHLA-AOMP
    #set --output_attention/ --output_heatmap/ --output_mutation = FALSE
    conda activate transphla
    tool_transphla="/data1/wuguojia/data/mhc_benchmark/tools/TransPHLA-AOMP/TransPHLA-AOMP" 
    cd $tool_transphla #must turn to this directory
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
    done < "$filelist_mhci_fasta"
    #give #!/bin/bash
    com_file="$path_code/transphla_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/transphla_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/transphla.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ DeepAttentionPan
    #https://github.com/jjin49/DeepAttentionPan
    #similar to CapsNet-MHC, just turn gpu to cpu
    tool_deepattentionpan="/data1/wuguojia/data/mhc_benchmark/tools/DeepAttentionPan/codes"
    tool_test_deepattentionpan="/data1/wuguojia/data/mhc_benchmark/tools/DeepAttentionPan/dataset"
    tool_result_deepattentionpan="/data1/wuguojia/data/mhc_benchmark/tools/DeepAttentionPan/codes/dup_0"
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "cp $file_path $tool_test_deepattentionpan/testing_set.txt" >> "$path_code/deepattentionpan_command.sh"
        echo "python $tool_deepattentionpan/test.py $tool_result_deepattentionpan/config.json" >> "$path_code/deepattentionpan_command.sh"
    done < "$filelist_mhci_txt_casie" #they use same files
    #give #!/bin/bash
    com_file="$path_code/deepattentionpan_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/deepattentionpan_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/deepattentionpan.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ ACME
    #https://github.com/HYsxe/ACME
    #Tsinghua University is good, code and data are frank!!
    conda activate acme
    tool_acme="/data1/wuguojia/data/mhc_benchmark/tools/ACME/ACME_codes"
    tool_test_acme="$tool_acme/binding_prediction"
    tool_result_acme="$tool_acme/results"
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "cp $file_path $tool_test_acme/prediction_input.txt" >> "$path_code/acme_command.sh"
        echo "python $tool_acme/binding_prediction.py" >> "$path_code/acme_command.sh"
    done < "$filelist_mhci_txt_acme" #they use same files
    #give #!/bin/bash
    com_file="$path_code/acme_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/acme_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/acme.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ DeepHLApan
    #https://github.com/jiujiezz/deephlapan
    #though requirements.txt showed tensorflow should be 2.7 ,i found all dependencies are uncompatible and no suitable python version can meet their requirements. so i change tensorflow version to 1.14.0, it work!
    #the source code are written under python2, but i run them under python3. so i have to change all code style, like print -> print();from attention import xxx -> from .attention import xxx
    conda activate deephlapan3.6
    while IFS= read -r file_path; do
        echo "deephlapan -F $file_path -O $path_result" >> "$path_code/deephlapan_command.sh" #run code
    done < "$filelist_mhci_csv_deephlapan"
        #give #!/bin/bash
    com_file="$path_code/deephlapan_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/deephlapan_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/deephlapan.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ DeepNetBim
    #https://github.com/Li-Lab-SJTU/DeepNetBim
    #dependency: sklearn 1.16.4 -> scikit-learn==0.20.3 , install tensorflow==1.5.0 .
    #should edit /data1/wuguojia/software/miniconda/envs/deepnetbim/lib/python3.6/site-packages/keras/engine/saving.py ".decode('utf8')" words. due to error message provided by bash terminal
    conda activate deepnetbim
    tool_deepnetbim="/data1/wuguojia/data/mhc_benchmark/tools/DeepNetBim/src"
    tool_test_deepnetbim="/data1/wuguojia/data/mhc_benchmark/tools/DeepNetBim/data"
    tool_result_deepnetbim="/data1/wuguojia/data/mhc_benchmark/tools/DeepNetBim/data"
    cd $tool_deepnetbim
    while IFS= read -r file_path; do
        echo "cp $file_path $tool_test_deepnetbim/sample.txt" >> "$path_code/deepnetbim_command.sh"
        echo "python $tool_deepnetbim/predict.py $file_path" >> "$path_code/deepnetbim_command.sh"
    done < "$filelist_mhci_txt_deepnetbim"
    #give #!/bin/bash
    com_file="$path_code/deepnetbim_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/deepnetbim_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/deepnetbim.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running
################################ bigMHC_el
    #https://github.com/KarchinLab/bigmhc/tree/master
    conda activate bigmhc
    tool_bigmhc="/data1/wuguojia/data/mhc_benchmark/tools/bigmhc/src"
    cd $tool_bigmhc
    while IFS= read -r file_path; do
        file_name=$(basename "$file_path")
        echo "python $tool_bigmhc/predict.py -i=$file_path -o=$path_result/$file_name -m=el -d=\"cpu\"" >> "$path_code/bigmhc_command.sh"
    done < "$filelist_mhci_csv_bigmhc"
    #give #!/bin/bash
    com_file="$path_code/bigmhc_command.sh"
    sed -i '1i #!/bin/bash' "$com_file"
    #add x right
    chmod +x "$com_file"
    # taskset -c 0-9 /usr/bin/time -v bash /home/wuguojia/biocode/mhc_benchmark/speed_command/bigmhc_command.sh > /home/wuguojia/biocode/mhc_benchmark/speed_command/bigmhc.log 2>&1 &
    # jobs
    # disown -h %1 #(%1 means %[num],num is job number , can change)
    #successfully working if python process is running