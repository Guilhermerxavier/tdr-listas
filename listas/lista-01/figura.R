dados <- read.csv("airquality.csv")

pdf("figura.pdf")

boxplot(
  Ozone ~ Month,
  data = dados,
  main = "Distribuição de Ozone por mês",
  xlab = "Mês",
  ylab = "Ozone",
  na.action = na.omit
)

dev.off()


