export_plots <- function(plotname) {
  #ggsave(plot = plot, filename = paste0("output/laender/desktop/", plotname, ".png"), dpi = 144, width = 8.89, height = 3.0)
  #ggsave(plot = mobile_plot, filename = paste0("output/laender/mobil/", plotname, ".png"), dpi = 144, width = 5.0, height = 3.0)
  #ggsave(plot = teaser_plot, filename = paste0("output_img/teaser/", plotname ,"-teaser.png"), dpi = 144, width = 8.89, height = 3.0)
  #ggsave(plot = social_plot, filename = paste0("output_img/social/", plotname ,"-social.png"), dpi = 144, width = 6, height = 6)
  ggsave(plot = plot, filename = paste0("output/scatter/svg/", plotname ,".svg"), dpi = 144, width = 8.89, height = 3.0)
  #ggsave(plot = plot, filename = paste0("output_img/hp-desktop/", plotname ,".png"), dpi = 144, width = 7.778, height = 2.8)
  #ggsave(plot = plot, filename = paste0("output_img/hp-mobil/", plotname ,".png"), dpi = 144, width = 5.0, height = 2.5)
}

export_scatter <- function(plotname) {
  #ggsave(plot = plot, filename = paste0("output/scatter/desktop/", plotname, ".png"), dpi = 144, width = 8.89, height = 5.0)
  #ggsave(plot = mobile_plot, filename = paste0("output/scatter/mobil/", plotname, ".png"), dpi = 144, width = 5.0, height = 3.0)
  #ggsave(plot = teaser_plot, filename = paste0("output_img/teaser/", plotname ,"-teaser.png"), dpi = 144, width = 8.89, height = 3.0)
  #ggsave(plot = social_plot, filename = paste0("output_img/social/", plotname ,"-social.png"), dpi = 144, width = 6, height = 6)
 ggsave(plot = plot, filename = paste0("output/scatter/svg/", plotname ,".svg"), dpi = 144, width = 8.89, height = 3.0)
  #ggsave(plot = plot, filename = paste0("output_img/hp-desktop/", plotname ,".png"), dpi = 144, width = 7.778, height = 2.8)
  #ggsave(plot = plot, filename = paste0("output_img/hp-mobil/", plotname ,".png"), dpi = 144, width = 5.0, height = 2.5)
}
