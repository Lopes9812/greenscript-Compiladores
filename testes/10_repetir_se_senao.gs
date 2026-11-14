# Repeticao contendo SE e SENAO
REPETIR(5) {
  SE (HUMIDADE(2) < 30) {
    REGAR(2,15);
  } SENAO {
    ESPERAR(60);
  }
}
