# Condicao com SENAO e todos os operadores relacionais
SE (HUMIDADE(2) < 30) { REGAR(2,15); } SENAO { ESPERAR(60); }
SE (HUMIDADE(1) <= 40) { PARAR(); }
SE (HUMIDADE(3) > 70) { FECHAR(); }
SE (HUMIDADE(3) >= 80) { FECHAR(); }
SE (HUMIDADE(4) == 50) { ESPERAR(5); }
SE (HUMIDADE(4) != 50) { ESPERAR(5); }
# Sem espacos entre operandos e operadores
HUMIDADE(2)<=30
HUMIDADE(2)<30
HUMIDADE(2)>=30
HUMIDADE(2)>30
HUMIDADE(2)==30
HUMIDADE(2)!=30
