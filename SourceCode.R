##################################################
# Source Code for Microsleep Prediction Paper 
# Hidalgo Gadea et al. 2021 in Ergonomics     
# see MIT License (C) 2021 from GitHub Repository
##################################################
###### 1) Libraries            ###################
##################################################
# install packages as needed in current R installation
install.packages("WRS2")
install.packages("ggExtra")
install.packages("ggpubr")
install.packages("rcompanion")
install.packages("forestplot")
install.packages("gmodels")
install.packages("lm.beta")
install.packages("broom")
install.packages("robustbase")

# load libraries as needed in current R session
library(MASS)
library(psych) # provides descriptives
library(car) # provides VIF for multicollinearity
library(ggplot2) # provides graphical displays
library(reshape2) # provides melt funtion
library(WRS2) # provides robust ANOVA
library(robustbase) # provides robust CI and estimators?
library(ggExtra) # provides densigram plots in ggplot 
library(ggpubr) # provides significance brakets in ggplot
library(rcompanion) # provides model comparisons in regression
library(forestplot) # provides forestplots for confidence intervals
library(lm.beta) # provides beta coefficients in regression
library(gmodels) # provides CrossTabulation
library(broom) # tidy function for CI in lm.beta
library(easycsv)

###### 2) Data                 ###################
##################################################
#### set working directory
wd <- choose_dir()
setwd(wd)

# load data
data <- fread("DataMicrosleep.csv")
str(data)

# Filter NA in Microsleep
data <- subset(data, is.na(data$Microsleep.binary)==F)

# Filter NA in sleep deprivation time
data <- subset(data, is.na(data$Sleep.deprivation.time)==F)

# Filter NA in Age
data <- subset(data, is.na(data$Age)==F)

# Filter NA in relevant KSS
data <- subset(data, is.na(data$KSS.arrival)==F)
data <- subset(data, is.na(data$KSS.morning)==F)
data <- subset(data, is.na(data$KSS.start.driving)==F)

# Filter NA in IQ
data <- subset(data, is.na(data$IQ..SPM.)==F)


###### 3) Descriptives         ###################
##################################################

## Sample Size
length(data$Subject)

## Age
describe(data$Age)
hist(data$Age)
boxplot(data$Age)
describeBy(data$Age, group = data$Microsleep.binary)

## Weight
describe(data$Weight)
hist(data$Weight)
boxplot(data$Weight)
describeBy(data$Weight, group = data$Microsleep.binary)

## Hight
describe(data$Height)
hist(data$Height)
boxplot(data$Height)
describeBy(data$Height, group = data$Microsleep.binary)


## Smoking (1 = no, 2 = rarely, 3 = occasionally, 4 = frequently)
table(data$Smoking)
describe(data$Smoking, IQR = T)
describeBy(data$Smoking, group= data$Microsleep.binary, IQR = T)

## Alcohol (1 = no, 2 = rarely, 3 = occasionally, 4 = frequently)
table(data$Alcohol)
describe(data$Alcohol, IQR = T)
describeBy(data$Alcohol, group= data$Microsleep.binary, IQR = T)

## Driving Skill (1= bad, 10 = good)
describe(data$DrivingSkills, IQR = T)
hist(data$DrivingSkills)
boxplot(data$DrivingSkills)
describeBy(data$DrivingSkills, group= data$Microsleep.binary, IQR = T)

# replace NA in Driving Skill with Median
for (i in 1:nrow(data)){
  if (is.na(data$DrivingSkills[i])==T){
    data$DrivingSkills[i]<-8
  }
}

## Risk in Curves (1= low, 10 = high)
describe(data$RiskInCurves)
hist(data$RiskInCurves)
boxplot(data$RiskInCurves)

## Lane holding Stability (1= bad, 10 = good)
describe(data$LaneHoldingStability)
hist(data$LaneHoldingStability)
boxplot(data$LaneHoldingStability)


## PSQI
describe(data$Total.Value.PSQI)
hist(data$Total.Value.PSQI)
boxplot(data$Total.Value.PSQI)
describeBy(data$Total.Value.PSQI, group = data$Microsleep.binary)
table(data$Total.Value.PSQI)

## Sleep deprivation Time (experimental manipulation)
describe(data$Sleep.deprivation.time)
hist(data$Sleep.deprivation.time)
boxplot(data$Sleep.deprivation.time)
boxplot(data$Sleep.deprivation.time~data$Driver.order)
describeBy(data$Sleep.deprivation.time, group = data$Microsleep.binary)

# Sleep deprivation effect on sleepiness
scat.plot<- ggplot(data, aes(Sleep.deprivation.time, KSS.start.driving)) + geom_point() +
  geom_jitter(width = .20) + geom_smooth(method = "lm", level = 0.95, color = "grey", fill = "grey") +
  theme_classic() + theme(panel.grid.major = element_line()) + #coord_equal() +
  scale_x_continuous(name = "sleep deprivation time", limits = c(20, 34), breaks = seq(20,34,1))+ 
  scale_y_continuous(name = "KSS start driving", limits = c(1, 10), breaks = seq(1,10,1))
ggExtra::ggMarginal(scat.plot, type = "densigram")


## KSS
describe(data$KSS.arrival)
describe(data$KSS.morning)
boxplot(data$KSS.morning ~ data$Driver.order)
describe(data$KSS.start.driving)
boxplot(data$KSS.start.driving ~ data$Driver.order)
describe(data$KSS.30min)
describe(data$KSS.60min)
describe(data$KSS.90min)
describe(data$KSS.120min)


## IQ by SPM
describe(data$IQ..SPM.)
hist(data$IQ..SPM.)
boxplot(data$IQ..SPM.)
describeBy(data$IQ..SPM., group = data$Microsleep.binary)


## NEO-PI-R
describe(data$Neuroticism..NEOPIR.)
hist(data$Neuroticism..NEOPIR.)
boxplot(data$Neuroticism..NEOPIR.)
describeBy(data$Neuroticism..NEOPIR., group = data$Microsleep.binary)

describe(data$Extraversion...NEOPIR.)
hist(data$Extraversion...NEOPIR.)
boxplot(data$Extraversion...NEOPIR.)
describeBy(data$Extraversion...NEOPIR., group = data$Microsleep.binary)

describe(data$Openness.to.experience..NEOPIR.)
hist(data$Openness.to.experience..NEOPIR.)
boxplot(data$Openness.to.experience..NEOPIR.)
describeBy(data$Openness.to.experience..NEOPIR., group = data$Microsleep.binary)

describe(data$Agreeableness..NEOPIR.)
hist(data$Agreeableness..NEOPIR.)
boxplot(data$Agreeableness..NEOPIR.)
describeBy(data$Agreeableness..NEOPIR., group = data$Microsleep.binary)

describe(data$Conscientiousness..NEOPIR.)
hist(data$Conscientiousness..NEOPIR.)
boxplot(data$Conscientiousness..NEOPIR.)
describeBy(data$Conscientiousness..NEOPIR., group = data$Microsleep.binary)


## SSS
describe(data$Sensation.Seeking.Total..SSS.)
hist(data$Sensation.Seeking.Total..SSS.)
boxplot(data$Sensation.Seeking.Total..SSS.)
describeBy(data$Sensation.Seeking.Total..SSS., group = data$Microsleep.binary)

describe(data$Thrill.and.Adventure.Seeking..SSS.)
hist(data$Thrill.and.Adventure.Seeking..SSS.)
boxplot(data$Thrill.and.Adventure.Seeking..SSS.)

describe(data$Disinhibition..SSS.)
hist(data$Disinhibition..SSS.)
boxplot(data$Disinhibition..SSS.)

describe(data$Experience.Seeking..SSS.)
hist(data$Experience.Seeking..SSS.)
boxplot(data$Experience.Seeking..SSS.)

describe(data$Boredom.Susceptivility..SSS.)
hist(data$Boredom.Susceptivility..SSS.)
boxplot(data$Boredom.Susceptivility..SSS.)

## Microsleep vulnerability
table(data$Microsleep.binary)

CrossTable(data$Microsleep.binary, data$Driver.order, expected = T, format = "SPSS")
chisq.test(data$Microsleep.binary, data$Driver.order)

# Pie chart
x<- as.data.frame(table(data$Microsleep.binary))
colnames(x)[1]<- "Microsleep"
x[1]<- c("resistant", "vulnerable")
n<- x[1,2]+x[2,2]
p1<-round(100*(x[1,2]/n),2)
p1<-paste(p1,"%")
p2<-round(100*(x[2,2]/n),2)
p2<-paste(p2,"%")

pie<- ggplot(x, aes(x="", y=Freq, fill=Microsleep))+
      geom_bar(width = 1, stat = "identity", colour = "black")+
      coord_polar("y", start=1.6)+ theme_void()+
      geom_text(aes(y = 55, label = p2), size = 4, hjust=0.3)+
      geom_text(aes(y = 130, label = p1), size = 4, hjust=0.35)+
      labs(title = "N = 144")+
      theme(plot.title = element_text(hjust=1.55,vjust =-15,size=12, face="bold"))+
      theme(axis.title.x = element_blank(),axis.title.y = element_blank())+
      theme(axis.ticks = element_blank())+
      theme(legend.position="right")+
      theme(legend.title = element_text(size=12,face="bold"))+
      theme(legend.text = element_text(size=10))+
      scale_fill_manual(values=c("#CCCCCC", "#666666"))
pie
#ggsave("piechartMS.png", width = 3,height = 3, units = "in")


## time to microsleep & min to microsleep
describe(data$min.to.Microsleep, IQR=T)
hist(data$min.to.Microsleep)
boxplot(data$min.to.Microsleep)
boxplot(data$min.to.Microsleep ~ data$Driver.order)

boxplot<- ggplot(data, aes(x= "", y=min.to.Microsleep)) + 
  stat_boxplot(geom = "errorbar", width = 0.2) +
  geom_boxplot(fill = "grey", outlier.shape = NA)  +
  geom_jitter(width = .30, size = 0.9) + stat_summary(fun.y=mean, geom="point", shape=17, size=5, position=position_dodge(0.75))+
  theme_classic() +theme(axis.line.x=element_line(linetype = "solid", color = "black", size = 0.5))+ 
  theme(axis.line.y=element_blank(), axis.title.y = element_blank())+ theme(axis.text.x = element_text(face="bold", color="black",size=10))+
  theme(axis.title.x = element_text(face="bold", color="black",size=12))+
  scale_y_continuous(name = "Time to Microsleep [min]", limits = c(0, 180), breaks = seq(0,180,30)) + coord_flip()
boxplot
#ggsave("boxplotMS.png", width = 3.73,height = 3, units = "in")


###### 4) Robust ANOVAs        ###################
##################################################
# Figure of KSS progress over time
KSS<- data.frame(data$Subject,data$KSS.arrival, data$KSS.morning, data$KSS.start.driving,data$KSS.30min,data$KSS.60min,data$KSS.90min,data$KSS.120min)
colnames(KSS)[1]<- "Subject"
colnames(KSS)[2]<- "Arrival 6pm"
colnames(KSS)[3]<- "Morning 9am"
colnames(KSS)[4]<- "Start Driving"
colnames(KSS)[5]<- "+30min Driving"
colnames(KSS)[6]<- "+60min Driving"
colnames(KSS)[7]<- "+90min Driving"
colnames(KSS)[8]<- "+120min Driving"

# NA count as microsleep events
# Cummulative incidences across time 
N_arrival = 0
N_morning = 0
N_start = 0
N_30min = 39
N_60min = 75
N_90min = 89
N_120min = 104

n<-(c(N_arrival,N_morning,N_start,N_30min,N_60min,N_90min,N_120min))
variable<- c("Arrival 6pm","Morning 9am","Start Driving","+30min Driving","+60min Driving","+90min Driving","+120min Driving")
nKSS<-data.frame(variable,n)
nKSS$N<-144
nKSS$N<-nKSS$N-nKSS$n
nKSS$p<-(nKSS$n/144)*100

# from wide format to long format
KSS<- melt(KSS, id="Subject", na.rm = T, value.name = "KSS")

# add line breaks to labels in ggplot
levels(KSS$variable) <- gsub(" ", "\n", levels(KSS$variable))

boxplot<- ggplot(KSS, aes(x=variable, y=KSS)) + 
          stat_boxplot(geom = "errorbar", width = 0.5) +
          geom_boxplot(fill = "#999999",notch = T,outlier.shape=16) + 
          stat_summary(fun.y=mean, geom="point", shape=17, size=5)+
          labs(x="Time of Measurement", y = "Situational Sleepiness (KSS)", color = "black",size = 15)+
          scale_y_continuous(limits = c(1,11), breaks = c(1:10))+
          scale_color_grey() + theme_classic()+ theme(axis.title.x = element_text(margin = margin(t = 20, r = 0, b = 0, l = 0)))+
          theme(axis.text.x = element_text(color = "black",size = 20),axis.text.y = element_text(color = "black",size = 20), text = element_text(color = "black",size = 20) )+
          geom_bracket(xmin = 1, xmax = 2, y.position = 10.5, label = "p < 0.001", tip.length = c(0.01, 0.01))+
          geom_bracket(xmin = 3, xmax = 4, y.position = 10.5, label = "p < 0.001", tip.length = c(0.01, 0.01))+
          geom_bracket(xmin = 4, xmax = 5, y.position = 10.8, label = "p < 0.001", tip.length = c(0.01, 0.01))
boxplot
#ggsave("boxplot1.png", width = 13,height = 5, units = "in")

barplot<- ggplot(nKSS, aes(x = variable, y = n)) + 
  geom_bar(stat="identity",width = 0.8,fill = "#999999", colour="black") + labs(y = "N Drivers Asleep", color = "black",size = 15)+
  scale_y_continuous(limits = c(0,144), breaks = seq(0,144,20))+
  scale_x_discrete(limits=c("Arrival 6pm","Morning 9am","Start Driving","+30min Driving","+60min Driving","+90min Driving","+120min Driving"))+
  scale_color_grey() + theme_classic()+ theme(axis.ticks.x=element_blank(),axis.line.x=element_blank(), axis.title.x = element_blank())+
  theme(axis.text.y = element_text(color = "black",size = 20), text = element_text(color = "black",size = 20) )
barplot
#ggsave("barplot1.png", width = 13,height = 3, units = "in")

barplot<- ggplot(nKSS, aes(x = variable, y = p)) + 
  geom_bar(stat="identity",width = 0.8,fill = "#999999", colour="black") + labs(y = "% Drivers Microsleep", color = "black")+
  scale_y_continuous(limits = c(0,100), breaks = seq(0,100,25))+
  scale_x_discrete(limits=c("Arrival 6pm","Morning 9am","Start Driving","+30min Driving","+60min Driving","+90min Driving","+120min Driving"))+
  scale_color_grey() + theme_classic()+ theme(axis.ticks.x=element_blank(),axis.line.x=element_blank(), axis.title.x = element_blank())+
  theme(axis.text.y = element_text(color = "black",size = 20), text = element_text(color = "black",size = 20) )
barplot
ggsave("barplot2.png", width = 14,height = 3, units = "in")


## Robust bootstraped repeated measures ANOVA
rmanovab(KSS$KSS, KSS$variable, KSS$Subject, tr= .15, nboot = 2000)
rmmcp(KSS$KSS, KSS$variable, KSS$Subject, tr= .15)


## Sleepiness by group
KSS2<- data.frame(data$Subject,data$Microsleep.binary,data$KSS.arrival, data$KSS.morning, data$KSS.start.driving,data$KSS.30min,data$KSS.60min,data$KSS.90min,data$KSS.120min)
colnames(KSS2)[1]<- "Subject"
colnames(KSS2)[2]<- "Microsleep"
colnames(KSS2)[3]<- "Arrival 6pm"
colnames(KSS2)[4]<- "Morning 9am"
colnames(KSS2)[5]<- "Start Driving"
colnames(KSS2)[6]<- "+30min Driving"
colnames(KSS2)[7]<- "+60min Driving"
colnames(KSS2)[8]<- "+90min Driving"
colnames(KSS2)[9]<- "+120min Driving"
# from wide format to long format
KSS2<- melt(KSS2, id=c("Subject", "Microsleep"), na.rm = T, value.name = "KSS")
KSS2$Microsleep<- as.factor(KSS2$Microsleep)
levels(KSS2$Microsleep) <- c("resistant","vulnerable")
levels(KSS2$variable) <- gsub(" ", "\n", levels(KSS2$variable))

boxplot2<- ggplot(KSS2, aes(x=variable, y=KSS, fill = Microsleep)) + 
  stat_boxplot(geom = "errorbar", width = 0.2, position=position_dodge(0.75)) +
  geom_boxplot(notch = T) +
  stat_summary(fun.y=mean, geom="point", shape=17, size=3, position=position_dodge(0.75))+
  labs(x="Time of Measurement", y = "Situational Sleepiness (KSS)", color = "black",size = 15)+
  scale_y_continuous(limits = c(1,11), breaks = c(1:10))+
  scale_color_grey() + theme_classic()+ theme(axis.title.x = element_text(margin = margin(t = 20, r = 0, b = 0, l = 0)))+
  scale_fill_manual(values=c("#CCCCCC", "#666666"))+ theme(legend.justification=c(1,0.1), legend.position=c(1,0.1))+
  theme(axis.text.x = element_text(color = "black",size = 20),axis.text.y = element_text(color = "black",size = 20), text = element_text(color = "black",size = 20) )
boxplot2
#ggsave("boxplotgrups.png", width = 13,height = 5, units = "in")

## Split file in 2x2 sleep deprivation
KSS3<- KSS2[1:288,]
KSS3$variable<- factor(KSS3$variable)
str(KSS3)
table(KSS3$variable)

## 2-way within-between subjects ANOVA
bwtrim(KSS ~ Microsleep*variable, id = Subject, data = KSS3, tr = 0.15)


## Split file in 2x2 sleep difference
KSS4<- KSS2[145:432,]
KSS4$variable<- factor(KSS4$variable)
str(KSS4)
table(KSS4$variable)

## 2-way within-between subjects ANOVA
bwtrim(KSS ~ Microsleep*variable, id = Subject, data = KSS4, tr = 0.15)


###### 5) Logistic Regression  ###################
##################################################
## Baseline
log.baseline <- glm(Microsleep.binary ~ 1, data = data, family = binomial(link = "logit"))
summary(log.baseline)

## Demographics (STEP 1)
log.step1 <- glm(Microsleep.binary ~ Age + Weight + Height + Smoking + Alcohol + DrivingSkills + Total.Value.PSQI + Sleep.deprivation.time, data = data, family = binomial(link = "logit"))
summary(log.step1)
confint(log.step1)
vif(log.step1)
exp(log.step1$coefficients)

anova(log.baseline, log.step1, test="Chisq") 
compareGLM(log.baseline, log.step1)


## Morning Sleepiness KSS (STEP 2)
log.step2 <- glm(Microsleep.binary ~ Age + Weight + Height + Smoking + Alcohol + DrivingSkills + Total.Value.PSQI + Sleep.deprivation.time + KSS.morning, data = data, family = binomial(link = "logit"))
summary(log.step2)
vif(log.step2)

anova(log.step1,log.step2, test="Chisq")
compareGLM(log.step1,log.step2)


## Start Driving Sleepiness difference (STEP 3)
log.step3 <- glm(Microsleep.binary ~ Age + Weight + Height + Smoking + Alcohol + DrivingSkills + Total.Value.PSQI + Sleep.deprivation.time + KSS.morning + KSS.start.driving, data = data, family = binomial(link = "logit"))
summary(log.step3)
vif(log.step3)
exp(log.step3$coefficients)
confint(log.step3)

# note that the main effect of KSS.start.driving represents the difference between morning and start driving when KSS.morning is beeing partialed out
anova(log.step2,log.step3, test="Chisq")
compareGLM(log.step2,log.step3)


### inter-individual predictors (STEP 4)
log.full<-update(log.step3, .~. + Neuroticism..NEOPIR. + Extraversion...NEOPIR. + Openness.to.experience..NEOPIR. + Agreeableness..NEOPIR. + Conscientiousness..NEOPIR. + Sensation.Seeking.Total..SSS.+ IQ..SPM.)
summary(log.full)
vif(log.full)
exp(log.full$coefficients)
confint(log.full)

anova(log.step3, log.full, test = "Chisq")
compareGLM(log.step3, log.full)

anova(log.baseline, log.step1, log.step2, log.step3, log.full, test = "Chisq")
compareGLM(log.baseline, log.step1, log.step2, log.step3, log.full)

## Forestplot log.full
rows<- list(attr(log.full$coefficients,"names")[2:18])
OR<-as.data.frame(exp(cbind(coef(log.full), confint(log.full))))[2:18,]
colnames(OR)<- c("odds", "ll", "ul")

forestplot(rows,
           OR$odds,
           OR$ll,
           OR$ul,
           zero = 1,
           clip = c(0.5, 1.6),
           boxsize   = 0.5,
           graphwidth = unit(1.8, 'in'),
           lineheight = unit(0.3,'in'),
           xlab = "Odds ratio [95% CI]",
           txt_gp=fpTxtGp(ticks=gpar(cex=1),
                          xlab=gpar(cex = 1)),
           ci.vertices=TRUE,ci.vertices.height = 0.2,
           col=fpColors(box="black", lines="black", zero = "gray50"),
           colgap=unit(10,"mm"),
           digitsize= 10)


### Final Model
log.final<- update(log.step3, .~. +  Conscientiousness..NEOPIR.  + Sensation.Seeking.Total..SSS.)
summary(log.final)
vif(log.final)
exp(log.final$coefficients)
confint(log.final)


anova(log.step3,log.final, test="Chisq")
compareGLM(log.step3,log.final)

anova(log.step1,log.final, test="Chisq")
compareGLM(log.step1,log.final)


## Forestplot log.final
rows<- list(attr(log.final$coefficients,"names")[2:13])
OR<-as.data.frame(exp(cbind(coef(log.final), confint(log.final))))[2:13,]
colnames(OR)<- c("odds", "ll", "ul")

forestplot(rows,
           OR$odds,
           OR$ll,
           OR$ul,
           zero = 1,
           clip = c(0.5, 1.6),
           boxsize   = 0.5,
           graphwidth = unit(1.8, 'in'),
           lineheight = unit(0.3,'in'),
           xlab = "Odds ratio [95% CI]",
           txt_gp=fpTxtGp(ticks=gpar(cex=1),
                          xlab=gpar(cex = 1)),
           ci.vertices=TRUE,ci.vertices.height = 0.2,
           col=fpColors(box="black", lines="black", zero = "gray50"),
           colgap=unit(10,"mm"),
           digitsize= 10)

#Plot prediction performance
prediction<-predict(log.final, type="response")
predicted<- cbind(data, prediction)
predicted$Microsleep.binary<- as.factor(predicted$Microsleep.binary)
predicted$Microsleep<- as.numeric(predicted$Microsleep.binary)-1

Prediction<- ggplot(predicted, aes(x=reorder(Subject, prediction), colour= Microsleep.binary)) + 
  geom_point(aes(y=prediction), shape=20, size=5)+ geom_point(aes(y=Microsleep), shape=18, size=5) + scale_color_grey(start = 0.6,end = 0)+
  labs(x="Drivers", y = "Predicted P(Microsleep)", color = "black",size = 15)+
  theme_classic() + theme(axis.text.x = element_text(color = "black",size = 20),axis.text.y = element_text(color = "black",size = 20), text = element_text(color = "black",size = 20))+
  theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+ theme(legend.position = "none")
Prediction
#ggsave("prediction.png", width = 9.75,height = 5, units = "in")


boxplot<- ggplot(predicted, aes(x= Microsleep.binary, y=prediction, fill=Microsleep.binary)) + 
  stat_boxplot(geom = "errorbar", width = 0.2, position=position_dodge(0.75)) +
  geom_boxplot(notch = T) +
  stat_summary(fun.y=mean, geom="point", shape=17, size=3, position=position_dodge(0.75))+
  labs(x="Actual Microsleep", y = "Predicted P(Microsleep)", color = "black",size = 15)+
  scale_y_continuous(limits = c(0,1), breaks = seq(0,1,0.25))+
  scale_color_grey() + theme_classic()+ theme(axis.title.x = element_text(margin = margin(t = 20, r = 0, b = 0, l = 0)))+
  scale_fill_manual(values=c("#CCCCCC", "#666666"))+
  theme(axis.text.x = element_text(color = "black",size = 20),axis.text.y = element_text(color = "black",size = 20), text = element_text(color = "black",size = 20))+
  theme(legend.position = "none")
boxplot
#ggsave("boxplotprediction.png", width = 3.2,height = 6, units = "in")

## Logistic Classification
data$Microsleep.binary<- as.factor(data$Microsleep.binary)
clas.plot<- ggplot(data, aes(x= Conscientiousness..NEOPIR., y=KSS.start.driving, shape=Microsleep.binary, color = Microsleep.binary))+ geom_point(size = 3) +
  theme_classic() + theme(panel.grid.major = element_line()) +
  scale_x_continuous(name = "Conscientiousness", limits = c(80, 115), breaks = seq(80, 115,5))+ 
  scale_y_continuous(name = "Start Driving KSS", limits = c(1, 10), breaks = seq(1,10,1))+
  theme(axis.title.y = element_text(face="bold", color="black",size=16))+ theme(axis.text.y = element_text(face="bold", color="black",size=16))+
  theme(axis.title.x = element_text(face="bold", color="black",size=16))+ theme(axis.text.x = element_text(face="bold", color="black",size=16))
clas.plot
ggsave("classification.png", width = 8,height = 6, units = "in")


### Residuals
predict<- log.final$fitted.values
residuals<- log.final$residuals
std.residuals<-rstandard(log.final)
resdata<- cbind(predict,residuals,std.residuals)
resdata<- as.data.frame(resdata)


res.plot<- ggplot(resdata, aes(std.residuals, predict)) + geom_point(size=1.5) +
  theme_classic() + theme(panel.grid.major = element_line()) +
  scale_x_continuous(name = "Standardized Residuals", limits = c(-2.5, 2), breaks = seq(-4,4,1))+ 
  scale_y_continuous(name = "P(Microsleep Vulnerability)", limits = c(0.20, 1), breaks = seq(0,1,.25))+
  theme(axis.title.y = element_text(face="bold", color="black",size=16))+ theme(axis.text.y = element_text(face="bold", color="black",size=16))+
  theme(axis.title.x = element_text(face="bold", color="black",size=16))+ theme(axis.text.x = element_text(face="bold", color="black",size=16))
res.plot<- ggExtra::ggMarginal(res.plot, type = "densigram")
res.plot

QQ.plot<- ggplot(resdata, aes(sample=std.residuals)) + geom_qq(size = 1.5) + geom_qq_line()+  theme_classic() + theme(panel.grid.major = element_line()) +
  scale_x_continuous(name = "Theorical Quantiles", limits = c(-3, 3), breaks = seq(-3,3,1))+ 
  scale_y_continuous(name = "Standardized Residuals", limits = c(-2.5, 2), breaks = seq(-3,3,1))+
  theme(axis.title.y = element_text(face="bold", color="black",size=16))+ theme(axis.text.y = element_text(face="bold", color="black",size=16))+
  theme(axis.title.x = element_text(face="bold", color="black",size=16))+ theme(axis.text.x = element_text(face="bold", color="black",size=16))
QQ.plot<- ggExtra::ggMarginal(QQ.plot, type = "densigram")
QQ.plot

###### 6) Linear Regression    ###################
##################################################
# Include only microsleep vulnerable drivers
data2 <- subset(data, is.na(data$min.to.Microsleep)==F)


### Baseline
lin.baseline <- lm(min.to.Microsleep ~ 1, data = data2)
summary(lin.baseline)
AIC(lin.baseline)

### Demographics (step 1)
lin.step1 <- lm(min.to.Microsleep ~ Age + Weight + Height + Smoking + Alcohol + DrivingSkills + Total.Value.PSQI + Sleep.deprivation.time, data = data2)
summary(lin.step1)
confint(lin.step1)
vif(lin.step1)
AIC(lin.step1)

### morning KSS (step 2)
lin.step2 <- lm(min.to.Microsleep ~ Age + Weight + Height + Smoking + Alcohol + DrivingSkills + Total.Value.PSQI + Sleep.deprivation.time + KSS.morning, data = data2)
summary(lin.step2)
vif(lin.step2)
AIC(lin.step2)

anova(lin.step1,lin.step2)

### KSS difference (step 3)
lin.step3 <- lm(min.to.Microsleep ~ Age + Weight + Height + Smoking + Alcohol + DrivingSkills + Total.Value.PSQI + Sleep.deprivation.time + KSS.morning + KSS.start.driving, data = data2)
summary(lin.step3)
lm.beta(lin.step3)
vif(lin.step3)
confint(lin.step3)
AIC(lin.step3)

# note that the main effect of KSS.start.driving represents the difference between morning and start driving when KSS.morning is beeing partialed out
anova(lin.step2,lin.step3)

### inter-individual traits (step 4)
lin.full <- update(lin.step3, .~. + Neuroticism..NEOPIR. + Extraversion...NEOPIR. + Openness.to.experience..NEOPIR. + Agreeableness..NEOPIR. + Conscientiousness..NEOPIR. + Sensation.Seeking.Total..SSS. + IQ..SPM.)
summary(lin.full)
lm.beta(lin.full)
vif(lin.full)
confint(lin.full)
AIC(lin.full)

anova(lin.step3, lin.full)
compareLM(lin.step1, lin.step2, lin.step3, lin.full)

### Own functions to standardize b and CI bounds
#standardized beta coefficients
stdz.coff <- function (regmodel)
{ b <- summary(regmodel)$coef[-1,1]
sx <- sapply(regmodel$model[-1], sd)
sy <- sapply(regmodel$model[1], sd)
beta <-b * sx / sy
return(beta)
}
stdz.coff(lin.full) # compare with lm.beta

#function to standardize LLCI
stdz.llci <- function (regmodel)
{ ci <- confint(regmodel)
sx <- sapply(regmodel$model[-1], sd)
sy <- sapply(regmodel$model[1], sd)
beta.llci <-ci[2:nrow(ci),1] * sx / sy
return(beta.llci)
}
stdz.llci(lin.full)

#function to standardize LLCI
stdz.ulci <- function (regmodel)
{ ci <- confint(regmodel)
sx <- sapply(regmodel$model[-1], sd)
sy <- sapply(regmodel$model[1], sd)
beta.ulci <-ci[2:nrow(ci),2] * sx / sy
return(beta.ulci)
}

stdz.ulci(lin.full)

## Forestplot
rows<- list(attr(lin.full$coefficients,"names")[2:18])
CI<-as.data.frame(cbind(stdz.coff(lin.full), stdz.llci(lin.full),stdz.ulci(lin.full)))
colnames(CI)<- c("b", "ll", "ul")

forestplot(rows,
           CI$b,
           CI$ll,
           CI$ul,
           zero = 0,
           clip = c(-1, 1),
           boxsize   = 0.5,
           graphwidth = unit(1.8, 'in'),
           lineheight = unit(0.3,'in'),
           xlab = "Beta [95% CI]",
           txt_gp=fpTxtGp(ticks=gpar(cex=1),
                          xlab=gpar(cex = 1)),
           ci.vertices=TRUE,ci.vertices.height = 0.2,
           col=fpColors(box="black", lines="black", zero = "gray50"),
           colgap=unit(10,"mm"),
           digitsize= 20)


### Final Model
lin.final<- update(lin.step3, .~. +  Conscientiousness..NEOPIR. + IQ..SPM.)
summary(lin.final)
lm.beta(lin.final)
vif(lin.final)
confint(lin.final)
AIC(lin.final)

anova(lin.step1,lin.final)
anova(lin.step3,lin.final)


## Forestplot
rows<- list(attr(lin.final$coefficients,"names")[2:13])
CI<-as.data.frame(cbind(stdz.coff(lin.final), stdz.llci(lin.final),stdz.ulci(lin.final)))
colnames(CI)<- c("b", "ll", "ul")

forestplot(rows,
           CI$b,
           CI$ll,
           CI$ul,
           zero = 0,
           clip = c(-1, 1),
           boxsize   = 0.5,
           graphwidth = unit(1.8, 'in'),
           lineheight = unit(0.3,'in'),
           xlab = "Beta [95% CI]",
           txt_gp=fpTxtGp(ticks=gpar(cex=1),
                          xlab=gpar(cex = 1)),
           ci.vertices=TRUE,ci.vertices.height = 0.2,
           col=fpColors(box="black", lines="black", zero = "gray50"),
           colgap=unit(10,"mm"),
           digitsize= 20)

### Residuals
values<- data2$min.to.Microsleep
C<- data2$Conscientiousness..NEOPIR.
IQ<- data2$IQ..SPM.
skill<- data2$DrivingSkills
predicted<- lin.final$fitted.values
residuals<- lin.final$residuals
std.residuals<-rstandard(lin.final)
resdata<- cbind(values,C, IQ, skill, predicted,residuals,std.residuals)
resdata<- as.data.frame(resdata)

describe(resdata$predicted)
describe(resdata$values)
describe(resdata$C)
describe(resdata$IQ)



res.plot<- ggplot(resdata, aes(std.residuals, predicted)) + geom_point(size=1.5) +
  theme_classic() + theme(panel.grid.major = element_line()) +
  scale_x_continuous(name = "Standardized Residuals", limits = c(-2, 3), breaks = seq(-4,4,1))+ 
  scale_y_continuous(name = "Predicted Time to Microsleep [min]", limits = c(10, 110), breaks = seq(10,110,25))+
  theme(axis.title.y = element_text(face="bold", color="black",size=16))+ theme(axis.text.y = element_text(face="bold", color="black",size=16))+
  theme(axis.title.x = element_text(face="bold", color="black",size=16))+ theme(axis.text.x = element_text(face="bold", color="black",size=16))
res.plot<- ggExtra::ggMarginal(res.plot, type = "densigram")
res.plot

QQ.plot<- ggplot(resdata, aes(sample=std.residuals)) + geom_qq(size = 1.5) + geom_qq_line()+  theme_classic() + theme(panel.grid.major = element_line()) +
  scale_x_continuous(name = "Theorical Quantiles", limits = c(-3, 3), breaks = seq(-3,3,1))+ 
  scale_y_continuous(name = "Standardized Residuals", limits = c(-3, 3), breaks = seq(-3,3,1))+
  theme(axis.title.y = element_text(face="bold", color="black",size=16))+ theme(axis.text.y = element_text(face="bold", color="black",size=16))+
  theme(axis.title.x = element_text(face="bold", color="black",size=16))+ theme(axis.text.x = element_text(face="bold", color="black",size=16))
QQ.plot<- ggExtra::ggMarginal(QQ.plot, type = "densigram")
QQ.plot
#ggsave("residuals.png", width = 13,height = 13, units = "in")

### Prediction
pred.plot<- ggplot(resdata, aes(values, predicted)) + geom_point(size=1.5) +
  theme_classic() + theme(panel.grid.major = element_line()) + geom_smooth(method = "lm", level = 0.95, color = "grey", fill = "grey") +
  scale_x_continuous(name = "Time to Microsleep [min]", limits = c(0, 165), breaks = seq(0,165,25))+ 
  scale_y_continuous(name = "Predicted Time to Microsleep [min]", limits = c(0, 125), breaks = seq(0,165,25))+
  theme(axis.title.y = element_text(face="bold", color="black",size=16))+ theme(axis.text.y = element_text(face="bold", color="black",size=16))+
  theme(axis.title.x = element_text(face="bold", color="black",size=16))+ theme(axis.text.x = element_text(face="bold", color="black",size=16))
pred.plot<- ggExtra::ggMarginal(pred.plot, type = "densigram")
pred.plot

### Parameters
cons.plot<- ggplot(resdata, aes(C, predicted)) + geom_point(size=1.5) +
  theme_classic() + theme(panel.grid.major = element_line()) +geom_smooth(method = "lm", level = 0.95, color = "grey", fill = "grey") +
  scale_x_continuous(name = "Conscientiousness NEOPIR", limits = c(80, 115), breaks = seq(80, 115,10))+ 
  scale_y_continuous(name = "Predicted Time to Microsleep [min]", limits = c(10, 110), breaks = seq(10,110,25))+
  theme(axis.title.y = element_text(face="bold", color="black",size=16))+ theme(axis.text.y = element_text(face="bold", color="black",size=16))+
  theme(axis.title.x = element_text(face="bold", color="black",size=16))+ theme(axis.text.x = element_text(face="bold", color="black",size=16))
cons.plot<- ggExtra::ggMarginal(cons.plot, type = "densigram")
cons.plot

iq.plot<- ggplot(resdata, aes(IQ, predicted)) + geom_point(size=1.5) +
  theme_classic() + theme(panel.grid.major = element_line()) +geom_smooth(method = "lm", level = 0.95, color = "grey", fill = "grey") +
  scale_x_continuous(name = "IQ SPM", limits = c(69, 140), breaks = seq(69, 140,10))+ 
  scale_y_continuous(name = "Predicted Time to Microsleep [min]", limits = c(10, 110), breaks = seq(10,110,25))+
  theme(axis.title.y = element_text(face="bold", color="black",size=16))+ theme(axis.text.y = element_text(face="bold", color="black",size=16))+
  theme(axis.title.x = element_text(face="bold", color="black",size=16))+ theme(axis.text.x = element_text(face="bold", color="black",size=16))
iq.plot<- ggExtra::ggMarginal(iq.plot, type = "densigram")
iq.plot

skill.plot<- ggplot(resdata, aes(skill, predicted)) + geom_point(size=1.5) +
  theme_classic() + theme(panel.grid.major = element_line()) +geom_smooth(method = "lm", level = 0.95, color = "grey", fill = "grey") +
  scale_x_continuous(name = "Driving Skills", limits = c(3, 10), breaks = seq(3, 10,1))+ 
  scale_y_continuous(name = "Predicted Time to Microsleep [min]", limits = c(10, 110), breaks = seq(10,110,25))+
  theme(axis.title.y = element_text(face="bold", color="black",size=16))+ theme(axis.text.y = element_text(face="bold", color="black",size=16))+
  theme(axis.title.x = element_text(face="bold", color="black",size=16))+ theme(axis.text.x = element_text(face="bold", color="black",size=16))
skill.plot<- ggExtra::ggMarginal(skill.plot, type = "densigram")
skill.plot

###### 7) WRS robust functions ###################
##################################################
# manually load all WRS functions from Wilcox 2017
source(file.choose()) # load file 'Rallfun-v37.txt'


###### 8) Robust  Regression   ###################
##################################################
### Robust logistic regression estimations instead ML
# prepare response and predictors in regression as separate matrix y,x
#ylog<-cbind(data$Microsleep.binary)
#xlog<-cbind(data$Age, data$Weight,data$Height,data$Smoking,data$Alcohol,data$DrivingSkills,data$Total.Value.PSQI,data$Sleep.deprivation.time,data$KSS.morning,data$KSS.start.driving,data$Conscientiousness..NEOPIR.,data$Sensation.Seeking.Total..SSS.)

# Robust Generalised linear model
#log.robust<- wlogregci(xlog,ylog,nboot=4,alpha=0.05,xout=F)
##FUNCTION NOT WORKIN???


# Robust Generalised Liear Model for Microsleep Vulnerability method ="Mqle", "BY", "WBY"
data$Microsleep.binary2<- abs(data$Microsleep.binary-1)

log.robust<- glmrob(cbind(Microsleep.binary,Microsleep.binary2) ~ Age + Weight + Height + Smoking + Alcohol + DrivingSkills + Total.Value.PSQI + Sleep.deprivation.time + KSS.morning + KSS.start.driving + Conscientiousness..NEOPIR.  + Sensation.Seeking.Total..SSS.,family = binomial, data = data, method = "Mqle")
summary(log.robust)
# manually transform coefficients
se<- as.data.frame(c(7.36,0.06,0.02,0.04,0.21,0.32,0.17,0.10,0.08,0.14,0.15,0.04,0.04))
colnames(se)<- c("se")
OR<- exp(log.robust$coefficients)
ulci<- log.robust$coefficients + 1.96*se
llci<- log.robust$coefficients - 1.96*se

OR.llci <-as.data.frame(exp(llci)[2:13,1])
OR.ulci <-as.data.frame(exp(ulci)[2:13,1])

## Forestplot log.full
rows<- list(attr(log.robust$coefficients,"names")[2:13])
OR<-as.data.frame(cbind(OR, OR.llci, OR.ulci))
colnames(OR)<- c("odds", "ll", "ul")

forestplot(rows,
           OR$odds,
           OR$ll,
           OR$ul,
           zero = 1,
           clip = c(0.5, 1.6),
           boxsize   = 0.5,
           graphwidth = unit(1.8, 'in'),
           lineheight = unit(0.3,'in'),
           xlab = "Odds ratio [95% CI]",
           txt_gp=fpTxtGp(ticks=gpar(cex=1),
                          xlab=gpar(cex = 1)),
           ci.vertices=TRUE,ci.vertices.height = 0.2,
           col=fpColors(box="black", lines="black", zero = "gray50"),
           colgap=unit(10,"mm"),
           digitsize= 10)


### Robust linear regression estimations instead OLS
# prepare response and predictors in regression as separate matrix y,x
ylin<-as.data.frame(data2$min.to.Microsleep)
xlin<-as.data.frame(cbind(data2$Age, data2$Weight,data2$Height,data2$Smoking,data2$Alcohol,data2$DrivingSkills,data2$Total.Value.PSQI,data2$Sleep.deprivation.time,data2$KSS.morning,data2$KSS.start.driving,data2$Conscientiousness..NEOPIR.,data2$IQ..SPM.))

# Robust Linear Regression with Theil-Sen estimator and Harrel-Davis estimator for intercept
lin.robust<- regci(xlin,ylin,regfun=tshdreg, nboot=2000,alpha=0.05, xout=F)
summary(lin.robust)

# extract coefficients for standardisation
llci<- as.data.frame(lin.robust$regci[,1])
ulci<- as.data.frame(lin.robust$regci[,2])
b<- as.data.frame(lin.robust$regci[,3])

sx <- sapply(xlin, sd)
sy <- sapply(ylin, sd)
beta.llci <-llci * sx / sy
beta.ulci <-ulci * sx / sy
beta.b <-b * sx / sy

## Forestplot
rows<- rownames(b)
CI<-as.data.frame(cbind(beta.b, beta.llci,beta.ulci))
colnames(CI)<- c("b", "ll", "ul")

forestplot(rows,
           CI$b,
           CI$ll,
           CI$ul,
           zero = 0,
           clip = c(-1.5, 1),
           boxsize   = 0.5,
           graphwidth = unit(1.8, 'in'),
           lineheight = unit(0.3,'in'),
           xlab = "Beta [95% CI]",
           txt_gp=fpTxtGp(ticks=gpar(cex=1),
                          xlab=gpar(cex = 1)),
           ci.vertices=TRUE,ci.vertices.height = 0.2,
           col=fpColors(box="black", lines="black", zero = "gray50"),
           colgap=unit(10,"mm"),
           digitsize= 20)


###### 9) REVIEWER CHECKS      ###################
##################################################
wd <- choose_dir()
setwd(wd)
datax <- fread("rawData.csv")

str(datax)
hist(datax$delay)

# delay in start driving influenced slee deprivation time
plot(datax$delay, datax$`Sleep deprivation time`)
corr.test(datax$delay, datax$`Sleep deprivation time`, method = "pearson")

# after controling the effect of delay over the mediator total Sleep deprivation 
# no significant effect of delay on sleepiness at start drivig nor on min to microsleep
KSS <- lm(`KSS start driving`  ~ delay  + `Sleep deprivation time`, data = datax)
summary(KSS)
anova(KSS)

microsleep <- lm(`min to Microsleep` ~ delay  + `Sleep deprivation time`, data = datax)
summary(microsleep)
anova(microsleep)


