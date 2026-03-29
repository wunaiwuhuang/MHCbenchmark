library(readxl)
path_test<-"data1/wuguojia/data/mhc_benchmark/testbase/"
setwd(path_test)
df<-read_excel("TEST.xlsx",sheet=3)
names(df)[1]<-"allele"
# allele distribution
plot<-list()
for(len in c(8,9,10,11)){
    data<-df[,c("allele",as.character(len))]
    data$positive<-data[[as.character(len)]]/2
    data$negative<-data[[as.character(len)]]/2
    data<-data[,-2]
    plot[[as.character(len)]]<-
    ggplot(data, aes(x = allele)) +
    geom_bar(aes(y = positive),stat = "identity", fill = "firebrick") +  
    geom_bar(aes(y = -negative),stat = "identity", fill = "steelblue") + 
    scale_y_continuous(
        trans = scales::pseudo_log_trans(base = 10),
        breaks = c(-10000,-1000, -100, -10, 0, 10, 100, 1000,10000),
        labels = scales::label_number()) +
    labs(
        title = NULL,
        x = NULL,
        y = len) +
    theme_minimal() +
    theme(
        panel.grid = element_blank(),
        axis.text.x = element_text(angle = 90, hjust = 1),
        #axis.text.x = element_blank(),
        axis.text.y = element_text(size = 10))+
    geom_hline(yintercept = 10000,linetype = "dashed", color = "black") +
    geom_hline(yintercept = -10000,linetype = "dashed", color = "black")+
    geom_hline(yintercept = 100,linetype = "dashed", color = "gray") +
    geom_hline(yintercept = -100,linetype = "dashed", color = "gray")
}
# len_type distribution
data <- data.frame(len = c(8, 9, 10, 11), sum = unlist(lapply(df[2:5], sum, na.rm = TRUE)))
data$positive<-data$sum/2
data$negative<-data$sum/2
data<-data[,-2]
data_long <- gather(data, key = "type", value = "count", positive, negative)
ggplot(data_long, aes(x = factor(len), y = count, fill = type)) +
geom_bar(stat = "identity", position = "dodge",width = 0.8) +
labs(x = NULL, y = "Count", title = "Length Type Distribution") +
scale_fill_manual(values = c("positive" = "firebrick", "negative" = "steelblue")) +
theme_minimal()+
theme(
    legend.position = "bottom",
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),  # 添加边框
    panel.background = element_rect(fill = "white", color = "black")) # 背景和边框颜色设置
# hla_type distribution
data <- data.frame( 
    hla = c("HLA-A", "HLA-B", "HLA-C"), 
    sum = sapply(c("HLA-A", "HLA-B", "HLA-C"), function(hla) {
        rows <- grep(hla, df$allele)
        sum_values <- colSums(df[rows, 2:5], na.rm = TRUE)
        sum(sum_values)}))
data$positive<-data$sum/2
data$negative<-data$sum/2
data<-data[,-2]
all_sum <- colSums(data[, c("positive", "negative")])
data <- rbind(data, data.frame(hla = "ALL", positive = all_sum[1], negative = all_sum[2]))
data_long <- gather(data, key = "type", value = "count", positive, negative)
ggplot(data_long, aes(x = factor(hla), y = count, fill = type)) +
geom_bar(stat = "identity", position = "dodge",width = 0.8) +
labs(x = NULL, y = "Count", title = "HLA Type Distribution") +
scale_fill_manual(values = c("positive" = "firebrick", "negative" = "steelblue")) +
theme_minimal()+
theme(
    legend.position = "bottom",
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),  # 添加边框
    panel.background = element_rect(fill = "white", color = "black")) # 背景和边框颜色设置