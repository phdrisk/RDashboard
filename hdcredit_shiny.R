######## PROF DR JOILSON DIAS   #######
#####kaggle competition - HOME CREDIT #####
######## PROF DR JOILSON DIAS   #######
#####kaggle competition - HOME CREDIT #####
          
#### TRATAMENTO DOS DADOS###
##Libraries##
library(caret)
library(data.table)
library(dplyr)
# library(lime)
library(corrr)
library(doMC)
registerDoMC(cores = 8)


##INTRODUÇÃO - PREPARAÇÃO DOS DADOS##

setwd("/media/sf_R-KAGGLE/")

data<-fread("hcredit_train.csv")
#names(data)
y<-data$TARGET
table(y)

###Exemplos de como consertar toos os dados de uma so vez
sum(is.na(data))
data1<-data[,-c(1,2)] #retiramos a id e a TARGET
id<-data[,1]

###Vamos centraliar as variaveis e imputar os mesmos para não perder observações 
data2<-data1 %>% mutate_if(is.character, as.factor)
data2<-data2 %>% mutate_if(is.factor, as.numeric)

sum(is.na(data2))
#######################
#####################

### Processando os dados para NA ####
preProcValues <- preProcess(data2, method = c("medianImpute")) #usar a op;ao knnInpute or annInput como op
data_processed <- predict(preProcValues, data2)
sum(is.na(data_processed))

x<-data_processed
y<-as.numeric(y)

dataxy<-cbind(id,x,y)

#############################
###COMEÇA AQUI###

#####MLs recarregando os dados

###REduzindo o tamanho da amostra para considerar somente as mais importantes

corr_y<-cor(x, y,  method = "pearson", use = "complete.obs")

row.names(corr_y)

cc<-subset(corr_y, corr_y <=-0.02 | corr_y>=0.02)
ncc<-row.names(cc)
vars<-paste0(ncc)
vars

data_cor<-subset(dataxy, select=vars)


### Feature correlations to default
corrr_analysis <- data_cor[,1:50] %>%
  mutate(Default = y) %>%
  correlate() %>%
  focus(Default) %>%
  rename(feature = rowname) %>%
  arrange(abs(Default)) %>%
  mutate(feature = as.factor(feature)) 
corrr_analysis

# Correlation visualization
corrr_analysis %>%
  ggplot(aes(x = Default, y = reorder(feature, desc(Default)))) +
  geom_point() +
  # Positive Correlations - Contribute to churn
  geom_segment(aes(xend = 0, yend = feature), 
               color = palette()[[3]], 
               data = corrr_analysis %>% filter(Default < 0)) +
  geom_point(color = palette()[[3]], 
             data = corrr_analysis %>% filter(Default < 0)) +
  # Negative Correlations - Prevent churn
  geom_segment(aes(xend = 0, yend = feature), 
               color = palette()[[2]], 
               data = corrr_analysis %>% filter(Default > 0)) +
  geom_point(color = palette()[[2]], 
             data = corrr_analysis %>% filter(Default > 0)) +
  # Vertical lines
  geom_vline(xintercept = 0, color = palette()[[5]], size = 1, linetype = 2) +
  geom_vline(xintercept = -0.25, color = palette()[[5]], size = 1, linetype = 2) +
  geom_vline(xintercept = 0.25, color = palette()[[5]], size = 1, linetype = 2) +
  # Aesthetics
  theme_classic() +
  labs(title = " Consumer Home Credit Behavior",
       subtitle = "Red Lines - Factors that may contribute to default, Green Lines - Factors that do not contribute to default",
       y = "Factors importance")


data_cor$TARGET<-y

hcredit_cor<-cbind(id,data_cor)
names(hcredit_cor)

##CONSTRUINDO AS BASE DE DADOS DE TAMANHO MENORES DE TREINAMENTO E TESTES
## dados centralizados,median Impute e variaveis slecioandos usando correlação |0.02|
##O primeiro arquivo é dados completos e demais treinamento e test

write.csv(hcredit_cor, "dataF_hc_vff.csv", row.names=FALSE) 

p<-0.7
index <- sample(1:nrow(hcredit_cor),round(p*nrow(hcredit_cor)))
dataT <- hcredit_cor[index,]
dataP <- hcredit_cor[-index,]
str(dataT)
str(dataP)

write.csv(dataT, "dataT_hc_vff.csv", row.names=FALSE)
write.csv(dataP, "dataP_hc_vff.csv", row.names=FALSE)

