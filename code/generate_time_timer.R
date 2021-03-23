library(tidyverse)
library(gganimate)

# Create Data
data <- tibble(
  percent_done = seq(from = 0, to = 100, length.out = cs + 1),
  time_elapsed = seq(from = 0, to = cs, by = 1), 
  time_remaining = seq(from = cs, to = 0, by = -1)
) %>% 
  pivot_longer(cols = -"percent_done", names_to = "label", values_to = "time")

# Basic piechart
plot <- 
  data %>% 
  #filter(percent_done == 75) %>% #for testing
  ggplot(aes(x="", y=time, fill = label)) +
  geom_bar(stat="identity", width=1) + #, color="white"
  coord_polar("y", start=0, direction = -1) +
  theme_void() + # remove background, grid, numeric labels
  theme(legend.position="none") +
  scale_fill_manual(values = c("white", "firebrick")) +
  transition_time(percent_done) +
  NULL #for testing


sec = 10
nframes_calc <- sec * fps_calc #140
fps_calc <- 20 #nframes_calc / sec

gganimate::animate(plot,
                   renderer = magick_renderer(loop = FALSE), 
                   nframes = nframes_calc, #default is 100
                   fps = fps_calc # default 10 (20, 25)
)

anim_save(filename = glue::glue("{sec}_sec.gif"), path = here::here("www")) 

#3sec nframes = 150, fps = 50
#4sec nframes = 100, fps = 25
#5sec nframes = 100, fps = 20
#6sec nframes = 120, fps = 20
#7sec nframes = 140, fps = 20
#...hold at 20fps and increase frames

# Fun to write the rest of the files up to 20sec
# sec_vec = 11:20
# time_timer <- function(sec) {
# nframes_calc <- sec * fps_calc #140
# fps_calc <- 20 #nframes_calc / sec
# 
# gganimate::animate(plot,
#                    renderer = magick_renderer(loop = FALSE), 
#                    nframes = nframes_calc, #default is 100
#                    fps = fps_calc # default 10 (20, 25)
# )
# 
# anim_save(filename = glue::glue("{sec}_sec.gif"), path = here::here("timer")) 
# }
# 
# sec_vec %>% 
#   walk(~ time_timer(.x))


