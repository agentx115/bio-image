library(tidyverse)

gus_stains = read_csv("GUS_presence.csv")
View(gus_stains)

gus_stains$logTreatment = log(gus_stains$Treatment)
gus_stains$sqrtTreatment = sqrt(gus_stains$Treatment)

gusLM = lm(PercentDark ~ logTreatment, data = gus_stains)
summary(gusLM)

plot(gusLM)

noZero = filter(gus_stains, Treatment > 0)

ggplot(noZero, aes(x=logTreatment, y = PercentDark))+
  geom_point() +
  stat_smooth()
  
