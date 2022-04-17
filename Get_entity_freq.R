# 加载包
install.packages("wordcloud2")
library(wordcloud2)

# 数据清洗，统计实体词频
data <- read.csv('covid_19_entity_info.txt', sep = '\t', header= F, stringsAsFactors= F, quote = "")
entity <- data.frame(entity = data$V4, bioconcep = data$V5)
entity$entity <- tolower(entity$entity)
entity_list <- c(entity$entity)
freq <- table(entity_list)
freq <- data.frame(freq)
names(freq)[1] <- "entity"
freq$entity <- as.character(freq$entity)
freq$Freq <- as.integer(freq$Freq)
freq <- merge(freq, entity, by = "entity")
freq <- freq[!duplicated(freq$entity), ]
order_temp <- order(freq$Freq, decreasing = T)
freq <- freq[order_temp,]
rownames(freq) <- seq(1,nrow(freq))

# 基因实体词云绘制
gene <- freq[freq$bioconcep == "Gene" & freq$Freq >= 100, ]
order_temp <- order(gene$Freq, decreasing = T)
gene <- gene[order_temp,]
rownames(gene) <- seq(1,nrow(gene))
gene$Freq <- gene$Freq ^ 0.4
wordcloud2(gene, size = 0.6)