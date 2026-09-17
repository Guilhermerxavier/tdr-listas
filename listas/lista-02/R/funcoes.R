## Lê o CSV e acrescenta o nome do mês como fator.
ler_dados <- function(arquivo) {
  dados <- read.csv(arquivo)
  dados$Month <- factor(
    dados$Month,
    levels = 1:12,
    labels = month.name
  )
  dados
}

## Calcula as médias mensais de Solar.R e Wind.
medias_mensais <- function(dados) {
  aggregate(
    cbind(Solar.R, Wind) ~ Month,
    data = dados,
    FUN = mean,
    na.rm = TRUE
  )
}

## Ajusta o modelo linear Solar.R em função de Wind.
ajustar_modelo <- function(dados) {
  lm(Solar.R ~ Wind, data = dados)
}

## Desenha a dispersão com a reta ajustada e grava um PNG.
salvar_figura <- function(dados, modelo, arquivo) {
  png(arquivo, width = 800, height = 600)
  
  plot(
    dados$Wind,
    dados$Solar.R,
    xlab = "Wind",
    ylab = "Solar.R",
    main = "Solar.R em função de Wind"
  )
  
  abline(modelo)
  dev.off()
  
  arquivo
}
