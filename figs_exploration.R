#--
# Exploratory figures
#
#--


library(patchwork)


# Thalassia coverage along transects
windows(height=3.5, width=5)
ggplot(df %>%
         mutate(transect_distance_m = if_else(transect_position=="below", transect_distance_m * -1, transect_distance_m))) +
  # 
  geom_line(aes(x = transect_distance_m, y = cover_Tt, group = transect_id, color = site_location, linetype = transect_position)) +
  geom_point(aes(x = transect_distance_m, y = cover_Tt, color = site_location, shape = transect_position)) +
  #
  # scale_x_continuous(name = "Distance (m)", limits = c(0, 10), breaks = seq(1, 9, 2)) +
  scale_y_continuous(name = "Thalassa % cover") +
  theme_classic()


# Live lucinids above vs below
windows(height=4, width=6)
ggplot(df %>%
         summarize(live_lucinid_num = sum(live_lucinid_num), .by = 'transect_position')) +
  #
  geom_col(aes(x = transect_position, y = live_lucinid_num)) +
  #
  theme_classic()


# Live lucinids by distance along transect
windows(height=3.5, width=5)
ggplot(df %>%
         group_by(transect_position, transect_distance_m) %>%
         summarize(live_lucinid_num = sum(live_lucinid_num)) %>%
         ungroup() %>%
         mutate(transect_distance_m = if_else(transect_position=="below", transect_distance_m * -1, transect_distance_m))) +
  # 
  geom_point(aes(x = transect_distance_m, y = live_lucinid_num, color = transect_position), size=2) +
  geom_line(aes(x = transect_distance_m, y = live_lucinid_num, color = transect_position, group = transect_position)) +
  #
  theme_classic()


# Dead lucinids by distance along transect
windows(height=3.5, width=5)
ggplot(df %>%
         group_by(transect_position, transect_distance_m) %>%
         summarize(dead_lucinid_num = sum(dead_lucinid_num)) %>%
         ungroup() %>%
         mutate(transect_distance_m = if_else(transect_position=="below", transect_distance_m * -1, transect_distance_m))) +
  # 
  geom_point(aes(x = transect_distance_m, y = dead_lucinid_num, color = transect_position), size=2) +
  geom_line(aes(x = transect_distance_m, y = dead_lucinid_num, color = transect_position, group = transect_position)) +
  #
  theme_classic()
 
  
# Live lucinids vs Thalassia cover (above erosion edges)
windows(height=4, width=6)
ggplot(df) +
  #
  geom_point(aes(x = cover_Tt, y = live_lucinid_num, color=transect_position), size=2) +
  #
  theme_classic()


# Live lucinids vs seagrass cover (above erosion edges)
windows(height=4, width=6)
ggplot(df) +
  #
  geom_point(aes(x = cover_sg_tot, y = live_lucinid_num, color=transect_position), size=2) +
  #
  theme_classic()





