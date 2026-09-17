library(targets)

tar_source("R")

list(
  tar_target(
    arquivo,
    "dados/airquality.csv",
    format = "file"
  ),

  tar_target(
    dados,
    ler_dados(arquivo)
  ),

  tar_target(
    medias,
    medias_mensais(dados)
  ),

  tar_target(
    modelo,
    ajustar_modelo(dados)
  ),

  tar_target(
    figura,
    salvar_figura(
      dados,
      modelo,
      "saidas/solar_wind.png"
    ),
    format = "file"
  ),

  tar_target(
    medias_csv,
    salvar_medias(
      medias,
      "saidas/medias_solar_wind.csv"
    ),
    format = "file"
  )
)
