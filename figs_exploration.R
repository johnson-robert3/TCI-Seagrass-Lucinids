#--
# Exploratory figures
#
#--


library(patchwork)


# Thalassia coverage along transects
windows(height=4, width=6)
ggplot(df %>%
         mutate(transect_distance_m = if_else(transect_position=="below", transect_distance_m * -1, transect_distance_m))) +
  # 
  geom_line(aes(x = transect_distance_m, y = cover_Tt, group = transect_id, color = site_location, linetype = transect_position)) +
  geom_point(aes(x = transect_distance_m, y = cover_Tt, color = site_location, shape = transect_position)) +
  #
  scale_x_continuous(name = "Distance (m)", limits = c(-10, 10), breaks = seq(-10, 10, 2)) +
  scale_y_continuous(name = "Thalassa % cover") +
  theme_classic()


# Total seagrass coverage along transects
windows(height=4, width=6)
ggplot(df %>%
         mutate(transect_distance_m = if_else(transect_position=="below", transect_distance_m * -1, transect_distance_m))) +
  # 
  geom_line(aes(x = transect_distance_m, y = cover_sg_tot, group = transect_id, color = site_location, linetype = transect_position)) +
  geom_point(aes(x = transect_distance_m, y = cover_sg_tot, color = site_location, shape = transect_position)) +
  #
  scale_x_continuous(name = "Distance (m)", limits = c(-10, 10), breaks = seq(-10, 10, 2)) +
  scale_y_continuous(name = "Thalassa % cover") +
  theme_classic()


# Live lucinids above vs below
windows(height=4, width=6)
ggplot(df %>%
         summarize(live_lucinids = sum(live_lucinids, na.rm=TRUE), .by = 'transect_position')) +
  #
  geom_col(aes(x = transect_position, y = live_lucinids, fill = transect_position)) +
  #
  theme_classic()


# Live lucinids by distance along transect
windows(height=4, width=6)
ggplot(df %>%
         summarize(live_lucinids = sum(live_lucinids), .by = c('transect_position', 'transect_distance_m')) %>%
         mutate(transect_distance_m = if_else(transect_position=="below", transect_distance_m * -1, transect_distance_m))) +
  # 
  geom_point(aes(x = transect_distance_m, y = live_lucinids, color = transect_position), size=2) +
  geom_line(aes(x = transect_distance_m, y = live_lucinids, color = transect_position, group = transect_position)) +
  #
  theme_classic()


# Dead lucinids by distance along transect
windows(height=4, width=6)
ggplot(df %>%
         summarize(dead_lucinids = sum(dead_lucinids), .by=c('transect_position', 'transect_distance_m')) %>%
         mutate(transect_distance_m = if_else(transect_position=="below", transect_distance_m * -1, transect_distance_m))) +
  # 
  geom_point(aes(x = transect_distance_m, y = dead_lucinids, color = transect_position), size=2) +
  geom_line(aes(x = transect_distance_m, y = dead_lucinids, color = transect_position, group = transect_position)) +
  #
  theme_classic()
 
  
# Live lucinids vs Thalassia cover (above erosion edges)
windows(height=4, width=6)
ggplot(df) +
  #
  geom_point(aes(x = cover_Tt, y = live_lucinids, color=transect_position), size=2) +
  #
  theme_classic()


# Live lucinids vs seagrass cover (above erosion edges)
windows(height=4, width=6)
ggplot(df) +
  #
  geom_point(aes(x = cover_sg_tot, y = live_lucinids, color=transect_position), size=2) +
  #
  theme_classic()




