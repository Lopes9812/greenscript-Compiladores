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
- Garantir o funcionamento com ficheiros vazios e
