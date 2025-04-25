# Project Repository

This repository contains the code and final results for the research project. The original code for each software and training data must be downloaded from their respective GitHub repositories (refer to Table 1 in the paper). The validation datasets were downloaded and organized from databases such as IEDB (refer to the Methods section of the paper).

---

## Code File Descriptions

### Part 1: Building the Validation Dataset
1. **`dataset_extraction.r`**: Extracts and merges peptide-HLA-I positive binding data from various databases, removing training data used by MHC-peptide prediction tools.
2. **`dataset_expandation.r`**: Processes protein data downloaded from the UniProtKB database to construct peptide-HLA-I negative binding data in a 1:1 ratio, then merges it with the positive data.
3. **`dataset_visualization.r`**: Visualizes the validation dataset.

---

### Part 2: Running MHC-Peptide Prediction Tools and Processing Results
1. **`result_mhci.r`**: Formats the output of prediction tools into a unified structure.
2. **`result_compare_mhci_calculate.r`**: Calculates metrics such as AUROC and AUPRC for each tool on the validation dataset.
3. **`result_compare_mhci_visualize.r`**: Visualizes the prediction performance of each tool.
4. **`performance_command/`**: Contains the `tool_usage.sh` script for running each tool. Some tools (e.g., consensus, mhcflurry) are executed as single scripts (e.g., `mhcflurry_command.sh`) due to the complexity of writing loops.

---

### Part 3: Computational Resource Usage
1. **`speed_dataset.r`**: Samples 4000 pHLA data points to evaluate the computational resource consumption of each prediction tool.
2. **`speed_command/`**: Contains all scripts and corresponding log files for running the tools.
3. **`speed_result.r`**: Summarizes and visualizes the computational resource consumption of each tool.
4. **`computational_resource.txt`**: Specifies the hardware configuration of the server used.

---

### Part 4: pLogo Visualization
1. **`plogo.r`**: Generates motif plots for all high-quality peptide-HLA-I positive data collected in this study.

---

### Part 5: Attention Module
1. **`attention_dataset_train.ipynb`**: Selects appropriate HLA alleles for experiments and prepares training data for the XAI model as background data.
2. **`attention_dataset_test.r`**: Selects 100 data points per allele for local explanation.
3. **`MHCXAI.py`**: A modified version by the author, incorporating LIME and SHAP interpreters with added functionality for explaining eight MHC-peptide prediction tools. The `attentionresult_use/` folder contains the XAI code for all tools.
4. **`attention_result.ipynb`**: Organizes the XAI results for the MHC-peptide prediction tools.
5. **`attention_result_visualize.r`**: Visualizes the XAI results for these tools.

---

### Part 6: Supplementary Materials and Shiny App
1. **`supplymentary.r`**: Organizes the results of the study. All result files are stored in the `supplementary/` folder.
2. **`shiny.r`**: Deploys a website using the Shiny package to display the generated pLogo and XAI explanation plots. The required files are `supplemantarydata5.1.csv` and `supplemantarydata5.2.csv` in the `supplementary/` folder.

---

## Usage
1. Clone this repository.
2. Download the required software and datasets as specified in the paper.
3. Follow the instructions in each script to reproduce the results.

---

## Citation
If you use this code or data, please cite the original paper: [insert citation here].