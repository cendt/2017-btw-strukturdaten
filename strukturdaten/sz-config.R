# Packages
# data wrangling
library(dplyr)
library(magrittr)
library(tidyr)
library(purrr)

# graphics
library(ggplot2)
library(directlabels)
library(grid)

# import
library(googlesheets)


party_colors = c(
  "AfD" = "#4093B2",
  "CDU/CSU" = "#333333",
  "FDP" = "#F6CE5E",
  "Grüne" = "#60A961",
  "Linke" = "#B53360",
  "SPD" = "#E53E44",
  "Sonstige" = "#999999"
)
sz_greens = c("#00B0A9", "#66C0BA", "#97D0CC", "#BEE0DD")
sz_font_family = "SZoSansCond-Light"
sz_font_family_geom_text = "SZoSansCond-Regular"
sz_font_size = 18
sz_font_size_geom_text = 6.35
sz_line_size = .2
sz_line_color = "#999999"


### sz base theme

sztheme_base <- theme(
  strip.background = element_blank(),
  strip.text.y = element_blank(),
  strip.text.x = element_blank(),
  axis.text = element_text(family = sz_font_family, size = sz_font_size),
  panel.background = element_blank(),
  panel.border = element_blank(),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  legend.position = "none",
  plot.background = element_blank(),
  plot.margin = unit(c(0, 0, 0, 0), "in")
)

sztheme_caption <- theme(
  plot.caption = element_text(family = sz_font_family, size = sz_font_size, hjust = 1, vjust = -2, colour = sz_line_color)
)


### Bar Chart
sztheme_bars <- theme(
  axis.title = element_blank(),
  axis.text.x = element_blank(),
  axis.ticks = element_blank(),
  legend.position = "none"
)

sztheme_barchart_vertical <- theme(
  axis.ticks = element_blank(),
  axis.title = element_blank(),
  panel.grid.major.y = element_line(color = sz_line_color, size = sz_line_size),
  panel.grid.major.x = element_blank(),
  plot.margin = unit(c(0, 0, 0.1, 0), "in"),
  legend.position = "none"
)

sztheme_barchart_win_loss <- theme(
  axis.ticks = element_blank(),
  axis.text.y = element_blank(),
  panel.grid.major.y = element_blank()
)

sztheme_barchart_mobile <- theme(
  plot.margin = unit(c(0, 0, 0.1, 0), "in")
)

### Teaser Chart
sztheme_teaser <- theme(
  axis.text = element_blank(),
  axis.line.y = element_blank(),
  axis.ticks = element_blank()
)

### Scatter Plot
sztheme_scatter <- theme(
  strip.background = element_blank(),
  strip.text.y = element_blank(),
  strip.text.x = element_blank(),
  axis.ticks = element_line(color = sz_line_color, size = sz_line_size),
  axis.ticks.length = unit(0.1, "in"),
  #axis.title = element_blank(),
  #axis.title.x = element_blank(),
  #axis.title.y = element_blank(),
  panel.background = element_blank(),
  panel.border = element_blank(),
  panel.grid.major = element_line(color = sz_line_color, size = sz_line_size),
  panel.grid.major.y = element_line(color = sz_line_color, size = sz_line_size),
  panel.grid.major.x = element_line(color = sz_line_color, size = sz_line_size),
  panel.grid.minor = element_blank(),
  panel.grid.minor.y = element_blank(),
  plot.margin = unit(c(0.3, 0.2, 0.1, 0.1), "in")
)

## Seats
sztheme_seats <- theme(
  panel.grid.major = element_blank(),
  panel.grid.major.y = element_blank(),
  panel.grid.major.x = element_blank(),
  panel.grid.minor = element_blank(),
  panel.grid.minor.y = element_blank(),
  panel.grid.minor.x = element_blank(),
  axis.ticks = element_blank(),
  axis.text = element_blank()
)


# Stacked Bar Chart
sztheme_stacked <- theme(
  legend.position = "top",
  legend.title = element_blank(),
  legend.text = element_text(family = sz_font_family, size = sz_font_size, hjust = 1, vjust = -3)
)
