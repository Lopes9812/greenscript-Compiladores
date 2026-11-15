# GreenScript — TP1

## 1. Objetivo do projeto

Desenvolver um scanner lexical para a linguagem GreenScript, utilizando **FLEX**, com um formato de saída comum para os testes, o scanner e o relatório.

O projeto está dividido em três áreas de trabalho: implementação do scanner, documentação teórica e preparação dos testes e da entrega.

## 2. Decisões comuns

As seguintes decisões devem ser respeitadas por todos os elementos do grupo, garantindo a compatibilidade entre o scanner, os testes e o relatório.

| Item | Decisão |
|---|---|
| Executável | `greenscript` |
| Execução | `./greenscript ficheiro.gs` |
| Ficheiros de entrada | `.gs` |
| Ficheiros de resultados esperados | `.esp` |
| Formato de cada token | `linha CATEGORIA lexema` |
| Separação dos campos | Um espaço |
| Número da linha | Linha de início do lexema |
| Formato de erro | `ERRO lexical na linha N: 'lexema'` |
| Resumo final | `Tokens: N \| Erros lexicais: M` |
| Categoria do token | O próprio nome da categoria, por exemplo, `LIGAR`, `SENAO` ou `ID_ESTUFA` |

### 2.1. Categorias dos tokens

| Lexema | Categoria |
|---|---|
| `EST-AB07` | `ID_ESTUFA` |
| `0`, `15`, `300` | `INTEIRO` |
| `<` | `MENOR` |
| `<=` | `MENOR_IGUAL` |
| `>` | `MAIOR` |
| `>=` | `MAIOR_IGUAL` |
| `==` | `IGUAL` |
| `!=` | `DIFERENTE` |
| `(` | `ABRE_PAR` |
| `)` | `FECHA_PAR` |
| `{` | `ABRE_CHAVETA` |
| `}` | `FECHA_CHAVETA` |
| `,` | `VIRGULA` |
| `;` | `PONTO_VIRG` |

As palavras reservadas devem utilizar como categoria o próprio lexema, conforme definido no enunciado.

### 2.2. Regras gerais do scanner

- Ignorar espaços, tabulações, `\r`, `\n` e comentários iniciados por `#` até ao fim da linha.
- Reconhecer as 12 palavras reservadas, os identificadores de estufa, os inteiros, os delimitadores e os seis operadores relacionais.
- Reconhecer candidatos lexicais inválidos com a expressão `[A-Za-z0-9_-]+`, emitindo um único erro por candidato.
- Tratar qualquer outro carácter isolado como um erro lexical.
- Manter corretamente o número da linha, incluindo em ficheiros com finais de linha CRLF.
- Tratar um carácter UTF-8 multibyte (por exemplo, `§`) como um único erro lexical.
- Garantir o funcionamento com ficheiros vazios e com ficheiros sem mudança de linha final.

## 3. Estrutura do projeto

```
src/greenscript.l   código-fonte FLEX do analisador
src/Makefile        compilação
testes/             ficheiros de entrada (.gs), resultados esperados (.esp) e run_tests.sh
README.md           este ficheiro
```

## 4. Ferramentas utilizadas

- FLEX 2.6.4
- GCC (testado com GCC 13)
- `make` e `sh` (para compilar e executar os testes)

## 5. Compilação e execução

```sh
cd src
make                          # gera o executável ./greenscript
./greenscript ../testes/12_exemplo_enunciado.gs
make clean                    # remove lex.yy.c e o executável
```

O programa recebe o caminho do ficheiro como argumento e termina com código de saída diferente de zero se existirem erros lexicais.

## 6. Testes

```sh
sh testes/run_tests.sh
```

O script compila o analisador, executa cada ficheiro `.gs` e compara a saída com o `.esp` correspondente. Resultado atual: 12/12 testes passam.

## 7. Fontes

Ferramentas e bibliotecas utilizadas: FLEX e a biblioteca standard do C. Outras fontes estão identificadas no relatório.
