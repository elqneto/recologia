##http://recologia.com.br/2018/05/distribuicao-beta-e-regressao-beta/

##Pacores utilizados
library(betareg) #para fazer a regressão
library(car) # para fazer a anova
library(lattice) # para a ultima figura

args(dbeta)

##Figura do PDF
par(mfrow=c(3,3))
for(i in c(0.1,1,10)) {
    for(j in c(0.1,1,10)) {            
        curve(dbeta(x,i,j),0,1,main=paste("Média=",round(i/(i+j),2),",Variância=",round(i*j/(((i+j)^2)*(i+j+1)),2),sep=""),frame=F,cex.main=0.8)
        mtext(paste("a=",i,",b=",j,sep=""),line=-0.4,cex=0.8)
    }
}


####Dados Prontos
dados <- structure(list(Instrutor = c("Alice", "Alice", "Alice", "Alice", 
"Alice", "Alice", "Alice", "Alice", "Alice", "Alice", "Alice", 
"Alice", "Alice", "Alice", "Alice", "Alice", "Alice", "Alice", 
"Alice", "Alice", "Bob", "Bob", "Bob", "Bob", "Bob", "Bob", "Bob", 
"Bob", "Bob", "Bob", "Bob", "Bob", "Bob", "Bob", "Bob", "Bob", 
"Bob", "Bob", "Bob", "Bob", "Carol", "Carol", "Carol", "Carol", 
"Carol", "Carol", "Carol", "Carol", "Carol", "Carol", "Carol", 
"Carol", "Carol", "Carol", "Carol", "Carol", "Carol", "Carol", 
"Carol", "Carol"), Suplemento = c("A", "A", "A", "A", "A", "B", 
"B", "B", "B", "B", "C", "C", "C", "C", "C", "D", "D", "D", "D", 
"D", "A", "A", "A", "A", "A", "B", "B", "B", "B", "B", "C", "C", 
"C", "C", "C", "D", "D", "D", "D", "D", "A", "A", "A", "A", "A", 
"B", "B", "B", "B", "B", "C", "C", "C", "C", "C", "D", "D", "D", 
"D", "D"), Sodium = c(1200L, 1400L, 1350L, 950L, 1400L, 1150L, 
1300L, 1325L, 1425L, 1500L, 1250L, 1150L, 950L, 1150L, 1600L, 
1300L, 1050L, 1300L, 1700L, 1300L, 1100L, 1200L, 1250L, 1050L, 
1200L, 1250L, 1350L, 1350L, 1325L, 1525L, 1225L, 1125L, 1000L, 
1125L, 1400L, 1200L, 1150L, 1400L, 1500L, 1200L, 900L, 1100L, 
1150L, 950L, 1100L, 1150L, 1250L, 1250L, 1225L, 1325L, 1125L, 
1025L, 950L, 925L, 1200L, 1100L, 950L, 1300L, 1400L, 1100L)), .Names = c("Instrutor", 
"Suplemento", "Sodium"), row.names = c(NA, -60L), class = "data.frame")

##  Criando uma váriavel de proporção
dados$proporcao = dados$Sodium / 2300

##Regressão Beta
modelo = betareg(proporcao ~ Instrutor * Suplemento , data = dados)

##Anova do modelo
Anova(modelo,type="III")

##Parametros estimados
summary(modelo)

##Vendo as médias
aggregate(dados$proporcao,list(dados$Instrutor),mean)

##Figura
bwplot(proporcao~Instrutor|Suplemento,data = dados)
