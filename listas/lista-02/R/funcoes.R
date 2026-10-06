## Lê o CSV e acrescenta o nome do mês como fator.
ler_dados <- function(arquivo) {
  dados <- read.csv(arquivo)
  dados$Month_name <- factor(
  dados$Month,
  levels = 5:9,
  labels = month.name[5:9]
)
  dados
}

## Calcula as médias mensais de Solar.R e Wind.
medias_mensais <- function(dados) {
  aggregate(
  cbind(Solar.R, Wind) ~ Month_name,
  data = dados,
  FUN = mean,
  na.rm = TRUE,
  na.action = na.pass
)
}

## Ajusta o modelo linear Solar.R em função de Wind.
ajustar_modelo <- function(dados) {
  lm(Solar.R ~ Wind, data = dados)
}

## Desenha a dispersão com a reta ajustada e grava um PNG.
salvar_figura <- function(dados, modelo, arquivo) {
  dir.create(dirname(arquivo), showWarnings = FALSE, recursive = TRUE)
  png(arquivo, width = 800, height = 600)
  
  plot(
    dados$Wind,
    dados$Solar.R,
    xlab = "Wind",
    ylab = "Solar.R",
    main = "Solar.R versus Wind"
  )
  
  abline(modelo)
  dev.off()
  
  arquivo
}

## Grava as médias mensais em um CSV e devolve o caminho do arquivo.
salvar_medias <- function(medias, arquivo) {
dir.create(dirname(arquivo), showWarnings = FALSE, recursive = TRUE)
write.csv(medias, arquivo, row.names = FALSE)
  arquivo
}

