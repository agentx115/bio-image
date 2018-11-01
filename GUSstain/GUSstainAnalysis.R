library(tidyverse)

####Initialise data####
gus_stains = read_csv("GUS_presence.csv")
View(gus_stains)

gus_stains$logTreatment = log(gus_stains$Treatment)
gus_stains$sqrtTreatment = sqrt(gus_stains$Treatment)

gus_clean = filter(gus_stains, X1 != 18 ) #this one is visually odd looking
View(gus_clean)

####Assign columns####
noZero = filter(gus_clean, Treatment > 0)
noZero$PercentDark2 = noZero$PercentDark/100
blueperc = filter(noZero, logTreatment < -0.5)


####Linear models####
par(mfrow=c(2,2)) #set up for qq plots

gusLM = lm(PercentDark ~ logTreatment, data = noZero)
summary(gusLM)
plot(gusLM)

blueLM = lm(PercentBlue ~ logTreatment, data = blueperc)
summary(blueLM)
plot(blueLM)

####Scatter plots####
ggplot(noZero, aes(x=logTreatment, y = PercentDark))+
  geom_point() +
  stat_smooth() 
  
ggplot(noZero, aes(x=logTreatment, y = PercentBlue))+
  geom_point() +
  stat_smooth() 

####Box Plots####
noZero$TreatmentFactor = as.factor(noZero$logTreatment)
ggplot(noZero, aes(x=TreatmentFactor, y = PercentDark))+
  geom_boxplot()

TreatmentDecimal = c(-5.08, -4.38, -3.69, -3.00, -2.30, -1.61, -0.92, -0.22, 0.47, 1.16, 1.61)
ggplot(noZero, aes(x=TreatmentFactor, y = PercentBlue))+
  geom_boxplot() +
  theme_classic() +
  scale_x_discrete(name = "log Treament (mM)", labels = TreatmentDecimal) +
  ylab("Percent blue pixels (%)")

####ANOVA####
blueperc$TreatmentFactor = as.factor(blueperc$logTreatment)
aovLM = lm(PercentBlue ~ TreatmentFactor, data = blueperc)
anova(aovLM)

a1 = aov(PercentBlue ~ TreatmentFactor, data = blueperc)
posthoc = TukeyHSD(x = a1, 'TreatmentFactor', conf.level = 0.95)
posthoc
