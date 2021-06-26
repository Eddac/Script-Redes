## Emanuel Cordeiro

## Construção do Bigrama ----
depressaobigrama <- depressaoclean %>%
  dplyr::select(word) %>%
  unnest_tokens(paired_words, word, token = "ngrams", n = 2)

search_reforma_paired_words %>%
  count(paired_words, sort = TRUE)

## separando o bigrama em duas colunas ----
search_reforma_separated_words <- search_reforma_paired_words %>%
  +   separate(paired_words, c("word1", "word2"), sep = " ")

teste <- separate(search_reforma_paired_words$paired_words, into = colunas, sep = " ", remove = FALSE,
                  extra = "merge")

search_depressao_filtered <- depressaoseparado %>%
  filter(!A %in% stop_words$word) %>%
  filter(!B %in% stop_words$word)

## Nova contagem de bigrama -----
depressaocounts <- search_depressao_filtered %>%
  count(A, B, sort = TRUE)


head(depressaocounts)

## Plot do Grafo de Palavras -----
depressaocounts %>%
  filter(n >= 20) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = n, edge_width = n)) +
  geom_node_point(color = "darkslategray4", size = 3) +
  geom_node_text(color = "red", aes(label = name), vjust = 3.5, size=3) +
  labs(title= "Grafo de Palavras: Depress?o ",
       subtitle = "Text mining de dados do Twitter usando o R ",
       x = "", y = "")