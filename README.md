# GreenScript — Analisador lexical

O scanner é implementado em `src/greenscript.l`, usando Flex. Reconhece as palavras reservadas, identificadores de estufa, inteiros, operadores, delimitadores e comentários da linguagem.

## Regras principais

- Um identificador de estufa válido tem a forma `EST-AA01`.
- Um candidato iniciado por `EST-` é lido por inteiro; se não corresponder ao formato válido, produz um único erro lexical.
- Os restantes candidatos são formados por letras, algarismos e underscore. Candidatos inválidos são reportados como uma unidade.
- O hífen é o operador `MENOS`, pelo que expressões como `10-2` são separadas em três tokens.
- Os operadores `+` e `*` correspondem a `MAIS` e `VEZES`.
- Comentários de linha (`#` e `//`) e de bloco (`/* ... */`) são ignorados. Um comentário de bloco sem fecho é um erro lexical.
- Um carácter UTF-8 válido fora da linguagem é reportado como um único erro.

## Compilação e testes

A compilação isolada permite verificar o fluxo de tokens e executar os testes lexicais:

```sh
cd src
make
cd ..
sh testes/run_tests.sh
```

Depois de existir `src/greenscript.y`, o scanner pode ser ligado ao Bison com:

```sh
cd src
make tp2
```

No modo isolado, o scanner imprime os tokens e contabiliza todos os erros encontrados. No modo Bison, não tem `main()` nem imprime tokens: devolve os códigos de token ao parser e termina a leitura no primeiro erro lexical.

No modo Bison, o scanner define a variável global `erro_lexico` e devolve EOF depois de apresentar o primeiro erro. O `yyerror()` do parser deve verificar esta variável para não apresentar também uma mensagem de erro sintático para o mesmo problema. O `main()` do parser deve considerar o ficheiro inválido sempre que `erro_lexico` estiver ativa, mesmo que `yyparse()` devolva sucesso.

## Estrutura

```
src/greenscript.l   scanner Flex
src/Makefile        compilação isolada e integração com Bison
testes/             ficheiros .gs e resultados .esp
```
