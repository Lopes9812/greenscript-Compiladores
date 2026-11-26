# GreenScript — Analisador lexical

O scanner está em `src/greenscript.l` e é gerado pelo Flex.

## Regras principais

- Um identificador de estufa válido tem a forma `EST-AA01`.
- Um candidato iniciado por `EST-` é lido por inteiro. Se não tiver o formato válido, gera um único erro lexical.
- Os restantes candidatos são formados por letras, algarismos e underscore.
- O hífen é o operador `MENOS`; `10-2` corresponde a três tokens.
- Os operadores `+` e `*` correspondem a `MAIS` e `VEZES`.
- Os comentários `#`, `//` e `/* ... */` são ignorados.
- Um comentário de bloco sem fecho é um erro lexical.
- Um carácter UTF-8 válido fora da linguagem conta como um único erro.

## Compilar e executar

```sh
cd src
make
./greenscript ../testes/12_exemplo_enunciado.gs
```

O nome do ficheiro é passado ao programa na linha de comandos. Em `main(int argc, char *argv[])`, `argc` conta os argumentos e `argv[1]` contém o caminho do ficheiro. É por isso que a verificação `argc != 2` confirma que foi indicado exatamente um ficheiro.

Para executar os testes:

```sh
cd ..
sh testes/run_tests.sh
```

## Integração com o Bison

Quando existir `src/greenscript.y`, a integração é feita com:

```sh
cd src
make tp2
```

Nesse modo, o scanner não contém `main()` e cada regra devolve diretamente o token ao parser. O primeiro erro lexical define `erro_lexico` e termina a leitura. O `yyerror()` deve consultar essa variável para não duplicar a mensagem de erro.

## Estrutura

```
src/greenscript.l   scanner Flex
src/Makefile        compilação isolada e integração com Bison
testes/             ficheiros de entrada e resultados esperados
```
