# ME918_2024S2_ATV_IV
# Dashboard ME918 - Trabalho 4

## Descrição do Projeto

Este projeto foi desenvolvido como parte do trabalho 4 da disciplina *ME918* da Universidade Estadual de Campinas (UNICAMP). A aplicação web permite a visualização e análise interativa de dados a partir de um arquivo CSV carregado pelo usuário. 

O usuário pode realizar as seguintes operações:

- Fazer login com um e-mail e senha predefinidos.
- Carregar um arquivo CSV contendo um dataset.
- Visualizar um resumo estatístico básico dos dados.
- Gerar gráficos de dispersão interativos para explorar as relações entre variáveis do dataset.
- Baixar os dados processados em formato CSV.

A interface é construída usando o pacote *Shiny* do R, com um design moderno baseado no *bs4Dash*, que oferece componentes visuais semelhantes ao Bootstrap 4.

## Funcionalidades do Dashboard

1. **Sistema de Login**
   - Para acessar o dashboard, o usuário deve inserir as credenciais válidas:
     - **Usuário:** `me918@unicamp.br`
     - **Senha:** `projeto4`
   - Caso as credenciais estejam incorretas, o sistema notifica o usuário.

2. **Upload de Arquivos**
   - O usuário pode carregar arquivos CSV para análise. Caso nenhum arquivo seja carregado, o dataset padrão utilizado será o `mtcars`.

3. **Análise Exploratória**
   - **Resumo dos Dados:** Exibição de estatísticas descritivas como mínimo, máximo, média, e mediana das variáveis presentes no dataset.
   - **Gráfico de Dispersão:** Gráfico interativo que relaciona duas variáveis do dataset (escolhidas pelo usuário).

4. **Visualização de Dados**
   - **Tabela Completa:** Exibição completa dos dados carregados em uma tabela interativa utilizando o pacote `DT`.

5. **Download dos Dados**
   - O usuário pode baixar o dataset processado em formato CSV.

## Ferramentas e Bibliotecas

- **Linguagem de Programação:** R
- **Pacotes R:** 
  - `shiny`
  - `bs4Dash`
  - `dplyr`
  - `ggplot2`
  - `DT`
- **Interface de Usuário:** Construída com o pacote `bs4Dash` para um layout moderno e responsivo.

## Como Executar o Projeto

### Pré-requisitos

Certifique-se de que você tem o R e o RStudio instalados em sua máquina, além dos seguintes pacotes:

- `readxl`, `dplyr`, `ggplot2`, `tidyverse`, `likert`, `FactoMineR`, `factoextra`, `htmltools`, `base64enc`, `plotly`, `shiny`, `DT`, `bs4Dash`

Caso não possua algum pacote, ele será automaticamente instalado ao rodar o código através da função `verificaPckg`.

### Passos para Execução

1. Salve o código em um arquivo com extensão `.R` (ex.: `app.R`).
2. Abra o arquivo no RStudio.
3. Execute o código no console utilizando o comando:
   ```R
   shiny::runApp()

