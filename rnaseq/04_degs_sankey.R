library(ggforce)
library(ggplot2)

sig <- as.data.frame(read.csv('/DATA/users/magnitov/znf143/rnaseq/degs/df_for_sankey.tsv', 
                              sep = "\t"))

ggplot(sig, aes(x = Timepoint, id = id, split = cat, value = 1)) +
  geom_parallel_sets(
    aes(fill = after_stat(split)),
    alpha = 0.5, axis.width = 0.25
  ) +
  geom_parallel_sets_axes(
    axis.width = 0.25,
    aes(fill = after_stat(label))
  ) +
  geom_parallel_sets_labels(
    aes(label = after_stat(value))
  ) +
  scale_fill_manual(
    values = c("Down" = "#66A61E", "n.s." = "grey80", "Up" = "#E72A8A"),
    name = "Direction"
  ) +
  guides(y = "none") +
  theme(
    axis.line.x.bottom = element_blank(),
    axis.ticks.x = element_blank(),
    panel.grid.major = element_blank()
  ) +
  theme_classic()

ggsave("/DATA/users/magnitov/znf143/figures/sankey_rnaseq_zfp143_long_term.pdf", width = 4.5, height = 4)