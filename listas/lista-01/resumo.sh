#!/bin/bash
set -euo pipefail

if [ "$#" -lt 2 ]; then
    echo "Uso: $0 arquivo.csv numero_da_coluna" >&2
    exit 1
fi

arquivo="$1"
coluna="$2"

nome_coluna=$(head -n 1 "$arquivo" | cut -d',' -f"$coluna" | tr -d '"')
observacoes=$(($(wc -l < "$arquivo") - 1))

na=$(awk -F',' -v c="$coluna" '
NR > 1 && $c == "NA" { n++ }
END { print n+0 }
' "$arquivo")

echo "Coluna: $nome_coluna"
echo "Observações: $observacoes"
echo "Valores NA: $na"
echo "Média por mês:"

awk -F',' -v c="$coluna" '
NR == 1 {
    for (i = 1; i <= NF; i++) {
        gsub(/"/, "", $i)
        if ($i == "Month")
            mes = i
    }
    next
}

$c != "NA" {
    soma[$mes] += $c
    n[$mes]++
}

END {
    for (m = 5; m <= 9; m++) {
        if (n[m] > 0)
            printf "Mês %d: %.2f (%d dias)\n", m, soma[m] / n[m], n[m]
    }
}
' "$arquivo"


