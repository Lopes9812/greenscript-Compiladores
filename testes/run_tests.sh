#!/bin/sh
# Compila o scanner e compara a saida de cada .gs com o respetivo .esp
cd "$(dirname "$0")" || exit 1
(cd ../src && make -s 2>/dev/null) || { echo "Erro ao compilar"; exit 1; }
ok=0; falhou=0
for f in *.gs; do
    if ../src/greenscript "$f" | diff -q - "${f%.gs}.esp" >/dev/null; then
        echo "OK    $f"; ok=$((ok+1))
    else
        echo "FALHA $f   (ver: ../src/greenscript $f | diff - ${f%.gs}.esp)"; falhou=$((falhou+1))
    fi
done
echo "Passaram: $ok | Falharam: $falhou"
[ "$falhou" -eq 0 ]
