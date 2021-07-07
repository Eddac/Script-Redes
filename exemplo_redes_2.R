## Emanuel Cordeiro

## Carregamento de pacotes
library(tidyverse)
library(tidytext)
library(tm)
library(widyr)
library(igraph)
library(ggraph)

# Modelo simples
df <- tribble(~coment,
              'Esse é um texto teste, que tem a finalidade de construir um bigrama para formar uma rede em grafo',
              'Os textos produzidos são bons',
              'A finalidade de escrever artigos é produzir divulgação científica',
              'O bigrama ajuda a entender a rede',
              'O grafo é fácil de olhar visualmente',
              'O texto é bonito')
# Formando bigrama
dfbig <- df %>% unnest_tokens(word, coment, token = 'ngrams', n = 2)

# Separando colunas
dfbigsep <- dfbig %>% separate(word, c('word1', 'word2'), sep = " ")

# Contagem de pares
dfbigsepcount <- dfbigsep %>%
  count(word1, word2, sort = TRUE)

## Plot do Grafo de Palavras -----
dfbigsepcount %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = n, edge_width = n)) +
  geom_node_point(color = "darkslategray4", size = 3) +
  geom_node_text(color = "red", aes(label = name), vjust = 3.5, size=3) +
  labs(title= "Grafo",
       subtitle = "Teste",
       x = "", y = "")


